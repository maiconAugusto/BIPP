import * as TYPES from '../types';

export function RESQUEST(payload) {
  return {
    type: TYPES.GET_PRODUCT_REQUEST,
    payload,
  };
}
export function SUCESS_REQUEST(payload) {
  return {
    type: TYPES.PRODUCT_REQUEST_SUCCESS,
    payload,
  };
}
export function FAILURE_REQUEST(payload) {
  return {
    type: TYPES.PRODUCT_REQUEST_FAILURE,
    payload,
  };
}
