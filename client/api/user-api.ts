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

  static async login(email: string, password: string) {
    try {
      const res = await axios.post('/api/v1/sign_in', { email, password });
      return res;
    } catch (e) {
      return Promise.reject(e);
    }
  }
}