<template>
<modal v-bind:name="modalName">
  <h1>choose a new name</h1>  
  <input v-model="new_name" v-bind:placeholder="placeholder">
  <button @click="submit">submit</button>
</modal>
</template>

<script>
export default {
  name: 'NameChanger',
  props: ['placeholder', 'modalName'],
  data: function() {
    return {
      new_name: ''
    }
  },
  methods: {
    submit: function () {
      this.$emit('done', this.new_name)
      this.$modal.hide(this.modalName)
    }
  }
}
</script>

<style>
</style>
