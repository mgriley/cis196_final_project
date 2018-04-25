<template>
<modal v-bind:name="modalName" height="auto" scrollable>
  <div class="modal_body">
    <h1>choose a new folder</h1>  
    <div class="error_msg" v-if="error">
      <strong>error</strong> {{ error }}
    </div>
    <!--<p>current folder: {{ current_folder ? current_folder.name : '' }}</p>-->
    <p>
      <strong>new folder</strong> {{ new_folder ? new_folder.name : 'select a folder' }}
    </p>
    <div class="action_footer">
      <button @click="submit">submit</button>
    </div>
    <tree-view 
      v-bind:tree="tree"
      v-bind:folder_id="tree.root_folder_id"
      :to_fold="to_fold"
      :highlighted_note="null"
      :highlighted_folder="null"
      v-on:select_folder="select_folder">
    </tree-view>
  </div>
</modal>
</template>

<script>
import TreeView from './tree_view.vue'

export default {
  name: 'Mover',
  props: ['modalName', 'current_folder', 'tree', 'to_fold'],
  components: {
    TreeView
  },
  data: function() {
    return {
      new_folder: null,
      error: null
    }
  },
  methods: {
    submit: function () {
      if (this.new_folder === null) {
        this.error = 'you must select a folder'
      } else {
        this.$emit('done', this.new_folder)
        this.$modal.hide(this.modalName)
      }
    },
    select_folder: function (folder) {
      this.new_folder = folder
    }
  }
}
</script>

<style>
</style>
