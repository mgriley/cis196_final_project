<template>
<div class="tree-view folder-div">
  <p v-on:click="root_comp.select_folder(root)"> {{ root.name }} </p>
  <ul>
    <li v-for="note in root.notes"
      v-on:click="root_comp.select_note(note)"
      v-on:dblclick="root_comp.open_note(note)"
      v-bind:key="note.id"
      >
      {{ note.name }}
    </li>
  </ul>
  <template v-for="folder in root.folders">
    <tree-view v-bind:key="folder.id" v-bind:root_comp="root_comp" v-bind:root="folder"></tree-view>
  </template>
</div>
</template>

<script>
export default {
  name: 'TreeView',
  props: ['root_comp', 'root'],
  methods: {
    select_folder: function (folder) {
      console.log('clicked folder')
      this.$emit('select-folder', folder)
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
