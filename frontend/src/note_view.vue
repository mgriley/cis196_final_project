<template>
<div id="note-view">
  <div>
    <button @click="return_to_files">back</button>
  </div>
  <div>
    <input
    class="name"
    v-model="new_name"
    >
  </div>
  <div>
    <textarea v-model="new_content">
    </textarea>
  </div>
</div>
</template>

<script>
export default {
  name: 'NoteView',
  data: function () {
    return {
      note_id: -1,
      new_name: '',
      new_content: '',
    }
  },
  mounted: function () {
    this.note_id = this.$route.params.id
    var data = {note_id: this.note_id}
    var comp = this
    this.axios.post('/api/note', data).then(
      function (response) {
        var note = response.data
        comp.new_name = note.name
        comp.new_content = note.content
      }
    )
  },
  methods: {
    return_to_files: function () {
      var data = {
        note_id: this.note_id,
        new_name: this.new_name,
        new_content: this.new_content
      }
      var comp = this
      this.axios.post('/api/update_note', data).then(
        function (response) {
          // return to the files view
          console.log('note updated!')
          comp.$router.go(-1)
        }
      )
    }
  }
}
</script>

<style>
</style>
