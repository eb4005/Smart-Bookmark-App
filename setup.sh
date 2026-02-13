#!/bin/bash

# Smart Bookmark App - Quick Setup Script
# This script helps set up the project quickly

echo "🚀 Smart Bookmark App - Setup Script"
echo "======================================"
echo ""

# Check if .env.local exists
if [ -f ".env.local" ]; then
    echo "✅ .env.local already exists"
else
    echo "📝 Creating .env.local from template..."
    cp .env.local.example .env.local
    echo "⚠️  Please edit .env.local and add your Supabase credentials"
    echo ""
fi

# Check if node_modules exists
if [ -d "node_modules" ]; then
    echo "✅ Dependencies already installed"
else
    echo "📦 Installing dependencies..."
    npm install
    if [ $? -eq 0 ]; then
        echo "✅ Dependencies installed successfully"
    else
        echo "❌ Failed to install dependencies"
        exit 1
    fi
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Edit .env.local with your Supabase credentials"
echo "2. Set up your Supabase database (run supabase-setup.sql)"
echo "3. Configure Google OAuth in Supabase"
echo "4. Run: npm run dev"
echo ""
echo "📚 See QUICKSTART.md for detailed instructions"
