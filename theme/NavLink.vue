<template>
  <div class="post-preview">
    <h2 class="post-title">
      <router-link
        class="nav-link"
        :to="link"
        :exact="link === '/'">
          {{ item.title }}
      </router-link>
    </h2>
    <p :title="formattedPostDate" class="post-meta">
      {{ humanizedPostDate }}
    </p>
  </div>
</template>

<script>
import moment from 'moment'

export default {
  props: {
    item: {
      required: true
    }
  },
  computed: {
    link () {
      return this.item.path
    },
    postDate () {
      if (this.item.lastModified) {
        return moment(this.item.lastModified * 1000)
      }
      return moment(this.item.frontmatter.lastModified)
    },
    formattedPostDate () {
      return this.postDate.format("Y-MM-DD")
    },
    humanizedPostDate () {
      return moment.duration(moment().diff(this.postDate)).humanize()
    }
  }
}
</script>
