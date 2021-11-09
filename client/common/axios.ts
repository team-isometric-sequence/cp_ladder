import axios, { AxiosRequestHeaders } from "axios";

import LocalStorageService from "common/services/local-storage-service"

import { LoginRequiredError } from "common/exceptions";

axios.interceptors.request.use(
  (config) => {
    const headers: AxiosRequestHeaders = config.headers || {};
    const token = LocalStorageService.getAccessToken();
    if (token) {
      headers["Authorization"] = `Bearer ${token}`;
    }
    config.headers = headers;
    config.url = `${process.env.NEXT_PUBLIC_HOST}${config.url}`;
    config.withCredentials = true;
    return config;
  },
  error => {
    console.log("error occured from request");
    Promise.reject(error);
  }
);

axios.interceptors.response.use(
  (response) => {
    return response.data;
  },
  (error) => {
    const response = error.response
    if (response.status === 401) {
      return Promise.reject(new LoginRequiredError());
    }

    return response.data;
  }
);

export default axios;