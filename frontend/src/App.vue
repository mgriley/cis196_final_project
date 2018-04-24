<template>
  <div id="app">
    <file-tree></file-tree>
  </div>
</template>

<script>
import FileTree from './file_tree.vue'

export default {
  name: 'App',
  components: {
    FileTree
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
