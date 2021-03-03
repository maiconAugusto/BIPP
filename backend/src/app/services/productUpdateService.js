import { unlink } from 'fs';
import Product from '../model/product/index';

class ProductUpdateService {
  async run({ id, file, body }) {
    if (file === undefined) {
      await Product.update(body, { where: { id } });
      return 'Atualizado com sucesso!';
    }

    const { path: imagePath, filename: imageId } = file;
    const pathToDelete = body.image_path;
    await Product.update({
      ...body, image_path: imagePath, image_id: imageId, active: true,
    }, { where: { id } });
    unlink(pathToDelete, () => {});
    return 'Atualizado com sucesso!';
  }
}
export default new ProductUpdateService();
