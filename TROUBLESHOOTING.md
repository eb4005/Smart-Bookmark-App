# Troubleshooting Guide

Common issues and their solutions.

## 🔐 Authentication Issues

### Problem: "redirect_uri_mismatch" error

**Symptoms:** After clicking "Continue with Google", you see an error about redirect URI mismatch.

**Solution:**
1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Navigate to APIs & Services > Credentials
3. Click on your OAuth 2.0 Client ID
4. Check "Authorized redirect URIs"
5. Should include:
   - `http://localhost:3000/auth/callback` (for local)
   - `https://<PROJECT>.supabase.co/auth/v1/callback` (replace <PROJECT>)
   - `https://your-app.vercel.app/auth/callback` (for production)
6. Make sure there are no typos or extra spaces
7. Click "Save"
8. Wait 5 minutes for changes to propagate

### Problem: Stuck in redirect loop

**Symptoms:** After signing in, keeps redirecting between pages.

**Solution:**
1. Clear browser cookies and cache
2. Check middleware.ts is correct
3. Verify environment variables are set
4. Check Supabase project is active
5. Try incognito/private browsing mode

### Problem: "Invalid API key" error

**Symptoms:** Console shows "Invalid API key" or "supabase client error".

**Solution:**
1. Check `.env.local` exists and has correct values
2. Verify `NEXT_PUBLIC_SUPABASE_URL` format: `https://xxx.supabase.co`
3. Verify `NEXT_PUBLIC_SUPABASE_ANON_KEY` is the anon/public key (not service key)
4. Restart dev server: `npm run dev`
5. For Vercel: Check environment variables in project settings

### Problem: User stays signed out after Google OAuth

**Symptoms:** OAuth succeeds but user not signed in.

**Solution:**
1. Check `/auth/callback/route.ts` exists
2. Verify callback URL in Supabase Auth settings
3. Check browser console for errors
4. Verify cookies are enabled in browser
5. Try different browser

## 📊 Database Issues

### Problem: "relation 'bookmarks' does not exist"

**Symptoms:** Error when trying to fetch or create bookmarks.

**Solution:**
1. Go to Supabase SQL Editor
2. Run the complete `supabase-setup.sql` script
3. Check table was created: `SELECT * FROM bookmarks`
4. Verify table name is exactly `bookmarks` (lowercase)

### Problem: Bookmarks not appearing

**Symptoms:** Can create bookmarks but don't see them in list.

**Solution:**
1. Check Supabase Table Editor > bookmarks
2. Verify data is being inserted
3. Check RLS policies are created:
   ```sql
   SELECT * FROM pg_policies WHERE tablename = 'bookmarks';
   ```
4. Verify user_id matches in database and app
5. Check browser console for errors

### Problem: "new row violates row-level security policy"

**Symptoms:** Error when trying to insert/update/delete bookmarks.

**Solution:**
1. Verify RLS policies exist (see above)
2. Check policies allow the operation
3. Verify auth.uid() returns valid user ID
4. Test query in SQL Editor:
   ```sql
   SELECT auth.uid(); -- Should return UUID
   ```
5. Re-run RLS policy creation from `supabase-setup.sql`

### Problem: Can see other users' bookmarks

**Symptoms:** Privacy violation - seeing bookmarks from other accounts.

**Solution:**
1. This is a CRITICAL security issue
2. Verify RLS is enabled:
   ```sql
   SELECT tablename, rowsecurity 
   FROM pg_tables 
   WHERE tablename = 'bookmarks';
   ```
3. Verify filter in real-time subscription includes `user_id`
4. Check policies filter by `auth.uid() = user_id`

## 🔄 Real-time Issues

### Problem: Real-time updates not working

**Symptoms:** Changes don't appear in other tabs instantly.

**Solution:**
1. Go to Supabase > Database > Replication
2. Verify `bookmarks` table has Realtime enabled (green checkmark)
3. Check browser console for subscription errors
4. Verify filter in subscription: `filter: 'user_id=eq.${userId}'`
5. Check Supabase project is not paused
6. Try refreshing the page

### Problem: "Failed to subscribe to channel"

**Symptoms:** Console shows subscription error.

**Solution:**
1. Check Supabase project is active (not paused)
2. Verify Realtime is enabled for table
3. Check internet connection
4. Verify anon key is correct
5. Check Supabase status page: https://status.supabase.com

### Problem: Duplicate bookmarks appearing

**Symptoms:** Same bookmark appears multiple times.

**Solution:**
1. Check for duplicate subscription setup
2. Verify cleanup in useEffect:
   ```typescript
   return () => {
     supabase.removeChannel(channel)
   }
   ```
3. Clear bookmarks: `DELETE FROM bookmarks WHERE user_id = 'your-id'`
4. Restart application

## 🎨 UI/Display Issues

### Problem: Styles not loading

**Symptoms:** Page looks unstyled or plain HTML.

**Solution:**
1. Check `app/globals.css` is imported in `layout.tsx`
2. Verify Tailwind config exists: `tailwind.config.js`
3. Check PostCSS config exists: `postcss.config.js`
4. Restart dev server
5. Run `npm install` again
6. Clear Next.js cache: `rm -rf .next`

### Problem: Layout broken on mobile

**Symptoms:** UI doesn't work on small screens.

**Solution:**
1. Add viewport meta tag in layout (should be automatic with Next.js)
2. Check responsive Tailwind classes (`sm:`, `md:`, `lg:`)
3. Test with Chrome DevTools responsive mode
4. Verify max-width classes are working

## 🚀 Deployment Issues

### Problem: Vercel build fails

**Symptoms:** Deployment fails with build errors.

**Solution:**
1. Check build locally: `npm run build`
2. Fix any TypeScript errors
3. Verify all dependencies are in `package.json`
4. Check Node.js version (should be 18+)
5. Review Vercel build logs for specific error

### Problem: Environment variables not working on Vercel

**Symptoms:** App works locally but not on Vercel.

**Solution:**
1. Go to Vercel project settings
2. Click "Environment Variables"
3. Add variables:
   - Name: `NEXT_PUBLIC_SUPABASE_URL`
   - Value: Your Supabase URL
4. Add second variable:
   - Name: `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - Value: Your anon key
5. Redeploy: Vercel > Deployments > Redeploy

### Problem: OAuth works locally but not on Vercel

**Symptoms:** Can sign in locally but not in production.

**Solution:**
1. Get your Vercel deployment URL
2. Go to Google Cloud Console > Credentials
3. Add to authorized redirect URIs:
   - `https://your-app.vercel.app/auth/callback`
4. Wait 5 minutes
5. Try again

## 🐛 Development Issues

### Problem: "Module not found" errors

**Symptoms:** Import errors when running app.

**Solution:**
1. Delete `node_modules`: `rm -rf node_modules`
2. Delete package-lock: `rm package-lock.json`
3. Clear npm cache: `npm cache clean --force`
4. Reinstall: `npm install`
5. Restart dev server

### Problem: TypeScript errors

**Symptoms:** Red underlines or build errors.

**Solution:**
1. Check `tsconfig.json` exists
2. Verify all `@types/*` packages are installed
3. Run type check: `npm run type-check`
4. Restart TypeScript server in VS Code: Cmd+Shift+P > "Restart TS Server"

### Problem: Hot reload not working

**Symptoms:** Changes don't appear without manual refresh.

**Solution:**
1. Check for syntax errors
2. Restart dev server
3. Clear `.next` folder: `rm -rf .next`
4. Check file is saved
5. Try different port: `npm run dev -- -p 3001`

## 📱 Browser-Specific Issues

### Problem: Works in Chrome but not Safari

**Symptoms:** App broken in Safari.

**Solution:**
1. Check Safari console for errors
2. Verify no modern JS features unsupported by Safari
3. Test cookies/localStorage work in Safari
4. Check CORS settings

### Problem: Works on desktop but not mobile

**Symptoms:** Mobile browser shows errors.

**Solution:**
1. Use mobile Chrome DevTools for debugging
2. Check touch events vs click events
3. Verify viewport meta tag
4. Test in actual device (not just DevTools)

## 🔍 Debugging Tips

### Enable Verbose Logging

Add to your components:

```typescript
useEffect(() => {
  console.log('Component mounted', { userId, bookmarks })
  
  return () => {
    console.log('Component unmounting')
  }
}, [userId, bookmarks])
```

### Check Supabase Connection

```typescript
const supabase = createClient()
const { data, error } = await supabase.auth.getSession()
console.log('Session:', data, 'Error:', error)
```

### Verify Environment Variables

```typescript
console.log('Supabase URL:', process.env.NEXT_PUBLIC_SUPABASE_URL)
console.log('Has anon key:', !!process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY)
```

### Check RLS Policies

In Supabase SQL Editor:

```sql
-- Check if RLS is enabled
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE tablename = 'bookmarks';

-- List all policies
SELECT * FROM pg_policies WHERE tablename = 'bookmarks';

-- Test as user
SELECT * FROM bookmarks WHERE user_id = auth.uid();
```

## 🆘 Still Stuck?

1. **Check browser console** - F12 > Console tab
2. **Check Supabase logs** - Supabase dashboard > Logs
3. **Check Vercel logs** - Vercel dashboard > Deployments > View logs
4. **Review all config files** - Make sure they match this guide
5. **Start fresh** - Sometimes easiest to delete and recreate

## 📚 Additional Resources

- [Next.js Documentation](https://nextjs.org/docs)
- [Supabase Documentation](https://supabase.com/docs)
- [Supabase Auth Helpers](https://supabase.com/docs/guides/auth/auth-helpers/nextjs)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [Vercel Documentation](https://vercel.com/docs)

---

If you encounter an issue not listed here, please document it in the README.md under "Problems Encountered and Solutions"!
