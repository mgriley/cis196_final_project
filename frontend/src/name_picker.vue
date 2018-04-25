<template>
<modal :name="modalName">
  <div class="modal_body">
    <slot></slot>
    <div class="error_msg" v-if="errors">
      <strong>error</strong> the name can't be empty
    </div>
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
      name: '',
      errors: false
    }
  },
  props: ['modalName', 'placeholder'],
  methods: {
    submit: function () {
      if (this.name === '') {
        this.errors = true
      } else {
        this.$emit('done', this.name)
        this.$modal.hide(this.modalName)
      }
    },
    is_valid: function () {

    }
  }
}
</script>

<style>
</style>
