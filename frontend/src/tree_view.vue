<template>
<div class="tree-view">
  <p v-on:click="root_comp.select_folder(root.id)"> {{ root.name }} </p>
  <ul>
    <li v-for="note in root.notes" v-on:click="root_comp.select_note(note.id)" v-bind:key="note.id">
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
    select_folder: function (folderId) {
      console.log('clicked folder')
      this.$emit('select-folder', folderId)
    },
    select_note: function (noteId) {
      console.log('clicked note')
      this.$emit('select-note', noteId)
    }
  }
}
</script>

<style>
</style>
