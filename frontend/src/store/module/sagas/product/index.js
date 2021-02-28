import { all, takeLatest, call, put } from 'redux-saga/effects';
import { toast } from 'react-toastify';
import * as TYPES from '../../types';
import api from '../../../../services/index';
import * as ACTION_GET_PRODUCT from '../../action/product';

function* GetProducts() {
  try {
    const response = yield call(api.get, 'products');
    const { data } = response.data;
    yield put(ACTION_GET_PRODUCT.SUCESS_REQUEST(data));
  } catch (error) {
    const { error: erro } = error.response.data;
    toast.error(`⚠ ${erro}`);
  }
}

export default all([takeLatest(TYPES.GET_PRODUCT_REQUEST, GetProducts)]);
