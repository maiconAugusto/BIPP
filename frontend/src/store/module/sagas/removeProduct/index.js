import { all, takeLatest, call, put } from 'redux-saga/effects';
import { toast } from 'react-toastify';
import * as TYPES from '../../types';
import api from '../../../../services/index';
import * as ACTION_REMOVE_PRODUCT from '../../action/removeProduct';

function* RemoveProduct({ payload }) {
  try {
    yield call(api.delete, `product/${payload}`);
    toast.success('Produto removido com sucesso!');

    yield put(ACTION_REMOVE_PRODUCT.SUCCESS_REQUEST(payload));
  } catch (error) {
    const { error: erro } = error.response.data;

    yield put(ACTION_REMOVE_PRODUCT.FAILURE_REQUEST());
    toast.error(`⚠ ${erro}`);
  }
}

export default all([takeLatest(TYPES.REMOVE_PRODUCT_REQUEST, RemoveProduct)]);
