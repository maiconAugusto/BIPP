import { all } from 'redux-saga/effects';

import Product from './product/index';
import RemoveProduct from './removeProduct/index';

export default function* rootSaga() {
  return yield all([Product, RemoveProduct]);
}
