import axios from "common/axios";

export default class ProblemApi {
  static async getProblems(page: number, orderBy: string) {
    try {
      const { data } = await axios.get(`/api/v1/problems?page=${page}&order_by=${orderBy}`);
      return data;
    } catch (e) {
      return Promise.reject(e);
    }
  }

}