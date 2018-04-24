<template>
<modal name="create_folder">
  <h1>create folder</h1>  
  <input v-model="name">
  <button @click="submit">submit</button>
</modal>
</template>

<script>
export default {
  name: 'CreateFolder',
  props: ['parent_folder'],
  data: function() {
    return {
      name: ''
    }
  },
  methods: {
    submit: function () {
      var data = {
        name: this.name,
        parent_folder_id: this.parent_folder.id
      }
      this.$emit('done', data)
      this.$modal.hide('create_folder')
    }
  }
}
</script>

<style>
</style>
