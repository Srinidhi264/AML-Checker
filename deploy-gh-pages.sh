#!/bin/bash
set -e

# 1. Build the static export
npx expo export

# 2. Save current branch name
git_branch=$(git rev-parse --abbrev-ref HEAD)

# 3. Create orphan gh-pages branch and clear old files
git checkout --orphan gh-pages
git reset --hard

# 4. Copy export output to root
cp -r dist/* .

# 5. Add and commit
rm -rf dist
# Remove node_modules and other dev files from gh-pages
rm -rf node_modules .expo .gitignore babel.config.js tsconfig.json package-lock.json package.json app assets

git add .
git commit -m "Deploy Expo static export to GitHub Pages"
git push -f origin gh-pages

# 6. Switch back to original branch
git checkout "$git_branch"
echo "Deployment complete! Your site will be live on GitHub Pages shortly."
