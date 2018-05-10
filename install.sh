#!/usr/bin/env bash

set -e

project_directory=${0%/*}

# move to the project's directory if needed
cd "$project_directory"

echo "Installing dependencies..."
echo
{ which yarn > /dev/null && yarn; } || npm install

if [ ! -f config.js ]; then
    echo
    echo "Creating config file..."
    cp config.js.example config.js
fi

# go to the docs folder
cd ..

if [ ! -f README.md ]; then
    echo "Creating README in the docs folder..."
    echo -e "---\nhome: true\n---" > README.md
fi

shopt -s nullglob
n_markdown_files=( *.md )
if (( ${#n_markdown_files[@]} > 0 )); then
    echo "Creating a sample post..."
    echo '# My first post' > my-first-post.md
    echo "Don't forget to edit the config.js file to personalize your blog" >> my-first-post.md
fi

echo
echo "To see it run, execute this in your docs folder: vuepress dev"
echo "DONE!"
