<template>
  <div>
    <div id="head-c" class="container">
        <div class="row">
          <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
            <h1 id="blog-name">
              <router-link
                to="/">
                  {{ $siteTitle }}
              </router-link>
            </h1>
            <a v-for="link in $site.themeConfig.usefulLinks" :key="link.href" :href="link.href" target="_blank" class="social">
              <i :class="link.cssIcon"></i>
            </a>
          </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
              <div class="custom-layout" v-if="$page.frontmatter.layout">
                <component :is="$page.frontmatter.layout"/>
              </div>
              <Home v-else-if="$page.frontmatter.home"/>
              <Page v-else>
                <slot name="page-top" slot="top"/>
                <slot name="page-bottom" slot="bottom"/>
              </Page>
            </div>
        </div>

    </div>

    <div class="container">
        <center>
            <hr width="50%">
            <span id="subtitle">{{ $description }}</span>

            <div class="row">
                <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                    <p class="small">&copy; 2018 {{ $siteTitle }}. Code released under the <a href="https://opensource.org/licenses/MIT" target="_blank">MIT License</a></p>
                </div>
            </div>
        </center>
    </div>
  </div>
</template>

<script>
import Vue from 'vue'
import nprogress from 'nprogress'
import Home from './Home.vue'
import Page from './Page.vue'
import { pathToComponentName } from '@app/util'

export default {
  components: { Home, Page },

  created () {
    if (this.$ssrContext) {
      this.$ssrContext.title = this.$title
      this.$ssrContext.lang = this.$lang
      this.$ssrContext.description = this.$page.description || this.$description
    }
  },

  mounted () {
    // update title / meta tags
    this.currentMetaTags = []
    const updateMeta = () => {
      document.title = this.$title
      document.documentElement.lang = this.$lang
      const meta = [
        {
          name: 'description',
          content: this.$description
        },
        ...(this.$page.frontmatter.meta || [])
      ]
      this.currentMetaTags = updateMetaTags(meta, this.currentMetaTags)
    }
    this.$watch('$page', updateMeta)
    updateMeta()

    // configure progress bar
    nprogress.configure({ showSpinner: false })

    this.$router.beforeEach((to, from, next) => {
      if (to.path !== from.path && !Vue.component(pathToComponentName(to.path))) {
        nprogress.start()
      }
      next()
    })

    this.$router.afterEach(() => {
      nprogress.done()
    })
  },

  beforeDestroy () {
    updateMetaTags(null, this.currentMetaTags)
  }
}

function updateMetaTags (meta, current) {
  if (current) {
    current.forEach(c => {
      document.head.removeChild(c)
    })
  }
  if (meta) {
    return meta.map(m => {
      const tag = document.createElement('meta')
      Object.keys(m).forEach(key => {
        tag.setAttribute(key, m[key])
      })
      document.head.appendChild(tag)
      return tag
    })
  }
}
</script>

<style src="prismjs/themes/prism.css"></style>
<style src="source-code-pro/source-code-pro.css"></style>
<style src="source-sans-pro/source-sans-pro.css"></style>
<style src="./less/blog/blog.less" lang="less"></style>
<style src="font-awesome/css/font-awesome.min.css"></style>
<style>
  #blog-name a:hover, #blog-name a:focus {
    color: initial;
  }

  .header-anchor {
    display: none;
  }
</style>
