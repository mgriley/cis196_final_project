<template>
<modal v-bind:name="modalName" height="auto" scrollable>
  <div class="modal_body">
    <h1>choose a new folder</h1>  
    <!--<p>current folder: {{ current_folder ? current_folder.name : '' }}</p>-->
    <p>
      <strong>new folder</strong> {{ new_folder ? new_folder.name : '' }}
    </p>
    <div class="action_footer">
      <button @click="submit">submit</button>
    </div>
    <tree-view v-bind:tree="tree" v-bind:folder_id="tree.root_folder_id" v-on:select_folder="select_folder">
    </tree-view>
  </div>
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
