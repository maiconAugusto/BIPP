/* eslint-disable no-undef */
import express from 'express';
import { resolve } from 'path';
import cors from 'cors';
import connection from '../database/index';
import routes from '../routes/index';

class Server {
  constructor() {
    this.server = express();
    this.db = connection;
    this.database();
    this.middleware();
    this.route();
  }

  middleware() {
    this.server.use(cors());
    this.server.use(express.json());
    this.server.use(express.urlencoded({ extended: true, limit: '50mb' }));
    this.server.use('/file', express.static(resolve(__dirname, '..', 'uploads')));
  }

  database() {
    this.db.authenticate();
  }

  route() {
    this.server.use(routes);
  }
}
export default new Server().server;
