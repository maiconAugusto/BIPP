import axios from 'axios';

const api = axios.create({
  baseURL: 'localhost:8081/',
});
export default api;
