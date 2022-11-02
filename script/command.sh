# Git submodules ignore dirty commit
git config --local submodule.ignore dirty

# Git update all submodules
git submodule update --recursive --remote

# Clone many submodules at the same time
git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
    while read path_key path
    do
        url_key=$(echo $path_key | sed 's/\.path/.url/')
        url=$(git config -f .gitmodules --get "$url_key")
        git submodule add $url $path
done

# Git remove file permanently
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch <filename>' --prune-empty --tag-name-filter cat -- --all

# Git remove autocrlf
git config --local core.autocrlf false

# Convert dos 2 unix for all files
find . -type f -print0 | xargs -0 dos2unix
