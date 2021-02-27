/* eslint-disable no-console */
/* eslint-disable no-empty-pattern */
/* eslint-disable require-yield */
import { all, takeLatest } from 'redux-saga/effects';
// import { toast } from 'react-toastify';
import * as TYPES from '../../types';

function* GetProducts({}) {
  console.log('aqui');
}

export default all([takeLatest(TYPES.GET_PRODUCT_REQUEST, GetProducts)]);
