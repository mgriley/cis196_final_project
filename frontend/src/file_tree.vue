<template>
  <div class="file_tree">
    <h1>welcome!</h1>
    <button v-on:click="create_note">create note</button>
    <button v-on:click="move_note">move note</button>
    <button v-on:click="delete_note">delete note</button>
    <button v-on:click="rename_note">rename note</button>
    <button v-on:click="create_folder">create folder</button>
    <button v-on:click="move_folder">move folder</button>
    <button v-on:click="delete_folder">delete folder</button>
    <button v-on:click="rename_folder">rename folder</button>
    <p>folder: {{ folder.name }}</p>
    <p>note: {{ note.name }}</p>
    <tree-view v-bind:root_comp="this" v-bind:root="tree" v-on:select-folder="select_folder" v-on:select-note="select_note"></tree-view>
  </div>
</template>

<script>
import TreeView from './tree_view.vue'

export default {
  name: 'FileTree',
  data: function () {
    return {
      folder: {},
      note: {},
      tree: {
        name: 'testing',
        id: 0,
        notes: [{name: 'a', id: 0}, {name: 'b', id: 1}],
        folders: [
          {
            id: 1,
            name: 'child',
            notes: [{name: 'c', id: 2}],
            folders: []
          }
        ]
      }
    }
  },
  components: {
    TreeView
  },
  methods: {
    select_note: function (noteId) {
      console.log('got the note selection')
      console.log(noteId)
    },
    select_folder: function (folderId) {
      console.log('got the folder selection')
      console.log(folderId)
    },
    open_note: function () {
      console.log('open note')
    },
    create_note: function () {
      console.log('create note')
    },
    move_note: function () {
      console.log('move note')
    },
    delete_note: function () {
      console.log('del note')
    },
    rename_note: function () {
      console.log('rename note')
    },
    create_folder: function () {
      console.log('create folder')
    },
    move_folder: function () {
      console.log('move folder')
    },
    delete_folder: function () {
      console.log('delete folder')
    },
    rename_folder: function () {
      console.log('rename note')
    }
  }
}
</script>

<style>
</style>
