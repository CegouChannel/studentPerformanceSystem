<script setup>
import { ref } from 'vue'

const activeItem = ref(1)

const sidebarList = [
  {
    id: 1,
    name: 'Студенты',
    url: '/students',
  },
  {
    id: 2,
    name: 'Группы',
    url: '#',
  },
  {
    id: 3,
    name: 'Учебные планы',
    url: '#',
  },
  {
    id: 4,
    name: 'Журнал',
    url: '/journal',
  },
]

const switchActiveItem = (selectedLink) => {
  activeItem.value = selectedLink
}
</script>

<template>
  <div class="sidebar">
    <ul class="sidebar-list">
      <li
        v-for="item in sidebarList"
        :key="item.id"
        @click="switchActiveItem(item.id)"
        class="sidebar-item"
      >
        <div v-if="item.id === activeItem" class="item-mark"></div>
        <router-link :to="item.url" :class="['sidebar-link', { 'active': item.id === activeItem }]"
          >{{ item.name }}
        </router-link>
      </li>
    </ul>
  </div>
</template>

<style scoped>
@import 'VSidebar.scss';
</style>
