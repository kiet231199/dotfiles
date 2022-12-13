# Git remove file permanently
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch <filename>' --prune-empty --tag-name-filter cat -- --all

# Git remove autocrlf
git config --local core.autocrlf false

# Convert dos 2 unix for all files
find . -type f -print0 | xargs -0 dos2unix

# Search all *.c files in all subdirectories
dirname $(find -name '*.c' -o -name '*.h') | sort | awk '!a[$0]++'
dirname $(find -name '*.c') | sort | awk '!a[$0]++' | awk '{print $0"/*.c"}'
dirname $(find -name '*.h') | sort | awk '!a[$0]++' | awk '{print $0"/*.h"}'
