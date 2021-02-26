import { Router } from 'express';

import multer from 'multer';
import storage from '../config/multer/index';
import productController from '../app/controller/productsController';
import productStoreValidation from '../app/validators/productStore';
import productStoreUpdate from '../app/validators/productUpdate';

const upload = multer(storage);
const routes = new Router();

routes.get('/products', productController.index);
routes.get('/product/:id', productController.show);
routes.post('/product', productStoreValidation, upload.single('file'), productController.store);
routes.put('/product/:id', productStoreUpdate, upload.single('file'), productController.update);
routes.delete('/product/:id', productController.delete);

export default routes;
