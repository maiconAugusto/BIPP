import Sequelize from 'sequelize';
import DATABASE from '../../../database/index';

const product = DATABASE.define('product', {
  id: {
    allowNull: false,
    type: Sequelize.UUID,
    defaultValue: Sequelize.UUIDV4,
    primaryKey: true,
  },
  name: {
    type: Sequelize.STRING,
    allowNull: false,
  },
  description: { type: Sequelize.TEXT, allowNull: true },
  price: {
    type: Sequelize.DOUBLE,
    allowNull: false,
  },
  active: { type: Sequelize.BOOLEAN, allowNull: false },
  image_path: { type: Sequelize.STRING, allowNull: false },
  image_id: {
    type: Sequelize.STRING,
    allowNull: false,
  },
  quantity: {
    type: Sequelize.INTEGER,
    allowNull: false,
  },
  image_url: {
    type: Sequelize.VIRTUAL,
    get() {
      if (this.image_id === null) {
        return null;
      }
      return `http://${process.env.IP_LOCATION}:${process.env.PORT_API}/file/${this.image_id}`;
    },
  },
});
product.sync({ force: false, alter: true });
export default product;
