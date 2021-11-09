export default class LocalStorageService {
  static getAccessToken() {
    return localStorage.getItem('CP_LADDER_JWT');
  }

  static setAccessToken(token: string) {
    return localStorage.setItem('CP_LADDER_JWT', token);
  }
}