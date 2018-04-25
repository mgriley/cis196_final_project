<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  margin: 1em;
}
button {
  font-size: 1em;
  border: solid;
  border-width: 2px;
  text-decoration: none;
}
.modal_body {
  margin: 1em;
}
input {
  font-size: 1em;
}
.action_footer {
  margin-top: 1em;
  margin-bottom: 1em;
}
</style>
