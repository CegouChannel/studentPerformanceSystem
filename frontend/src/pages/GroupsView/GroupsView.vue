<script setup>
import VSidebar from '@/components/VSidebar/VSidebar.vue'
import VHeader from '@/components/VHeader/VHeader.vue'
import VTable from '@/components/VTable/VTable.vue'
import VButton from '@/components/UI/VButton/VButton.vue'
import VSelect from '@/components/UI/VSelect/VSelect.vue'
import VInput from '@/components/UI/VInput/VInput.vue'
import VModalWindow from '@/components/UI/VModalWindow/VModalWindow.vue'
import groupService from '@/API/groupService.js'
import { useGroupStore } from '@/store/groupStore.js'
import { usePlanTrainingStore } from '@/store/planTrainingStore.js'
import { ref } from 'vue'

const tableHead = [
  {
    id: 1,
    name: 'ID',
  },
  {
    id: 2,
    name: 'Название',
  },
  {
    id: 3,
    name: 'План обучения',
  },
]
const addGroupWindowOpened = ref(false)
const editGroupWindowOpened = ref(false)
const groupsStore = useGroupStore()
const planTrainingStore = usePlanTrainingStore()

const formAddGroup = ref({
  name: '',
  planTraining: 1,
})

const formEditGroup = ref({
  id: '',
  name: '',
  planTraining: 1,
})
const switchAddGroupWindow = () => {
  addGroupWindowOpened.value = !addGroupWindowOpened.value
}

const switchEditGroupWindow = (group) => {
  formEditGroup.value = {
    id: group.value,
    name: group.title,
    planTraining: group.planTraining,
  }
  editGroupWindowOpened.value = !editGroupWindowOpened.value
}

const addGroup = async () => {
  const reqAddGroup = await groupService.addGroup(formAddGroup.value)
  if (reqAddGroup.insertId) {
    const newGroup = {
      planTraining: formAddGroup.value.planTraining,
      title: formAddGroup.value.name,
      value: reqAddGroup.insertId,
    }
    groupsStore.groups.push(newGroup)
    formAddGroup.value = {
      name: '',
      planTraining: 1,
    }
  } else {
    console.log(reqAddGroup)
  }
}

const editGroup = async () => {
  const reqEditGroup = await groupService.editGroup(
    formEditGroup.value,
    formEditGroup.value.id
  )
  console.log(reqEditGroup)
  if (reqEditGroup.insertId === 0) {
    const index = groupsStore.groups.findIndex(
      (obj) => obj.value === formEditGroup.value.id
    )
    groupsStore.groups[index].planTraining = formEditGroup.value.planTraining
    groupsStore.groups[index].title = formEditGroup.value.name
    groupsStore.groups[index].value = formEditGroup.value.id
  } else {
    console.log(reqEditGroup)
  }
}

const deleteGroupById = async (id) => {
  const reqDeleteGroupById = await groupService.deleteGroupById(id)
  if (!reqDeleteGroupById.insertId) {
    const index = groupsStore.groups.findIndex((group) => group.value === id)
    if (index !== -1) {
      groupsStore.groups.splice(index, 1)
    }
  } else {
    console.log(reqDeleteGroupById)
  }
}

await planTrainingStore.getPlansTraining()
await groupsStore.getGroups()
</script>

<template>
  <div class="groups">
    <VSidebar class="" />
    <div class="groups-body">
      <VHeader />
      <h2 class="groups-title">Группы</h2>
      <VTable
        @switchAddWindow="switchAddGroupWindow"
        @deleteById="deleteGroupById"
        :data-table="groupsStore.groups"
        :options="groupsStore.groups"
        :tableHead="tableHead"
        title="Данные групп"
      >
        <transition-group name="list" tag="p">
          <tr
            class="table-body-row"
            v-for="group in groupsStore.groups"
            :key="group.value"
          >
            <td>{{ group.value }}</td>
            <td>{{ group.title }}</td>
            <td>{{ group.planTraining }}</td>
            <td>
              <VButton
                @click="deleteGroupById(group.value)"
                size="icon"
                variant="text"
              >
                <v-icon color="red">mdi-delete</v-icon>
              </VButton>
              <VButton
                @click="switchEditGroupWindow(group)"
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
    <VModalWindow :is-open="addGroupWindowOpened">
      <div class="groups_addGroup">
        <h3 class="addGroup-title">Добавление группы</h3>
        <VInput
          v-model="formAddGroup.name"
          placeholder="Название группы"
          size="fullWidth"
        ></VInput>
        <VSelect
          v-model="formAddGroup.planTraining"
          :options="planTrainingStore.plansTraining"
          size="fullWidth"
          disabled-option="План обучения"
        ></VSelect>
        <div class="addGroup-actions">
          <VButton @click="switchAddGroupWindow" size="small" color="secondary"
            >отменить
          </VButton>
          <VButton @click="addGroup" size="small" color="primary"
            >добавить
          </VButton>
        </div>
      </div>
    </VModalWindow>
    <VModalWindow :is-open="editGroupWindowOpened">
      <div class="groups_editGroup">
        <h3 class="editGroup">Редактирование группы #{{ formEditGroup.id }}</h3>
        <VInput
          v-model="formEditGroup.name"
          size="fullWidth"
          placeholder="Название группы"
        ></VInput>
        <VSelect
          v-model="formEditGroup.planTraining"
          size="fullWidth"
          :options="planTrainingStore.plansTraining"
          disabled-option="План обучения"
        />
        <div class="editGroup-actions">
          <VButton @click="switchEditGroupWindow" size="small" color="secondary"
            >отменить
          </VButton>
          <VButton @click="editGroup" size="small" color="primary"
            >готово
          </VButton>
        </div>
      </div>
    </VModalWindow>
  </div>
</template>

<style scoped>
@import 'GroupsView.scss';
</style>
