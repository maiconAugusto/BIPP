import { Op } from 'sequelize';
import Product from '../model/product/index';
import ProductUpdateService from '../services/productUpdateService';
import SearchProductService from '../services/searchProductService';
import DeleteFile from '../services/deleteFileService';

class ProductController {
  async index(request, response) {
    try {
      const data = await Product.findAll({
        where: {
          [Op.and]: {
            quantity: {
              [Op.gt]: 1,
            },
            active: {
              [Op.eq]: true,
            },
          },
        },
      });
      return response.status(200).json({ data });
    } catch (err) {
      return response.status(400).json({ data: err });
    }
  }

  async show(request, response) {
    try {
      const { id } = request.params;
      const data = await SearchProductService.run({ id });
      return response.status(200).json({ data });
    } catch (err) {
      return response.status(404).json({ error: 'Produto não localizado!' });
    }
  }

  async store(request, response) {
    try {
      const product = {
        name: request.body.name,
        description: request.body.description,
        price: request.body.price,
        quantity: request.body.quantity,
        active: request.body.active,
        image_path: request.file.path,
        image_id: request.file.filename,
      };

      const data = await Product.create(product);

      return response.status(201).json({ data });
    } catch (err) {
      return response.status(400).json({ data: err });
    }
  }

  async update(request, response) {
    try {
      const { id } = request.params;
      await SearchProductService.run({ id });

      const data = await ProductUpdateService.run({
        id,
        file: request.file,
        body: request.body,
      });

      return response.status(200).json({ data });
    } catch (error) {
      return response.status(404).json({ error: 'Produto não localizado!' });
    }
  }

  async delete(request, response) {
    try {
      const { id } = request.params;

      const data = await SearchProductService.run({ id });

      await Product.destroy({ where: { id } });

      DeleteFile.run({ path: data.image_path });

      return response.status(200).json({ data: 'Produto deletado com sucesso' });
    } catch (error) {
      return response.status(404).json({ error: 'Produto não localizado!' });
    }
  }
}
export default new ProductController();
