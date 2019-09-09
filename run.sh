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

shopt -s nullglob
n_markdown_files=( *.md )
if (( ${#n_markdown_files[@]} == 0 )); then
    echo "Creating sample posts..."
    cp .vuepress/my-first-post.example.md my-first-post.md
    cp .vuepress/README.md vuepress-theme-canvas-readme.md
fi

if [ ! -f README.md ]; then
    echo "Creating README in the docs folder..."
    echo -e "---\nhome: true\n---" > README.md
fi

echo
run_dev=".vuepress/node_modules/.bin/vuepress dev"
echo "Running $run_dev"
$run_dev
