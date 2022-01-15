import axios from "common/axios";

export default class ProblemApi {
  static async getProblems({ page = 1, orderBy = "", schoolName = "", tagName = ""}) {
    try {
      const { data } = await axios.get(`/api/v1/problems?school=${schoolName}&page=${page}&order_by=${orderBy}&tag=${tagName}`);
      return data;
    } catch (e) {
      return Promise.reject(e);
    }
  }

}