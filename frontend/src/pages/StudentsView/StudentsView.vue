<script setup>
import VSidebar from '@/components/VSidebar/VSidebar.vue'
import VTable from '@/components/VTable/VTable.vue'
import VHeader from '@/components/VHeader/VHeader.vue'
import VInput from '@/components/UI/VInput/VInput.vue'
import VModalWindow from '@/components/UI/VModalWindow/VModalWindow.vue'
import VButton from '@/components/UI/VButton/VButton.vue'
import VSelect from '@/components/UI/VSelect/VSelect.vue'
import studentService from '@/API/studentService.js'
import { useStudentStore } from '@/store/studentStore.js'
import { ref } from 'vue'
import { useGroupStore } from '@/store/groupStore.js'

const studentStore = useStudentStore()
const groupStore = useGroupStore()

const addStudentWindowOpened = ref(false)
const editStudentWindowOpened = ref(false)

const dataStudent = ref({
  fio: '',
  address: '',
  group: '',
  phone: '',
})

const dataStudentForEdit = ref({
  id: '',
  fio: '',
  address: '',
  group: '',
  phone: '',
})

const tableHead = [
  {
    id: 1,
    name: 'ID',
  },
  {
    id: 2,
    name: 'ФИО',
  },
  {
    id: 3,
    name: 'адрес',
  },
  {
    id: 4,
    name: 'группа',
  },
  {
    id: 5,
    name: 'телефон',
  },
]

const switchAddStudentWindow = () => {
  addStudentWindowOpened.value = !addStudentWindowOpened.value
}

const switchEditStudentWindow = (data) => {
  editStudentWindowOpened.value = !editStudentWindowOpened.value
  if (editStudentWindowOpened.value) {
    dataStudentForEdit.value = {
      id: data.id,
      fio: data.fio,
      address: data.address,
      group: data.group,
      phone: data.phone,
    }
  }
}

const addStudent = async () => {
  const reqAddStudent = await studentService.addStudent(dataStudent.value)
  if (!reqAddStudent.errno) {
    studentStore.students.push({
      id: reqAddStudent.insertId,
      fio: dataStudent.value.fio,
      address: dataStudent.value.address,
      group: dataStudent.value.group,
      phone: dataStudent.value.phone,
    })
  } else {
    console.log(reqAddStudent)
  }
}

const editStudent = async () => {
  const reqEditStudent = studentService.editStudent(
    dataStudentForEdit.value,
    dataStudentForEdit.value.id
  )
  if (!reqEditStudent.errno) {
    const index = studentStore.students.findIndex(
      (student) => student.id === dataStudentForEdit.value.id
    )
    studentStore.students[index].fio = dataStudentForEdit.value.fio
    studentStore.students[index].address = dataStudentForEdit.value.address
    studentStore.students[index].group = dataStudentForEdit.value.group
    studentStore.students[index].phone = dataStudentForEdit.value.phone
  } else {
    console.log(reqEditStudent)
  }
}

const deleteById = async (id) => {
  const reqDeleteStudent = await studentService.deleteStudentById(id)
  if (!reqDeleteStudent.errno) {
    const index = studentStore.students.findIndex(
      (student) => student.id === id
    )
    if (index !== -1) {
      studentStore.students.splice(index, 1)
    }
  } else {
    console.log(reqDeleteStudent)
  }
}

const getNameGroup = (id) => {
  const groups = groupStore.groups
  return groups.filter((group) => group.value === id)[0].title
}

await groupStore.getGroups()
await studentStore.getStudents()
</script>

<template>
  <div class="students">
    <VSidebar class="" />
    <div class="students-body">
      <VHeader />
      <h2 class="students-title">Студенты</h2>
      <VTable
        @switchAddWindow="switchAddStudentWindow"
        @deleteById="deleteById"
        :data-table="studentStore.students"
        :options="groupStore.groups"
        :tableHead="tableHead"
        title="Данные студентов"
      >
        <transition-group name="list" tag="p">
          <tr
            class="table-body-row"
            v-for="data in studentStore.students"
            :key="data.id"
          >
            <td>{{ data.id }}</td>
            <td>{{ data.fio }}</td>
            <td>{{ data.address }}</td>
            <td>{{ getNameGroup(data.group) }}</td>
            <td>{{ data.phone }}</td>
            <td>
              <VButton @click="deleteById(data.id)" size="icon" variant="text">
                <v-icon color="red">mdi-delete</v-icon>
              </VButton>
              <VButton
                @click="switchEditStudentWindow(data)"
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
    <VModalWindow :is-open="addStudentWindowOpened">
      <div class="students_addStudent">
        <h3 class="addStudent-title">Добавление студента</h3>
        <div class="addStudent-form">
          <VInput
            v-model="dataStudent.fio"
            size="fullWidth"
            placeholder="ФИО"
          ></VInput>
          <VInput
            v-model="dataStudent.address"
            size="fullWidth"
            placeholder="Адрес"
          ></VInput>
          <VSelect
            v-model="dataStudent.group"
            size="fullWidth"
            :options="groupStore.groups"
            disabled-option="Группа"
          ></VSelect>
          <VInput
            v-model="dataStudent.phone"
            size="fullWidth"
            placeholder="Телефон"
          ></VInput>
          <div class="addStudent-actions">
            <v-button
              @click="switchAddStudentWindow()"
              size="small"
              color="secondary"
              >закрыть
            </v-button>
            <v-button
              @click="addStudent()"
              class="button-add"
              size="small"
              color="primary"
              >добавить
            </v-button>
          </div>
        </div>
      </div>
    </VModalWindow>
    <!--    Редактирование-->
    <VModalWindow :is-open="editStudentWindowOpened">
      <div class="students_addStudent">
        <h3 class="addStudent-title">
          Редактирование студента #{{ dataStudentForEdit.id }}
        </h3>
        <div class="addStudent-form">
          <VInput
            v-model="dataStudentForEdit.fio"
            size="fullWidth"
            placeholder="ФИО"
          ></VInput>
          <VInput
            v-model="dataStudentForEdit.address"
            size="fullWidth"
            placeholder="Адрес"
          ></VInput>
          <VSelect
            v-model="dataStudentForEdit.group"
            size="fullWidth"
            :options="groupStore.groups"
            disabled-option="Группа"
          ></VSelect>
          <VInput
            v-model="dataStudentForEdit.phone"
            size="fullWidth"
            placeholder="Телефон"
          ></VInput>
          <div class="addStudent-actions">
            <v-button
              @click="switchEditStudentWindow()"
              size="small"
              color="secondary"
              >закрыть
            </v-button>
            <v-button
              @click="editStudent()"
              class="button-add"
              size="small"
              color="primary"
              >готово
            </v-button>
          </div>
        </div>
      </div>
    </VModalWindow>
  </div>
</template>

<style scoped>
@import 'StudentsView.scss';
</style>
