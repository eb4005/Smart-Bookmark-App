# Quick Reference Card

## 🚀 Essential Commands

```bash
# Initial Setup
npm install                  # Install dependencies
cp .env.local.example .env.local  # Create environment file
npm run dev                  # Start development server

# Development
npm run dev                  # Run locally (http://localhost:3000)
npm run build               # Build for production
npm run start               # Start production server
npm run lint                # Run ESLint
npm run type-check          # Check TypeScript

# Git
git init                    # Initialize repository
git add .                   # Stage all files
git commit -m "message"     # Commit changes
git push origin main        # Push to GitHub
```

## 🔑 Environment Variables

```env
NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=xxxxx
```

## 📦 Important Files

| File | Purpose |
|------|---------|
| `.env.local` | Environment variables (create from template) |
| `supabase-setup.sql` | Run this in Supabase SQL Editor |
| `README.md` | Main documentation |
| `QUICKSTART.md` | Fast setup guide |
| `TROUBLESHOOTING.md` | Problem solving |

## 🔗 Important URLs

```
Local:       http://localhost:3000
Supabase:    https://supabase.com/dashboard
Google:      https://console.cloud.google.com
Vercel:      https://vercel.com/dashboard
```

## 🗄️ Database Setup (Supabase)

1. Create new project
2. Go to SQL Editor
3. Paste contents of `supabase-setup.sql`
4. Run
5. Go to Database > Replication
6. Enable Realtime for `bookmarks` table

## 🔐 Google OAuth Setup

1. Go to console.cloud.google.com
2. Create OAuth Client ID (Web application)
3. Add redirect URIs:
   - `http://localhost:3000/auth/callback`
   - `https://<PROJECT>.supabase.co/auth/v1/callback`
   - `https://your-app.vercel.app/auth/callback`
4. Copy Client ID and Secret to Supabase

## 🌐 Vercel Deployment

1. Push to GitHub
2. Import on Vercel
3. Add environment variables:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
4. Deploy
5. Update Google OAuth redirect URIs

## 🧪 Quick Test

1. Sign in with Google
2. Add bookmark: Title="Test" URL="https://example.com"
3. Open in new tab - should see bookmark
4. Delete bookmark - should disappear in both tabs

## 🐛 Common Issues

| Problem | Solution |
|---------|----------|
| Can't sign in | Check Google OAuth redirect URI |
| No bookmarks appear | Check RLS policies in Supabase |
| Real-time not working | Enable Realtime in Database > Replication |
| Build fails | Run `npm run build` locally to debug |
| Env vars not working | Check they start with `NEXT_PUBLIC_` |

## 📋 Pre-Submission Checklist

- [ ] App works locally
- [ ] Deployed on Vercel
- [ ] Google OAuth works
- [ ] Real-time sync works
- [ ] GitHub repo is public
- [ ] README has live URL
- [ ] README has problems section

## 📚 Documentation Order

1. **PROJECT-OVERVIEW.md** - Start here
2. **QUICKSTART.md** - Setup in 15 minutes
3. **README.md** - Complete documentation
4. **DEPLOYMENT.md** - Deployment steps
5. **TESTING.md** - Test everything
6. **TROUBLESHOOTING.md** - Fix issues
7. **SUBMISSION.md** - Final checklist

## 🎯 File Structure

```
smart-bookmark-app/
├── app/              # Next.js pages
├── components/       # React components  
├── lib/             # Utilities
├── *.md             # Documentation
├── *.sql            # Database setup
├── package.json     # Dependencies
└── .env.local       # Config (create this!)
```

## ⚡ Speed Run (Experienced Developers)

```bash
# 1. Setup
npm install && cp .env.local.example .env.local

# 2. Configure .env.local with Supabase credentials

# 3. Run supabase-setup.sql in Supabase

# 4. Enable Realtime for bookmarks table

# 5. Configure Google OAuth

# 6. Start
npm run dev

# 7. Deploy
git init && git add . && git commit -m "init"
# Push to GitHub, deploy on Vercel
```

## 🎓 Key Concepts

- **App Router**: Next.js 14 routing system
- **RLS**: Row Level Security in Supabase
- **SSR**: Server-side rendering with cookies
- **Realtime**: WebSocket subscriptions
- **OAuth**: Google authentication flow

## 📞 Get Help

1. Check browser console (F12)
2. Check Supabase logs
3. Review TROUBLESHOOTING.md
4. Verify environment variables
5. Test with fresh browser/incognito

---

Keep this card handy while developing! 🚀
