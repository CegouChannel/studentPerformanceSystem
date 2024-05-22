<script setup>
import VSidebar from '@/components/VSidebar/VSidebar.vue'
import VHeader from '@/components/VHeader/VHeader.vue'
import VTable from '@/components/VTable/VTable.vue'
import VButton from '@/components/UI/VButton/VButton.vue'
import VModalWindow from '@/components/UI/VModalWindow/VModalWindow.vue'
import VInput from '@/components/UI/VInput/VInput.vue'
import { usePlanTrainingStore } from '@/store/planTrainingStore.js'
import { useLessonsStore } from '@/store/lessonsStore.js'
import { ref } from 'vue'

const plansStore = usePlanTrainingStore()
const lessonsStore = useLessonsStore()

const tableHeadPlans = [
  {
    id: 1,
    name: 'ID',
  },
  {
    id: 2,
    name: 'Наименование',
  },
  {
    id: 3,
    name: 'Уроки',
  },
]

const options = [
  {
    value: 1,
    title: '123',
  },
  {
    value: 2,
    title: '211',
  },
]
const editWindowPlanOpened = ref(false)
const addWindowPlanOpened = ref(false)
const formEditPlan = ref({
  id: '',
  name: '',
  lessons: '',
})

const switchEditWindow = (data) => {
  formEditPlan.value = {
    id: data.value,
    name: data.title,
    lessons: getLessonsByPlanId(data.value),
  }
  editWindowPlanOpened.value = !editWindowPlanOpened.value
}

const switchAddWindow = () => {
  addWindowPlanOpened.value = !addWindowPlanOpened.value
}
const deletePlanById = async (id) => {
  // const reqDeletePlanById = planTrainingService.deletePlanTrainingById(id)
  // if (!reqDeletePlanById.insertId) {
  //   plansStore.plansTraining.filter((plan) => plan.id !== id)
  // }
  console.log(id)
}

const getLessonsByPlanId = (idPlan) => {
  let lesson
  const lessons = lessonsStore.lessons.filter(
    (lesson) => lesson.id_plan === idPlan
  )
  let response = ''
  for (lesson of lessons) {
    response += `${lesson.name}, `
  }
  return response
}
await lessonsStore.getLessons()
await plansStore.getPlansTraining()
</script>

<template>
  <div class="plans">
    <VSidebar />
    <div class="plans-body">
      <VHeader />
      <h3 class="plans-title">Учебные планы</h3>
      <VTable
        @switchAddWindow="switchAddWindow"
        :options="options"
        :table-head="tableHeadPlans"
        title="Данные учебных планов"
      >
        <transition-group name="list" tag="p">
          <tr
            class="table-body-row"
            v-for="plan in plansStore.plansTraining"
            :key="plan.value"
          >
            <td>{{ plan.value }}</td>
            <td>{{ plan.title }}</td>
            <td>{{ getLessonsByPlanId(plan.value) }}</td>
            <td>
              <VButton
                @click="deletePlanById(plan.value)"
                size="icon"
                variant="text"
              >
                <v-icon color="red">mdi-delete</v-icon>
              </VButton>
              <VButton
                @click="switchEditWindow(plan)"
                size="icon"
                variant="text"
                icon="mid-pencil"
              >
                <v-icon color="secondary">mdi-pencil</v-icon>
              </VButton>
            </td>
          </tr>
        </transition-group>
      </VTable>
    </div>
    <VModalWindow :is-open="editWindowPlanOpened">
      <div class="plans_editPlan">
        <h3 class="editPlan-title">
          Редактирование плана #{{ formEditPlan.id }}
        </h3>
        <VInput
          v-model="formEditPlan.name"
          placeholder="Наименование"
          size="fullWidth"
        />
        <div class="editPlan-actions">
          <VButton @click="switchEditWindow" size="small" color="secondary"
            >отменить
          </VButton>
          <VButton size="small" color="primary">готово</VButton>
        </div>
      </div>
    </VModalWindow>
    <VModalWindow :is-open="addWindowPlanOpened">
      <div class="plans_addPlan">
        <h3 class="addPlan-title">Добавление плана</h3>
        <div class="addPlan-body">
          <VInput placeholder="Наименование" size="fullWidth" />
          <div class="addPlan-actions">
            <VButton @click="switchAddWindow" size="small" color="secondary"
              >отменить
            </VButton>
            <VButton size="small" color="primary">добавить</VButton>
          </div>
        </div>
      </div>
    </VModalWindow>
  </div>
</template>

<style scoped>
@import 'StudyPlansView.scss';
</style>
