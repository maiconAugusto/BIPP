import { all } from 'redux-saga/effects';

import Product from './product/index';

export default function* rootSaga() {
  return yield all([Product]);
}
