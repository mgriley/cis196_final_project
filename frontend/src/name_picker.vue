<template>
<modal :name="modalName">
  <div class="modal_body">
    <slot></slot>
    <div>
      <input v-model="name" :placeholder="placeholder">
    </div>
    <div class="action_footer">
      <button @click="submit">submit</button>
    </div>
  </div>
</modal>
</template>

<script>
export default {
  name: 'NamePicker',
  data: function() {
    return {
      name: ''
    }
  },
  props: ['modalName', 'placeholder'],
  methods: {
    submit: function () {
      this.$emit('done', this.name)
      this.$modal.hide(this.modalName)
    }
  }
}
</script>

<style>
</style>
