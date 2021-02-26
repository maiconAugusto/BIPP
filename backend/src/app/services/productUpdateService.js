import { unlink } from 'fs';
import Product from '../model/product/index';

class ProductUpdateService {
  async run({ id, file, body }) {
    if (file === undefined) {
      await Product.update(body, { where: { id } });
      return 'Atualizado com sucesso!';
    }

    const { path: imagePath, filename: imageId } = file;
    await Product.update({ where: { id } }, { ...body, image_path: imagePath, image_id: imageId });
    unlink(body.image_path, () => {});
    return 'Atualizado com sucesso!';
  }
}
export default new ProductUpdateService();
