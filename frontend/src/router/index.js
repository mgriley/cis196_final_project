import Vue from 'vue'
import Router from 'vue-router'
import FileTree from '../file_tree.vue'
import NoteView from '../note_view.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'FileTree',
      component: FileTree
    },
    {
      path: '/note/:id',
      name: 'Note',
      component: NoteView
    }
  ]
})
