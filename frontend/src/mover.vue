<template>
<modal v-bind:name="modalName" height="auto" scrollable>
  <h1>choose a new folder</h1>  
  <p>current folder: {{ current_folder ? current_folder.name : '' }}</p>
  <p>new folder: {{ new_folder ? new_folder.name : '' }}</p>
  <tree-view
    v-bind:root_comp="this"
    v-bind:root="tree"
    v-on:select_folder="select_folder"
  >
  </tree-view>
  <button @click="submit">submit</button>
</modal>
</template>

<script>
import TreeView from './tree_view.vue'

export default {
  name: 'Mover',
  props: ['modalName', 'current_folder', 'tree'],
  components: {
    TreeView
  },
  data: function() {
    return {
      new_folder: {}
    }
  },
  methods: {
    submit: function () {
      this.$emit('done', this.new_folder)
      this.$modal.hide(this.modalName)
    },
    select_folder: function (folder) {
      this.new_folder = folder
    }
  }
}
</script>

<style>
</style>
