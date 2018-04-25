<template>
  <div class="file_tree">
    <h1>welcome</h1>
    <div class="tree_buttons">
      <div class="note_buttons">
        <button v-on:click="create_note">create note</button>
        <button v-on:click="try_move_note">move note</button>
        <button v-on:click="try_rename_note">rename note</button>
        <button v-on:click="delete_note">delete note</button>
      </div>
      <div class="folder_buttons">
        <button v-on:click="try_create_folder">create folder</button>
        <button v-on:click="try_move_folder">move folder</button>
        <button v-on:click="try_rename_folder">rename folder</button>
        <button v-on:click="delete_folder">delete folder</button>
      </div>
    </div>
    <p>
      <strong>selected folder</strong> {{ folder ? folder.name : 'none' }}
    </h3>
    <p>
      <strong>selected note</strong> {{ note ? note.name : 'none' }}
    </p>
    <tree-view
      class="file_view"
      v-bind:tree="tree"
      v-bind:folder_id="tree.root_folder_id"
      v-on:select_folder="select_folder"
      v-on:select_note="select_note"
      v-on:open_note="open_note"
      >
    </tree-view>
    <name-picker
      modalName="create_folder"  
      placeholder="pick a name"
      v-on:done="create_folder"
    >
      <h1>folder name:</h1>
    </name-picker>
    <name-picker
       modalName="rename_folder"
       v-bind:placeholder="folder ? folder.name : ''"
       v-on:done="rename_folder"
    >
      <h1>rename folder:</h1>
    </name-picker>
    <name-picker
       modalName="rename_note"
       v-bind:placeholder="note ? note.name : ''"
       v-on:done="rename_note"
    >
      <h1>rename note</h1>
    </name-picker>
    <mover
       modalName="move_note"
       v-bind:current_folder="folder"
       v-bind:tree="tree"
       v-on:done="move_note"
    >
    </mover>
    <mover
       modalName="move_folder"
       v-bind:current_folder="folder"
       v-bind:tree="tree"
       v-on:done="move_folder"
    >
    </mover>
  </div>
</template>

<script>
import TreeView from './tree_view.vue'
import NamePicker from './name_picker.vue'
import Mover from './mover.vue'

var sampleTree = {
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

var emptyTree = {
  notes: {
  },
  folders: {
    0: {
      id: 0,
      name: "placeholder",
      parent_folder_id: null,
      folders: [],
      notes: []
    }
  },
  root_folder_id: 0
}

export default {
  name: 'FileTree',
  data: function () {
    return {
      folder: null,
      note: null,
      tree: emptyTree
    }
  },
  components: {
    TreeView,
    NamePicker,
    Mover
  },
  mounted: function () {
    this.update_tree()
  },
  methods: {
    update_tree: function () {
      var comp = this
      this.axios.get('api/file_tree').then(
        function (response) {
          comp.tree = response.data
          console.log('tree: ')
          console.log(JSON.stringify(comp.tree, null, " "))
        }
      )
    },
    select_note: function (note) {
      console.log('got the note selection')
      console.log(note)
      this.note = note
    },
    select_folder: function (folder) {
      console.log('got the folder selection')
      console.log(folder)
      this.folder = folder
    },
    open_note: function (note) {
      console.log('opening note')
      console.log(note)
      this.$router.push({name: 'Note', params: {id: note.id}})
    },
    create_note: function () {
      console.log('create note')
      var comp = this
      if (this.folder) {
        var data = {folder_id: this.folder.id}
        this.axios.post('api/create_note', data).then(
          function (response) {
            comp.open_note(response.data)
          }
        )
      } else {
        console.log('no folder selected')
      }
    },
    try_move_note: function () {
      this.$modal.show('move_note')
    },
    move_note: function (new_folder) {
      console.log('move note')
      var data = {
        note_id: this.note.id,
        new_parent_folder_id: new_folder.id
      }
      var comp = this
      this.axios.post('/api/move_note', data).then(
        function (response) {
          comp.update_tree()
        }
      )
    },
    delete_note: function () {
      console.log('del note')
      if (this.note === null) {
        return;
      }
      var comp = this;
      var data = {note_id: this.note.id}
      this.axios.post('/api/destroy_note', data).then(
        function (response) {
          comp.update_tree()
        }
      )
    },
    try_rename_note: function () {
      this.$modal.show('rename_note')
    },
    rename_note: function (new_name) {
      var comp = this
      var data = {new_name: new_name, note_id: this.note.id}
      this.axios.post('/api/rename_note', data).then(
        function (response) {
          comp.update_tree()
        }
      )
    },
    try_create_folder: function () {
      this.$modal.show("create_folder")
    },
    create_folder: function (name) {
      console.log('creating a folder')
      var comp = this
      var data = {
        name: name,
        parent_folder_id: this.folder.id
      }
      this.axios.post('api/create_folder', data).then(
        function (response) {
          comp.update_tree()
        }
      )
    },
    try_move_folder: function () {
      this.$modal.show('move_folder')
    },
    move_folder: function (new_folder) {
      console.log('moving folder')
      var comp = this
      var data = {
        folder_id: this.folder.id,
        new_parent_folder_id: new_folder.id
      }
      this.axios.post('/api/move_folder', data).then(
        function (response) {
          comp.update_tree()
        }
      )
    },
    delete_folder: function () {
      console.log('delete folder')
      if (this.folder === null) {
        return;
      }
      var data = {
        folder_id: this.folder.id
      }
      var comp = this
      this.axios.post('api/destroy_folder', data).then(
        function (response) {
          comp.update_tree()
        }
      )
    },
    try_rename_folder: function () {
      this.$modal.show('rename_folder')
    },
    rename_folder: function (new_name) {
      console.log('renaming note')
      var comp = this
      var data = {new_name: new_name, folder_id: this.folder.id}
      this.axios.post('/api/rename_folder', data).then(
        function (response) {
          comp.update_tree()
        }
      )
    }
  }
}
</script>

<style>
.file_view {
}
.tree_buttons button {
  width: 8em;  
}
.note_buttons {
  margin-bottom: 0.5em;
}
</style>
