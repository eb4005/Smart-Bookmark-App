-- Smart Bookmark Manager - Supabase Setup Script
-- Run this in your Supabase SQL Editor

-- ============================================
-- 1. CREATE BOOKMARKS TABLE
-- ============================================

create table public.bookmarks (
  id uuid default gen_random_uuid() primary key,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  user_id uuid references auth.users(id) on delete cascade not null,
  url text not null,
  title text not null
);

-- ============================================
-- 2. ENABLE ROW LEVEL SECURITY (RLS)
-- ============================================

alter table public.bookmarks enable row level security;

-- ============================================
-- 3. CREATE RLS POLICIES
-- ============================================

-- Policy: Users can view only their own bookmarks
create policy "Users can view their own bookmarks"
  on public.bookmarks for select
  using (auth.uid() = user_id);

-- Policy: Users can insert their own bookmarks
create policy "Users can insert their own bookmarks"
  on public.bookmarks for insert
  with check (auth.uid() = user_id);

-- Policy: Users can delete their own bookmarks
create policy "Users can delete their own bookmarks"
  on public.bookmarks for delete
  using (auth.uid() = user_id);

-- Policy: Users can update their own bookmarks
create policy "Users can update their own bookmarks"
  on public.bookmarks for update
  using (auth.uid() = user_id);

-- ============================================
-- 4. CREATE INDEXES FOR PERFORMANCE
-- ============================================

create index bookmarks_user_id_idx on public.bookmarks(user_id);
create index bookmarks_created_at_idx on public.bookmarks(created_at desc);

-- ============================================
-- 5. VERIFY SETUP
-- ============================================

-- Check if table was created
select 
  tablename, 
  rowsecurity 
from pg_tables 
where tablename = 'bookmarks';

-- Check policies
select 
  policyname,
  permissive,
  cmd
from pg_policies 
where tablename = 'bookmarks';

-- ============================================
-- NEXT STEPS:
-- ============================================
-- 1. Go to Database > Replication in Supabase dashboard
-- 2. Find the 'bookmarks' table
-- 3. Toggle Realtime to ON
-- 4. Go to Authentication > Providers
-- 5. Enable Google OAuth provider
-- 6. Add your Google OAuth credentials
