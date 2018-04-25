<template>
<div class="tree-view outer-div">
  <div class="file_entry folder_entry" v-on:click="select_folder(folder)">
    <strong>F</strong> {{ folder ? folder.name : '' }}
  </div>
  <div class="folder-div">
    <div 
      class="file_entry note_entry"
      v-for="child_note in child_notes()"
      v-on:click="select_note(child_note)"
      v-on:dblclick="open_note(child_note)"
      v-bind:key="child_note.id"
      >
      <strong>N</strong> {{ child_note.name }}
    </div>
    <template v-for="child_folder in child_folders()">
      <tree-view
        v-bind:tree="tree"
        v-bind:folder_id="child_folder.id"
        @select_folder="select_folder"
        @select_note="select_note"
        @open_note="open_note"
        v-bind:key="child_folder.id"
      >
      </tree-view>
    </template>
  </div>
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
      this.$emit('select_folder', some_folder)
    },
    select_note: function (note) {
      console.log('clicked note')
      this.$emit('select_note', note)
    },
    open_note: function (note) {
      console.log('opening note')
      this.$emit('open_note', note)
    }
  }
}
</script>

<style>
.outer-div {
}
.folder-div {
  border-style: solid;
  border-width: 2px;
  padding: 0.75em;
}
</style>
