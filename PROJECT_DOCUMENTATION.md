# Entrepreneur Hub Bangladesh - Project Code Documentation

## 1. Project Overview

Entrepreneur Hub Bangladesh is currently implemented as a static marketplace page for showcasing entrepreneur services. The repository contains:

- A single HTML page: `index.html`
- One stylesheet: `style.css`
- Local image assets for the logo, hero/banner, service cards, and profile avatars
- A Supabase PostgreSQL schema: `supabase-schema.sql`
- A Vercel deployment configuration: `vercel.json`
- A feature description text file: `project_features.txt`

The current frontend does not use React, Vite, npm, or JavaScript modules. It is a plain HTML and CSS project with Font Awesome loaded from a CDN.

## 2. Technology Stack

### Current Implemented Stack

- HTML5 for page structure
- CSS3 for styling and layout
- Font Awesome CDN for icons
- Local static images for marketplace visuals
- Supabase PostgreSQL schema for planned backend data storage
- Vercel configuration for planned hosting

### Mentioned But Not Present in Current Code

The `project_features.txt` file mentions React, Vite, and React Router, but the repository does not currently include:

- `package.json`
- `frontend/` directory
- React source files
- Vite configuration
- Router files
- JavaScript application logic

## 3. Project File Structure

```text
ehubbd-main/
  .gitignore
  index.html
  style.css
  supabase-schema.sql
  vercel.json
  project_features.txt
  banner.png
  logo.png
  logo 2.png
  card 1.webp
  card 2.webp
  card 3.webp
  card 4.webp
  card 4 banner.jpg
  card 5.jpg
  card 5 cp.jpg
  card 6.webp
  card 6 cp.jpg
  charu add cp 2.jpg
  charu adda dp.jpg
  cp 1.avif
  cp 2.jpg
  cp 3.jpg
  cp 4.avif
  cp 5.avif
  cp 6.avif
```

## 4. How To Run Locally

Because the project is static HTML/CSS, it can be opened directly in a browser.

### Option 1: Open Directly

Open `index.html` in any modern browser.

### Option 2: Serve With A Static Server

If you want local HTTP behavior, use any static server from the project root.

Example with Python:

```bash
python -m http.server 8000
```

Then visit:

```text
http://localhost:8000
```

No dependency installation is required for the current code.

## 5. Frontend Code Documentation

### 5.1 `index.html`

`index.html` is the main and only implemented page in the current project.

It contains these major sections:

1. Document head
2. Header and navigation
3. Marketplace title and category filters
4. Banner image area
5. Service cards grid
6. Footer

### 5.2 Document Head

The `<head>` defines:

- UTF-8 character encoding
- Responsive viewport settings
- Page title: `Entrepreneur Hub Bangladesh`
- Local stylesheet: `style.css`
- Font Awesome CDN stylesheet

Important dependencies:

```html
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
```

Font Awesome is required for icons such as:

- Search icon
- Verified user icon
- Star rating icon
- Clock icon

### 5.3 Header And Navigation

The header uses the class:

```html
<header class="main-header">
```

Main child elements:

- `.nav-container`: flex wrapper for the whole header
- `.logo-section`: contains the logo image
- `.nav-links-center`: main navigation and search
- `.header-right`: wallet, message, notification, and profile controls

Navigation links:

```html
<a href="index.html" class="nav-item active">Marketplace</a>
<a href="feed.html" class="nav-item">Feed</a>
<a href="networking.html" class="nav-item">Networking</a>
```

Important note: `feed.html` and `networking.html` are linked, but those files are not currently present in the repository.

### 5.4 Marketplace Header Row

The marketplace title and category filters are inside:

```html
<div class="marketplace-row">
```

Title:

```html
<h1>Register as a Entrepreneur</h1>
```

Category filter links:

- All
- IT & Software
- Marketing
- Legal
- Consulting
- Design
- HealthCare

Current behavior: these filters are visual links only. There is no JavaScript filtering logic yet.

### 5.5 Main Grid Layout

The main marketplace content is wrapped in:

```html
<div class="main-grid-layout">
```

It contains:

- `.banner-section`: left-side promotional image
- `.services-grid`: right-side grid of service cards

The layout is built with CSS flexbox:

```css
.main-grid-layout {
    display: flex;
    gap: 25px;
    margin-top: 20px;
    align-items: flex-start;
}
```

### 5.6 Banner Section

The banner section displays:

```html
<img src="banner.png" alt="Entrepreneur Banner" class="full-banner-img">
```

The banner is inside a rounded container with subtle shadow styling.

### 5.7 Service Cards

The services are hard-coded in `index.html`. Each service uses the same card structure:

```html
<div class="service-card">
    <div class="service-img-container">
        <img src="..." alt="Service" class="service-main-img">
        <span class="category-tag">...</span>
    </div>
    <div class="card-details">
        <div class="user-info">
            <img src="..." alt="User" class="user-avatar">
            <span class="user-name">...</span>
        </div>
        <h3 class="service-title">...</h3>
        <p class="rating">...</p>
        <hr class="card-divider">
        <div class="card-footer">...</div>
    </div>
</div>
```

Current service cards:

| # | Provider | Category | Service | Rating | Delivery | Price |
|---|----------|----------|---------|--------|----------|-------|
| 1 | Ariful Islam | IT & Software | E-commerce Website Development | 5 | 15 Days | Tk 35,000 |
| 2 | Charu Adda | Food | Food & Catering service | 4.7 | 7 Days | Tk 15,000 |
| 3 | Ziaur Rahman | Design | Professional UI/UX Design (Mobile App) | 4.9 | 10 Days | Tk 12,000 |
| 4 | Rajshahi Online Bazar | Food & Grocery | Grocery & Vegetables | 5 | 15 Days | Tk 5,000 |
| 5 | Pastry Shop & Chocolate Bazar | Food | Pastry & Chocolate Delivary | 5 | 15 Days | Tk 25,000 |
| 6 | Life Okey Shop | Shopping & Retail | Garments & Shopping | 4.9 | 10 Days | Tk 15,000 |

Note: The source HTML currently displays the currency symbol as mojibake text (`à§³`), which likely means the intended Bangladeshi Taka symbol was encoded incorrectly.

### 5.8 Footer

The footer uses:

```html
<footer class="main-footer">
```

It includes:

- Copyright text
- About link
- Privacy Policy link
- Contact Us link

The footer links currently use `href="#"`, so they do not navigate to implemented pages.

## 6. CSS Code Documentation

### 6.1 Global Reset

The CSS begins with a global reset:

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}
```

This normalizes spacing and uses `border-box` sizing across all elements.

### 6.2 Header Styling

Key classes:

- `.main-header`: sticky white header with bottom border
- `.nav-container`: flex layout for logo, nav, and right controls
- `.main-logo`: controls logo height
- `.nav-links-center`: center navigation group
- `.nav-item`: individual navigation link style
- `.nav-search`: search input wrapper
- `.header-right`: right-side actions
- `.profile-section`: profile avatar and label

The header is sticky:

```css
.main-header {
    position: sticky;
    top: 0;
    z-index: 1000;
}
```

### 6.3 Marketplace Layout Styling

Important layout classes:

- `.content-wrapper`
- `.marketplace-row`
- `.categories-section`
- `.main-grid-layout`
- `.banner-section`
- `.services-grid`

The services grid uses three equal columns:

```css
.services-grid {
    flex: 1;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
}
```

Important note: there are no responsive media queries in the current `style.css`, so the layout may not adapt well on smaller screens.

### 6.4 Service Card Styling

Important classes:

- `.service-card`: card wrapper
- `.service-img-container`: image area
- `.service-main-img`: service image
- `.category-tag`: category badge
- `.card-details`: text content area
- `.user-info`: provider details row
- `.user-avatar`: circular profile image
- `.service-title`: fixed-height service title
- `.rating`: star rating
- `.card-footer`: delivery and price row

Hover effect:

```css
.service-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 15px rgba(0,0,0,0.1);
}
```

### 6.5 Footer Styling

Footer classes:

- `.main-footer`
- `.footer-container`
- `.footer-links`

Footer links use the same orange hover color as the navigation.

## 7. Supabase Database Documentation

The database schema is defined in `supabase-schema.sql`.

### 7.1 Extension

The schema enables UUID support:

```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
```

### 7.2 Shared `updated_at` Trigger Function

The function `update_updated_at_column()` automatically updates an `updated_at` timestamp before row updates.

Tables using this function:

- `profiles`
- `services`
- `feed_posts`

### 7.3 `profiles` Table

Purpose: stores user profile data and entrepreneur profile fields.

Primary key:

- `id UUID`, referencing `auth.users`

Important columns:

- `name`
- `email`
- `phone`
- `avatar_url`
- `role`
- `business_name`
- `category`
- `district`
- `bio`
- `whatsapp_number`
- `facebook_url`
- `instagram_url`
- `website_url`
- `created_at`
- `updated_at`

Allowed roles:

```sql
CHECK (role IN ('user', 'entrepreneur', 'admin'))
```

### 7.4 New User Profile Trigger

The function `public.handle_new_user()` creates a profile automatically when a new Supabase Auth user is inserted.

Trigger:

```sql
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
```

### 7.5 `services` Table

Purpose: stores marketplace service listings.

Important columns:

- `id`
- `user_id`
- `title`
- `category`
- `service_img`
- `rating`
- `reviews_count`
- `delivery_days`
- `price`
- `description`
- `created_at`
- `updated_at`

Relationship:

- `user_id` references `auth.users`

### 7.6 `feed_posts` Table

Purpose: stores social feed posts from users or entrepreneurs.

Important columns:

- `id`
- `user_id`
- `content`
- `image`
- `likes_count`
- `comments_count`
- `shares_count`
- `created_at`
- `updated_at`

Relationship:

- `user_id` references `profiles(id)`

### 7.7 `post_likes` Table

Purpose: stores likes for feed posts.

Primary key:

- Composite key: `(post_id, user_id)`

This prevents the same user from liking the same post multiple times.

### 7.8 `post_comments` Table

Purpose: stores comments on feed posts.

Important columns:

- `id`
- `post_id`
- `user_id`
- `content`
- `created_at`

### 7.9 `contact_submissions` Table

Purpose: stores contact form submissions.

Important columns:

- `id`
- `name`
- `email`
- `subject`
- `message`
- `created_at`

### 7.10 Row Level Security

RLS is enabled on:

- `profiles`
- `services`
- `feed_posts`
- `post_likes`
- `post_comments`
- `contact_submissions`

Policies include:

- Public read access for profiles, services, feed posts, likes, and comments
- Users can update their own profile
- Authenticated users can create posts, likes, and comments
- Service owners can update and delete their own services
- Post owners can update and delete their own posts
- Anyone can submit contact messages

### 7.11 Count Triggers

The schema includes trigger functions to maintain post counts:

- `update_post_likes_count()`
- `update_post_comments_count()`

Triggers:

- `on_post_like_change`
- `on_post_comment_change`

These increment or decrement `likes_count` and `comments_count` when likes or comments are inserted or deleted.

## 8. Deployment Documentation

The project includes `vercel.json`:

```json
{
  "version": 2,
  "buildCommand": "cd frontend && npm install && npm run build",
  "outputDirectory": "frontend/dist",
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ]
}
```

Important issue: this configuration expects a `frontend/` folder with an npm project. That folder does not exist in the current repository.

For the current static version, Vercel should be configured as a static site with:

- No build command
- Output directory set to project root, or no output directory depending on Vercel settings

Alternative `vercel.json` for the current project:

```json
{
  "version": 2,
  "rewrites": [
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ]
}
```

## 9. Current Limitations And Gaps

1. No JavaScript behavior is implemented.
2. Search input is visual only.
3. Category filters are visual only.
4. Marketplace cards are hard-coded in HTML.
5. `feed.html` is linked but missing.
6. `networking.html` is linked but missing.
7. Footer links are placeholders.
8. Supabase schema exists, but the frontend is not connected to Supabase.
9. Vercel config currently targets a missing `frontend/` app.
10. The CSS does not include mobile responsive media queries.
11. Some Bangla/Taka characters appear incorrectly encoded.
12. `project_features.txt` appears to contain mojibake text and does not fully match the current codebase.

## 10. Recommended Next Development Steps

### Short-Term Fixes

1. Fix text encoding issues in `index.html`, `style.css`, and `project_features.txt`.
2. Add responsive CSS media queries for tablet and mobile.
3. Remove or update links to missing pages.
4. Update `vercel.json` to match the current static project.
5. Correct spelling such as `Delivary` to `Delivery`.

### Medium-Term Improvements

1. Add JavaScript for category filtering.
2. Add search functionality.
3. Move hard-coded services into a data file or backend table.
4. Create separate pages for Feed and Networking.
5. Add contact, privacy, and about pages.

### Backend Integration

1. Create a Supabase project.
2. Run `supabase-schema.sql` in the Supabase SQL editor.
3. Add Supabase client JavaScript.
4. Fetch services from the `services` table.
5. Connect authentication to the `profiles` table.
6. Implement creating, editing, and deleting services for entrepreneurs.

## 11. Suggested Data Flow For Future Dynamic Version

```text
User opens marketplace
  -> Frontend loads index page
  -> JavaScript initializes Supabase client
  -> Services are fetched from services table
  -> Provider profile data is joined from profiles table
  -> Cards are rendered dynamically
  -> Search and category filters update visible cards
```

## 12. Maintenance Notes

- Keep image filenames consistent and avoid spaces in new asset names when possible.
- Store repeated service data in a database or JSON file instead of duplicating HTML.
- Keep frontend code and deployment config aligned. If the project remains static, do not use a Vite-specific Vercel build command.
- Add responsive breakpoints before publishing for mobile users.
- Keep Supabase RLS policies enabled before exposing the app publicly.

