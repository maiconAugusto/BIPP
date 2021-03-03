import { Router } from 'express';

import multer from 'multer';
import storage from '../config/multer/index';
import productController from '../app/controller/productsController';

const upload = multer(storage);
const routes = new Router();

routes.get('/products', productController.index);
routes.get('/product/:id', productController.show);
routes.post('/product', upload.single('file'), productController.store);
routes.put('/product/:id', upload.single('file'), productController.update);
routes.delete('/product/:id', productController.delete);

export default routes;
