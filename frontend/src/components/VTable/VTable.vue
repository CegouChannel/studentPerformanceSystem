<script setup>
import VInput from '@/components/UI/VInput/VInput.vue'
import VButton from '@/components/UI/VButton/VButton.vue'
import VSelect from '@/components/UI/VSelect/VSelect.vue'
import { useGroupStore } from '@/store/groupStore.js'

const props = defineProps({
  title: {
    type: String,
    required: true,
  },
  options: {
    type: Array,
  },
  tableHead: {
    type: Array,
    required: true,
  },
})

const emit = defineEmits([
  'switchAddWindow',
  'deleteById',
  'switchEditWindow',
  'onPageChange',
])
const groupStore = useGroupStore()

const switchAddWindow = () => {
  emit('switchAddWindow')
}

await groupStore.getGroups()
</script>

<template>
  <div class="table">
    <div class="table-head">
      <div class="table-head-title">
        <h1 class="title">{{ title }}</h1>
        <VButton @click="switchAddWindow" size="icon" variant="text">
          <v-icon color="primary">mdi-plus</v-icon>
        </VButton>
      </div>
      <div class="table-head-actions">
        <div class="table-head-input">
          <VInput placeholder="Поиск" size="large" />
        </div>
        <div class="table-head-select">
          <VSelect
            disabled-option="Выберите группу"
            :options="options"
            size="large"
          />
        </div>
        <div class="table-head-search">
          <VButton color="secondary" size="large">ПОИСК</VButton>
        </div>
      </div>
    </div>
    <div class="table-body">
      <table class="table-body-head">
        <tbody>
          <tr
            :style="`grid-template-columns: 0.2fr repeat(${tableHead.length}, 1fr);`"
          >
            <td v-for="head in tableHead" :key="head.id">
              {{ head.name }}
            </td>
            <td>действия</td>
          </tr>
        </tbody>
      </table>
      <table class="table-body-data">
        <tbody>
          <slot></slot>
        </tbody>
      </table>
    </div>
  </div>
</template>

<style scoped>
@import 'VTable.scss';
</style>
