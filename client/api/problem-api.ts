import axios from "common/axios";

export default class ProblemApi {
  static async getProblems(page: number) {
    try {
      const { data } = await axios.get(`/api/v1/problems?page=${page}`);
      return data;
    } catch (e) {
      return Promise.reject(e);
    }
  }

}