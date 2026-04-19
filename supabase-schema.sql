-- =============================================
-- Entrepreneur Hub Bangladesh - Supabase Schema (Optimized)
-- =============================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 0. Helper function for updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- 1. Profiles Table (extends auth.users)
CREATE TABLE IF NOT EXISTS profiles (
    id UUID REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT,
    phone TEXT,
    avatar_url TEXT DEFAULT '/images/cp 1.avif',
    role TEXT DEFAULT 'user' CHECK (role IN ('user', 'entrepreneur')),
    -- Entrepreneur-specific fields
    business_name TEXT,
    category TEXT,
    district TEXT,
    bio TEXT,
    whatsapp_number TEXT,
    facebook_url TEXT,
    instagram_url TEXT,
    website_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TRIGGER update_profiles_modtime
    BEFORE UPDATE ON profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Auto-create profile when user signs up
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (id, name, email, phone, role)
    VALUES (
        NEW.id,
        COALESCE(NEW.raw_user_meta_data->>'name', NEW.raw_user_meta_data->>'full_name', 'User'),
        NEW.email,
        NEW.raw_user_meta_data->>'phone',
        COALESCE(NEW.raw_user_meta_data->>'role', 'user')
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Drop trigger if exists to avoid errors on reapplying
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


-- 2. Services Table
CREATE TABLE IF NOT EXISTS services (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES auth.users ON DELETE CASCADE NOT NULL,
    title TEXT NOT NULL,
    category TEXT NOT NULL,
    service_img TEXT,
    rating DECIMAL(2,1) DEFAULT 0,
    reviews_count INT DEFAULT 0,
    delivery_days INT DEFAULT 1,
    price INT NOT NULL,
    description TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TRIGGER update_services_modtime
    BEFORE UPDATE ON services
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- 3. Feed Posts Table
CREATE TABLE IF NOT EXISTS feed_posts (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES auth.users ON DELETE CASCADE NOT NULL,
    content TEXT NOT NULL,
    image TEXT,
    likes_count INT DEFAULT 0,
    comments_count INT DEFAULT 0,
    shares_count INT DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TRIGGER update_feed_posts_modtime
    BEFORE UPDATE ON feed_posts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- 4. Post Likes Table (New)
CREATE TABLE IF NOT EXISTS post_likes (
    post_id INT REFERENCES feed_posts(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (post_id, user_id)
);

-- 5. Post Comments Table (New)
CREATE TABLE IF NOT EXISTS post_comments (
    id SERIAL PRIMARY KEY,
    post_id INT REFERENCES feed_posts(id) ON DELETE CASCADE,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. Contact Submissions Table
CREATE TABLE IF NOT EXISTS contact_submissions (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    subject TEXT,
    message TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);


-- =============================================
-- ROW LEVEL SECURITY (RLS)
-- =============================================

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE services ENABLE ROW LEVEL SECURITY;
ALTER TABLE feed_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE post_likes ENABLE ROW LEVEL SECURITY;
ALTER TABLE post_comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE contact_submissions ENABLE ROW LEVEL SECURITY;

-- Profiles: everyone can read, users can update own
CREATE POLICY "Profiles are public" ON profiles FOR SELECT USING (true);
CREATE POLICY "Users can update own profile" ON profiles FOR UPDATE USING (auth.uid() = id);

-- Services: everyone can read, entrepreneurs can create/update/delete own
CREATE POLICY "Services are public" ON services FOR SELECT USING (true);
CREATE POLICY "Entrepreneurs can create services" ON services FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Owners can update own services" ON services FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Owners can delete own services" ON services FOR DELETE USING (auth.uid() = user_id);

-- Feed posts: everyone can read, auth users can create, owners can edit/delete
CREATE POLICY "Feed posts are public" ON feed_posts FOR SELECT USING (true);
CREATE POLICY "Auth users can create posts" ON feed_posts FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Owners can update own posts" ON feed_posts FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Owners can delete own posts" ON feed_posts FOR DELETE USING (auth.uid() = user_id);

-- Post Likes: anyone can see, auth users can like/unlike
CREATE POLICY "Post likes are public" ON post_likes FOR SELECT USING (true);
CREATE POLICY "Auth users can like" ON post_likes FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can unlike" ON post_likes FOR DELETE USING (auth.uid() = user_id);

-- Post Comments: anyone can see, auth users can comment, owners can delete
CREATE POLICY "Comments are public" ON post_comments FOR SELECT USING (true);
CREATE POLICY "Auth users can comment" ON post_comments FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Owners can delete own comments" ON post_comments FOR DELETE USING (auth.uid() = user_id);

-- Contact: anyone can submit
CREATE POLICY "Anyone can submit contact" ON contact_submissions FOR INSERT WITH CHECK (true);


-- =============================================
-- TRIGGER FUNCTIONS FOR COUNTS
-- =============================================

-- Update likes_count in feed_posts
CREATE OR REPLACE FUNCTION update_post_likes_count()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        UPDATE feed_posts SET likes_count = likes_count + 1 WHERE id = NEW.post_id;
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE feed_posts SET likes_count = likes_count - 1 WHERE id = OLD.post_id;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER on_post_like_change
    AFTER INSERT OR DELETE ON post_likes
    FOR EACH ROW EXECUTE FUNCTION update_post_likes_count();

-- Update comments_count in feed_posts
CREATE OR REPLACE FUNCTION update_post_comments_count()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        UPDATE feed_posts SET comments_count = comments_count + 1 WHERE id = NEW.post_id;
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE feed_posts SET comments_count = comments_count - 1 WHERE id = OLD.post_id;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER on_post_comment_change
    AFTER INSERT OR DELETE ON post_comments
    FOR EACH ROW EXECUTE FUNCTION update_post_comments_count();
