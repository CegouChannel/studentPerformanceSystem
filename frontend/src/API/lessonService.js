import { axiosInstance } from '@/utils/axios/axios'

export default class LessonService {
  static async getData() {
    try {
      const response = await axiosInstance({
        url: '/lessons',
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/json',
        },
        method: 'GET',
      })
      return response.data
    } catch (e) {
      throw e
    }
  }

  static async addLesson(dataGroup) {
    try {
      const response = await axiosInstance({
        url: '/lessons',
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/json',
        },
        method: 'POST',
        data: JSON.stringify({
          name: dataGroup.name,
          planTraining: dataGroup.planTraining,
        }),
      })
      return response.data
    } catch (e) {
      throw e
    }
  }

  static async editLesson(data, id) {
    try {
      const response = await axiosInstance({
        url: `/lessons/${id}`,
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/json',
        },
        method: 'PUT',
        data: JSON.stringify({
          name: data.name,
          planTraining: data.planTraining,
        }),
      })
      return response.data
    } catch (e) {
      throw e
    }
  }

  static async deleteLessonById(id) {
    try {
      const response = await axiosInstance({
        url: `/groups/${id}`,
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/json',
        },
        method: 'DELETE',
        data: JSON.stringify({
          id: id,
        }),
      })
      return response.data
    } catch (e) {
      throw e
    }
  }
}
