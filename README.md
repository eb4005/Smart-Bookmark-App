# Smart Bookmark Manager

A real-time bookmark manager built with Next.js 14, Supabase, and Tailwind CSS. Users can sign in with Google OAuth, add bookmarks, and see them sync in real-time across multiple tabs/devices.

##  Live Demo

**Live URL:** [https://smart-bookmark-app-woad-chi.vercel.app]

**GitHub Repository:** [https://github.com/eb4005/Smart-Bookmark-App]

##  Features

-  Google OAuth authentication (no email/password)
-  Add bookmarks with URL and title
-  Private bookmarks (users only see their own)
-  Real-time updates across multiple tabs
-  Delete bookmarks
-  Responsive design with Tailwind CSS
-  Deployed on Vercel

##  Tech Stack

- **Frontend:** Next.js 14 (App Router), React 18, TypeScript
- **Styling:** Tailwind CSS
- **Backend:** Supabase (Auth, Database, Realtime)
- **Deployment:** Vercel

##  Prerequisites

- Node.js 18+ and npm
- A Supabase account ([supabase.com](https://supabase.com))
- A Google Cloud project for OAuth ([console.cloud.google.com](https://console.cloud.google.com))
- A Vercel account for deployment ([vercel.com](https://vercel.com))

## Setup Instructions

### 1. Clone the Repository

```bash
git clone <your-repo-url>
cd smart-bookmark-app
npm install
```

### 2. Set Up Supabase

1. **Create a new Supabase project** at [supabase.com](https://supabase.com)

2. **Create the bookmarks table** by running this SQL in the Supabase SQL Editor:

```sql
-- Create bookmarks table
create table public.bookmarks (
  id uuid default gen_random_uuid() primary key,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  user_id uuid references auth.users(id) on delete cascade not null,
  url text not null,
  title text not null
);

-- Enable Row Level Security (RLS)
alter table public.bookmarks enable row level security;

-- Create policy: Users can view only their own bookmarks
create policy "Users can view their own bookmarks"
  on public.bookmarks for select
  using (auth.uid() = user_id);

-- Create policy: Users can insert their own bookmarks
create policy "Users can insert their own bookmarks"
  on public.bookmarks for insert
  with check (auth.uid() = user_id);

-- Create policy: Users can delete their own bookmarks
create policy "Users can delete their own bookmarks"
  on public.bookmarks for delete
  using (auth.uid() = user_id);

-- Create policy: Users can update their own bookmarks
create policy "Users can update their own bookmarks"
  on public.bookmarks for update
  using (auth.uid() = user_id);

-- Create index for better performance
create index bookmarks_user_id_idx on public.bookmarks(user_id);
```

3. **Enable Realtime** for the bookmarks table:
   - Go to Database > Replication in your Supabase dashboard
   - Find the `bookmarks` table and toggle Realtime to ON

### 3. Set Up Google OAuth

1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Create a new project or select an existing one
3. Enable the Google+ API
4. Go to "Credentials" → "Create Credentials" → "OAuth client ID"
5. Choose "Web application"
6. Add authorized redirect URIs:
   - `https://<your-project-ref>.supabase.co/auth/v1/callback`
   - `http://localhost:3000/auth/callback` (for local development)
7. Copy the **Client ID** and **Client Secret**

8. In Supabase:
   - Go to Authentication > Providers
   - Enable Google
   - Paste your Client ID and Client Secret
   - Save

### 4. Configure Environment Variables

1. Copy `.env.local.example` to `.env.local`:

```bash
cp .env.local.example .env.local
```

2. Fill in your Supabase credentials in `.env.local`:

```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

Find these values in your Supabase project settings under API.

### 5. Run Locally

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) to see the app.

### 6. Deploy to Vercel

1. Push your code to GitHub

2. Go to [vercel.com](https://vercel.com) and import your repository

3. Add environment variables in Vercel:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`

4. Deploy!

5. **Important:** After deployment, add your Vercel URL to Google OAuth:
   - Go back to Google Cloud Console
   - Add `https://your-app.vercel.app/auth/callback` to authorized redirect URIs

##  How It Works

### Authentication Flow

1. User clicks "Continue with Google" on `/login`
2. Redirected to Google OAuth consent screen
3. After approval, Google redirects to `/auth/callback`
4. Callback route exchanges the code for a session
5. User is redirected to the home page `/`

### Real-time Updates

The app uses Supabase Realtime to listen for database changes:

```typescript
supabase
  .channel('bookmarks-changes')
  .on('postgres_changes', {
    event: '*',
    schema: 'public',
    table: 'bookmarks',
    filter: `user_id=eq.${userId}`,
  }, (payload) => {
    // Update local state based on INSERT, UPDATE, or DELETE
  })
  .subscribe()
```

When you add or delete a bookmark in one tab, all other tabs automatically update.

### Security

- **Row Level Security (RLS)** ensures users can only access their own bookmarks
- Authentication is handled by Supabase Auth with Google OAuth
- All API requests are authenticated via HTTP-only cookies

## Problems Encountered and Solutions

### Problem 1: Authentication Session Management

**Issue:** Initially tried using `getSession()` which can return stale data in server components.

**Solution:** Switched to `getUser()` which validates the session on every request and is more reliable for server-side auth checks.

```typescript
//  Don't use this
const { data: { session } } = await supabase.auth.getSession()

// Use this instead
const { data: { user } } = await supabase.auth.getUser()
```

### Problem 2: Real-time Subscription Cleanup

**Issue:** Real-time subscriptions weren't being properly cleaned up, causing memory leaks and duplicate subscriptions.

**Solution:** Used React's cleanup function in `useEffect` to remove channels when component unmounts:

```typescript
useEffect(() => {
  const channel = supabase.channel('bookmarks-changes')
  // ... subscription setup
  
  return () => {
    supabase.removeChannel(channel)
  }
}, [userId, supabase])
```

### Problem 3: OAuth Redirect URL Mismatch

**Issue:** Google OAuth failing with "redirect_uri_mismatch" error.

**Solution:** Made sure the redirect URI in Google Cloud Console exactly matches what Supabase uses:
- Format: `https://<project-ref>.supabase.co/auth/v1/callback`
- Added both production and localhost URLs for development

### Problem 4: Cookie Handling in Middleware

**Issue:** Authentication state not persisting properly across requests.

**Solution:** Implemented proper cookie handling in middleware following Supabase SSR documentation:

```typescript
// middleware.ts handles both reading and writing cookies
const supabase = createServerClient(url, key, {
  cookies: {
    get(name) { /* read from request */ },
    set(name, value, options) { /* write to response */ },
    remove(name, options) { /* remove from response */ }
  }
})
```

### Problem 5: Real-time Filter Not Working

**Issue:** Users were seeing other users' bookmarks in real-time updates despite RLS policies.

**Solution:** Added user-specific filter to the Realtime subscription:

```typescript
.on('postgres_changes', {
  event: '*',
  schema: 'public',
  table: 'bookmarks',
  filter: `user_id=eq.${userId}`, // This was crucial!
}, (payload) => { ... })
```

### Problem 6: Vercel Environment Variables

**Issue:** App worked locally but failed on Vercel with "Invalid API key" errors.

**Solution:** Environment variables in Vercel must be added through the dashboard (not just in `.env.local`). Also ensured they start with `NEXT_PUBLIC_` to be accessible in client components.

##  Project Structure

```
smart-bookmark-app/
├── app/
│   ├── auth/
│   │   └── callback/
│   │       └── route.ts          # OAuth callback handler
│   ├── login/
│   │   └── page.tsx              # Login page
│   ├── globals.css               # Global styles
│   ├── layout.tsx                # Root layout
│   └── page.tsx                  # Home page (bookmarks)
├── components/
│   ├── AddBookmark.tsx           # Form to add bookmarks
│   ├── BookmarkList.tsx          # List with real-time updates
│   ├── SignInButton.tsx          # Google OAuth sign in
│   └── SignOutButton.tsx         # Sign out button
├── lib/
│   └── supabase/
│       ├── client.ts             # Browser Supabase client
│       └── server.ts             # Server Supabase client
├── middleware.ts                 # Auth middleware
├── next.config.js
├── tailwind.config.js
├── tsconfig.json
└── package.json
```

