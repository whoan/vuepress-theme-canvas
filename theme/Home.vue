<template>
    <NavLinks class="can-hide"/>
</template>

<script>
import NavLinks from './NavLinks.vue'

export default {
  components: { NavLinks },
  computed: {
    data () {
      return this.$page.frontmatter
    }
  }
}
</script>
