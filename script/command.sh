# Git remove file permanently
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch <filename>' --prune-empty --tag-name-filter cat -- --all

# Git remove autocrlf
git config --local core.autocrlf false

# Convert dos 2 unix for all files
find . -type f -print0 | xargs -0 dos2unix
