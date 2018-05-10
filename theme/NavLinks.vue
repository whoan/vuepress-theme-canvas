<template>
  <nav v-if="userLinks.length">
    <div
      v-for="item in userLinks"
      :key="item.link">
        <NavLink v-if="item.type !== 'links'" :item="item"/>
        <hr>
    </div>
  </nav>
</template>

<script>
import NavLink from './NavLink.vue'
import moment from 'moment'

export default {
  components: { NavLink },
  computed: {
    userNav () {
      return this.$site.pages || []
    },
    nav () {
      const { locales } = this.$site
      if (locales && Object.keys(locales).length > 1) {
        const currentLink = this.$page.path
        const routes = this.$router.options.routes
        const themeLocales = this.$site.themeConfig.locales || {}
        const languageDropdown = {
          text: this.$themeLocaleConfig.selectText || 'Languages',
          items: Object.keys(locales).map(path => {
            const locale = locales[path]
            const text = themeLocales[path] && themeLocales[path].label || locale.lang
            let link
            // Stay on the current page
            if (locale.lang === this.$lang) {
              link = currentLink
            } else {
              // Try to stay on the same page
              link = currentLink.replace(this.$localeConfig.path, path)
              // fallback to homepage
              if (!routes.some(route => route.path === link)) {
                link = path
              }
            }
            return { text, link }
          })
        }
        return [...this.userNav, languageDropdown]
      }
      return this.userNav
    },
    userLinks () {
      return (this.nav || [])
        .filter(link => {
          return link.path !== '/'
        })
        .sort((a, b) => {
          return moment.duration(this.postDate(b).diff(this.postDate(a)))
        })
    }
  },
  methods: {
    postDate (item) {
      if (item.lastModified) {
        return moment(item.lastModified * 1000)
      }
      return moment(item.frontmatter.lastModified)
    }
  }
}
</script>
