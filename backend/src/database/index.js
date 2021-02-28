import Sequelize from 'sequelize';
import { config } from 'dotenv';

config();

const database = new Sequelize(process.env.DATABASE_NAME, process.env.USER, process.env.PASSWORD, {
  host: process.env.LOCALHOST,
  dialect: process.env.DIALECT,
  port: process.env.PORT
});
export default database;
