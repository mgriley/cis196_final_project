<template>
<div class="tree-view folder-div">
  <p v-on:click="root_comp.select_folder(folder)"> {{ folder ? folder.name : '' }} </p>
  <ul>
    <li v-for="child_note in child_notes()"
      v-on:click="root_comp.select_note(child_note)"
      v-on:dblclick="root_comp.open_note(child_note)"
      v-bind:key="child_note.id"
      >
      {{ child_note.name }}
    </li>
  </ul>
  <template v-for="child_folder in child_folders()">
    <tree-view
      v-bind:root_comp="root_comp"
      v-bind:tree="tree"
      v-bind:folder_id="child_folder.id"
      v-bind:key="child_folder.id"
    >
    </tree-view>
  </template>
</div>
</template>

<script>
export default {
  name: 'TreeView',
  props: ['root_comp', 'tree', 'folder_id'],
  computed: {
    folder: function () {
      return this.tree['folders'][this.folder_id]
    }
  },
  methods: {
    child_notes: function () {
      var note_ids = this.folder['notes']
      var notes = []
      for (var i = 0; i < note_ids.length; ++i) {
        var note_id = note_ids[i]
        var note = this.tree['notes'][note_id]
        notes.push(note)
      }
      return notes
    },
    child_folders: function (folder_id) {
      var folders = []
      var folder_ids = this.folder['folders']
      for (var i = 0; i < folder_ids.length; ++i) {
        var folder_id = folder_ids[i]
        var f = this.tree['folders'][folder_id]
        folders.push(f)
      }
      return folders
    },
    select_folder: function (some_folder) {
      console.log('clicked folder')
      this.$emit('select-folder', some_folder)
    },
    select_note: function (note) {
      console.log('clicked note')
      this.$emit('select-note', note)
    },
    open_note: function (note) {
      console.log('opening note')
      this.$emit('open-note', note)
    }
  }
}
</script>

<style>
.folder-div {
  margin-left: 2%
}
</style>
