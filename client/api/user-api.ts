import axios from "common/axios";

export default class UserApi {
  static async getProfile() {
    try {
      const { data } = await axios.get('/api/v1/profile');
      return data;
    } catch (e) {
      return Promise.reject(e);
    }
  }
}