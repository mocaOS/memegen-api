#!/bin/bash
# Script to manually sync upstream changes from jacebrowning/memegen

set -e

echo "🔄 Syncing upstream changes..."

# Fetch latest changes from upstream
echo "📥 Fetching latest changes from upstream..."
git fetch upstream

# Checkout main branch
echo "📂 Checking out main branch..."
git checkout main

# Merge upstream/main into local main
echo "🔀 Merging upstream/main into main..."
git merge upstream/main --no-edit

# Push changes to origin
echo "📤 Pushing changes to origin..."
git push origin main

echo "✅ Sync complete!"
