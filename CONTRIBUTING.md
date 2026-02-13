# Contributing to Smart Bookmark Manager

## Development Setup

1. Fork the repository
2. Clone your fork: `git clone https://github.com/yourusername/smart-bookmark-app.git`
3. Install dependencies: `npm install`
4. Set up environment variables (see [QUICKSTART.md](./QUICKSTART.md))
5. Run locally: `npm run dev`

## Project Structure

```
smart-bookmark-app/
├── app/                    # Next.js App Router
│   ├── auth/              # Authentication routes
│   ├── login/             # Login page
│   ├── globals.css        # Global styles
│   ├── layout.tsx         # Root layout
│   └── page.tsx           # Home page
├── components/            # React components
│   ├── AddBookmark.tsx   # Bookmark form
│   ├── BookmarkList.tsx  # Bookmark list with realtime
│   ├── SignInButton.tsx  # Google OAuth button
│   └── SignOutButton.tsx # Sign out button
├── lib/                   # Utilities
│   └── supabase/         # Supabase clients
└── middleware.ts          # Auth middleware
```

## Code Style

- Use TypeScript for all new files
- Follow the existing code structure
- Use functional components with hooks
- Use Tailwind CSS for styling
- Keep components small and focused

## Adding Features

### Example: Adding Tags to Bookmarks

1. **Update Database Schema:**
   ```sql
   alter table bookmarks add column tags text[];
   ```

2. **Update TypeScript Types:**
   ```typescript
   interface Bookmark {
     id: string
     user_id: string
     url: string
     title: string
     tags?: string[]
     created_at: string
   }
   ```

3. **Update Components:**
   - Add tags input to `AddBookmark.tsx`
   - Display tags in `BookmarkList.tsx`

4. **Test:**
   - Add bookmark with tags
   - Verify real-time updates include tags
   - Check RLS still works

## Testing

Before submitting a PR:

1. Test locally with `npm run dev`
2. Test authentication flow
3. Test bookmark CRUD operations
4. Test real-time updates (open two tabs)
5. Check browser console for errors
6. Verify TypeScript compiles: `npm run build`

## Submitting Changes

1. Create a feature branch: `git checkout -b feature/my-feature`
2. Make your changes
3. Commit: `git commit -m "Add feature: description"`
4. Push: `git push origin feature/my-feature`
5. Open a Pull Request

## Feature Ideas

- 🏷️ Tags and categories
- 🔍 Search functionality
- 📁 Folders/collections
- 🌟 Favorites/starred bookmarks
- 📊 Analytics (most visited, etc.)
- 🔗 URL preview/metadata
- 📱 PWA support
- 🌙 Dark mode
- ⌨️ Keyboard shortcuts
- 📤 Import/export bookmarks
- 🔔 Browser extension

## Questions?

Feel free to open an issue for any questions or suggestions!
