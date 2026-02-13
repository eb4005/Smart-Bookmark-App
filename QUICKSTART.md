# Quick Start Guide

Get your Smart Bookmark Manager up and running in 15 minutes!

## 🚀 Super Quick Setup (TL;DR)

```bash
# 1. Clone and install
git clone <your-repo>
cd smart-bookmark-app
npm install

# 2. Set up environment variables
cp .env.local.example .env.local
# Edit .env.local with your Supabase credentials

# 3. Run locally
npm run dev
```

Then follow the detailed steps below for Supabase and Google OAuth setup.

## 📝 Step-by-Step Setup

### Step 1: Create Supabase Project (5 minutes)

1. Go to [supabase.com](https://supabase.com) and sign up/sign in
2. Click "New Project"
3. Fill in:
   - Name: `smart-bookmark-manager`
   - Database Password: (generate a strong password)
   - Region: (choose closest to you)
4. Click "Create new project" and wait ~2 minutes

### Step 2: Set Up Database (2 minutes)

1. In your Supabase project, click "SQL Editor" in the sidebar
2. Click "New Query"
3. Copy the entire contents of `supabase-setup.sql`
4. Paste and click "Run"
5. You should see "Success. No rows returned"

### Step 3: Enable Realtime (1 minute)

1. Go to "Database" > "Replication" in the sidebar
2. Scroll to find the `bookmarks` table
3. Toggle the switch to enable Realtime
4. You should see a green checkmark

### Step 4: Set Up Google OAuth (5 minutes)

1. Go to [console.cloud.google.com](https://console.cloud.google.com)
2. Create a new project or select existing
3. Click "APIs & Services" > "Credentials"
4. Click "Create Credentials" > "OAuth client ID"
5. If prompted, configure OAuth consent screen:
   - User Type: External
   - App name: Smart Bookmark Manager
   - User support email: (your email)
   - Developer contact: (your email)
   - Click "Save and Continue" through all steps
6. Back to "Create OAuth client ID":
   - Application type: Web application
   - Name: Smart Bookmark Manager
   - Authorized redirect URIs:
     - Add `http://localhost:3000/auth/callback`
     - Add `https://<YOUR-PROJECT-ID>.supabase.co/auth/v1/callback`
       (Replace <YOUR-PROJECT-ID> with your actual Supabase project ID)
7. Click "Create"
8. Copy the "Client ID" and "Client Secret"

### Step 5: Configure Supabase Auth (2 minutes)

1. In Supabase, go to "Authentication" > "Providers"
2. Find "Google" and click to expand
3. Toggle "Enable Sign in with Google"
4. Paste your Client ID
5. Paste your Client Secret
6. Click "Save"

### Step 6: Get Supabase Credentials (1 minute)

1. In Supabase, go to "Settings" > "API"
2. Find "Project URL" - copy this
3. Find "Project API keys" > "anon public" - copy this

### Step 7: Configure Local Environment (1 minute)

1. In your project folder, copy `.env.local.example` to `.env.local`
2. Edit `.env.local`:
   ```env
   NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key-here
   ```
3. Paste your Project URL and anon key
4. Save the file

### Step 8: Run Locally (1 minute)

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000)

Click "Continue with Google" and test!

## 🌐 Deploy to Vercel (10 minutes)

### Step 1: Push to GitHub

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/yourusername/smart-bookmark-app.git
git push -u origin main
```

### Step 2: Deploy on Vercel

1. Go to [vercel.com](https://vercel.com) and sign in with GitHub
2. Click "Add New..." > "Project"
3. Import your `smart-bookmark-app` repository
4. In "Environment Variables", add:
   - `NEXT_PUBLIC_SUPABASE_URL` = (your Supabase URL)
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY` = (your anon key)
5. Click "Deploy"
6. Wait ~2 minutes
7. Copy your deployment URL (e.g., `https://smart-bookmark-app.vercel.app`)

### Step 3: Update Google OAuth

1. Go back to [Google Cloud Console](https://console.cloud.google.com)
2. Go to "APIs & Services" > "Credentials"
3. Click on your OAuth 2.0 Client ID
4. Under "Authorized redirect URIs", click "Add URI"
5. Add: `https://your-app.vercel.app/auth/callback`
6. Click "Save"

### Step 4: Test Production

1. Visit your Vercel URL
2. Click "Continue with Google"
3. Add a bookmark
4. Open in two tabs and verify real-time sync
5. Done! 🎉

## 🎯 What You Should See

### Login Page
- Clean login UI with Google sign-in button
- Feature list

### Home Page (After Login)
- Welcome message with your email
- Form to add bookmarks (Title + URL)
- List of your bookmarks
- Delete buttons for each bookmark
- Sign Out button

### Real-time Test
- Open the app in two browser tabs
- Add a bookmark in Tab 1
- See it instantly appear in Tab 2
- Delete in Tab 2
- See it disappear in Tab 1

## ❓ Troubleshooting

### "Invalid API key"
- Check your `.env.local` file
- Verify credentials are correct in Supabase > Settings > API

### Can't sign in with Google
- Check redirect URI in Google Cloud Console
- Should be: `https://<project>.supabase.co/auth/v1/callback`
- Find your project ID in Supabase URL

### Bookmarks don't appear
- Check Supabase SQL Editor - run `SELECT * FROM bookmarks`
- Verify RLS policies are created
- Check browser console for errors

### Real-time doesn't work
- Verify Realtime is enabled: Database > Replication
- Check bookmarks table has green checkmark

### Port 3000 already in use
```bash
# Use a different port
npm run dev -- -p 3001
```

## 📚 Next Steps

- ✅ Read the full [README.md](./README.md) for detailed documentation
- ✅ Check [DEPLOYMENT.md](./DEPLOYMENT.md) for complete deployment checklist
- ✅ Customize the UI with Tailwind CSS
- ✅ Add more features (tags, search, folders, etc.)

## 🆘 Need Help?

Check the "Problems Encountered and Solutions" section in the [README.md](./README.md) for common issues and fixes.

---

Happy coding! 🚀
