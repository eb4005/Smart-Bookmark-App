# Deployment Checklist

Use this checklist to ensure everything is properly configured before deploying.

## ✅ Pre-Deployment Checklist

### Supabase Setup
- [ ] Created a Supabase project
- [ ] Ran the SQL script (`supabase-setup.sql`) to create tables and policies
- [ ] Enabled Realtime for the `bookmarks` table (Database > Replication)
- [ ] Enabled Google OAuth provider in Authentication > Providers
- [ ] Copied Supabase URL and anon key from project settings

### Google OAuth Setup
- [ ] Created/selected a project in Google Cloud Console
- [ ] Enabled Google+ API
- [ ] Created OAuth 2.0 Client ID (Web application)
- [ ] Added authorized redirect URIs:
  - [ ] `https://<your-project>.supabase.co/auth/v1/callback`
  - [ ] `http://localhost:3000/auth/callback` (for local dev)
- [ ] Copied Client ID and Client Secret
- [ ] Added credentials to Supabase Google provider settings

### Local Development
- [ ] Installed dependencies: `npm install`
- [ ] Created `.env.local` file
- [ ] Added `NEXT_PUBLIC_SUPABASE_URL` to `.env.local`
- [ ] Added `NEXT_PUBLIC_SUPABASE_ANON_KEY` to `.env.local`
- [ ] Tested locally: `npm run dev`
- [ ] Verified Google sign-in works
- [ ] Verified bookmark creation works
- [ ] Verified real-time updates work (open two tabs)
- [ ] Verified bookmark deletion works

### Git & GitHub
- [ ] Initialized git repository: `git init`
- [ ] Created `.gitignore` (ensure `.env.local` is ignored)
- [ ] Created GitHub repository
- [ ] Committed code: `git add .` and `git commit -m "Initial commit"`
- [ ] Pushed to GitHub: `git push -u origin main`

### Vercel Deployment
- [ ] Signed in to Vercel
- [ ] Imported GitHub repository
- [ ] Added environment variables in Vercel project settings:
  - [ ] `NEXT_PUBLIC_SUPABASE_URL`
  - [ ] `NEXT_PUBLIC_SUPABASE_ANON_KEY`
- [ ] Deployed the project
- [ ] Copied the Vercel deployment URL

### Post-Deployment
- [ ] Added Vercel URL to Google OAuth authorized redirect URIs:
  - [ ] `https://your-app.vercel.app/auth/callback`
- [ ] Tested Google sign-in on production
- [ ] Tested bookmark functionality on production
- [ ] Tested real-time updates on production
- [ ] Updated README.md with live URL and GitHub repo URL

## 🧪 Testing Checklist

### Functionality Tests
- [ ] Can sign in with Google
- [ ] Can add a bookmark with title and URL
- [ ] Bookmark appears immediately after creation
- [ ] Can open two tabs and see real-time sync
- [ ] Can delete a bookmark
- [ ] Deleted bookmark disappears from all tabs
- [ ] Can sign out
- [ ] Cannot see other users' bookmarks

### Browser Tests
- [ ] Chrome
- [ ] Firefox
- [ ] Safari
- [ ] Edge

### Mobile Tests
- [ ] iOS Safari
- [ ] Android Chrome

## 🐛 Common Issues & Solutions

### "Invalid API key" error
- **Solution:** Check environment variables in Vercel settings

### "redirect_uri_mismatch" error
- **Solution:** Verify redirect URI in Google Cloud Console matches exactly

### Bookmarks not appearing
- **Solution:** Check Supabase RLS policies and ensure table has correct permissions

### Real-time not working
- **Solution:** Verify Realtime is enabled for bookmarks table in Supabase

### Sign in redirects to localhost
- **Solution:** Check that redirect URL uses `window.location.origin` in SignInButton

## 📋 Submission Checklist

- [ ] Live Vercel URL is working
- [ ] GitHub repository is public
- [ ] README.md includes:
  - [ ] Live URL
  - [ ] GitHub repo link
  - [ ] Setup instructions
  - [ ] Problems encountered and solutions
- [ ] Can sign in with a test Google account
- [ ] All features work as expected

## 🎉 You're Done!

Once all checkboxes are complete, your Smart Bookmark Manager is ready for submission!
