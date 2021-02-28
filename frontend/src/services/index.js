import axios from 'axios';

const apiUrl = 'http://localhost:8081/';

const api = axios.create({
  timeout: 10000,
  baseURL: apiUrl,
});
export default api;
