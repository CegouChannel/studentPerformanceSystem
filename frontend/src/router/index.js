import { createRouter, createWebHistory } from 'vue-router'
import StudentsView from '@/pages/StudentsView/StudentsView.vue'
import JournalView from '@/pages/JournalView/JournalView.vue'
import GroupsView from '@/pages/GroupsView/GroupsView.vue'
import StudyPlansView from '@/pages/StudyPlansView/StudyPlansView.vue'

const HomeView = () => import('@/pages/HomeView.vue')

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView,
    },
    {
      path: '/students',
      name: 'students',
      component: StudentsView,
    },
    {
      path: '/journal',
      name: 'journal',
      component: JournalView,
    },
    {
      path: '/groups',
      name: 'groups',
      component: GroupsView,
    },
    {
      path: '/plans',
      name: 'plans',
      component: StudyPlansView,
    },
  ],
})
router.beforeEach((to, from, next) => {
  next()
})
export default router
