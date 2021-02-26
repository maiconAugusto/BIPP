import Product from '../model/product/index';

class SearchProductService {
  async run({ id }) {
    const existingProduct = await Product.findOne({ where: { id } });
    if (!existingProduct) {
      throw new Error('Produto não localizado');
    } else {
      return existingProduct;
    }
  }
}
export default new SearchProductService();
