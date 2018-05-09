# Vuepress Canvas

[Vuepress][vuepress] custom theme for blogging, inspired on [Canvas: a Simple, Powerful Blog Publishing Platform][canvas]

## Installation

First, create a docs folder if you don't have one yet:

```bash
mkdir docs && cd docs
```

Clone the repo and install dependencies:

```bash
git clone https://github.com/whoan/vuepress-canvas.git .vuepress
cd .vuepress

# copy an example config
cp config.js.example config.js

# install dependencies
yarn  # or npm install

# you need a root README like this in your docs folder
cd ..
[ ! -f README.md ] && echo -e "---\nhome: true\n---" > README.md
```

---------

The README file in your docs folder is to let `vuepress` render the *Home* page. See more information [here](https://vuepress.vuejs.org/default-theme-config/#homepage).

> Important note: The root README will be ignored by the theme and won't be listed as a blog post (expected behavior). For the same reason, all its content (expect for the front matter) will be ignored.

## Testing the theme

Create a markdown document if you don't have one yet, and see how beautiful your blog is:

```
echo '# My first post' > my-first-post.md
vuepress dev
```

## Set the config file to your needs

Now that you have your new blog, it's time to personalize it. Go and change the *congif.js* file with your personal information.

## Other functionalities

You can set the **lastModified** date of a blog post in the Front Matter like this:

    lastModified: 2018-05-09

And you can set **prev** and **next** posts in the footer of your posts adding something like this also in the Front Matter:

    prev: /some-prev-blog
    next: /some-next-blog

## Limitations

This project is meant to be simple and it has some limitations. Some of them can be addressed with the time, others will never be implemented to maintain its simplicity.

These are the current limitations, based on what you can expect for a blog:

- It only list the markdown files in the root of your docs folder. In other words, it ignores the folders you can have in your docs repo.
- It doesn't have tags.
- It doesn't have a search bar.
- It doesn't have a lot of other things you can find in other blogs; but it's beautiful, something you don't find in a lot of other blogs.

## Troubleshooting

#### I get a 404 error

It's due to you need a README.md in the root of the project. See [the installation section](#installation).

#### Having compiling template errors

You need to see which are the hurting files and modify them accordingly to make them markdown compliant. Don't know really which are the common reasons for this problem.

## License

[MIT](https://github.com/vuejs/vuepress/blob/master/LICENSE)

[vuepress]: https://github.com/vuejs/vuepress
[canvas]: https://github.com/cnvs/canvas
