import * as TYPES from '../types';

export function RESQUEST(payload) {
  return {
    type: TYPES.REMOVE_PRODUCT_REQUEST,
    payload,
  };
}
export function SUCCESS_REQUEST(payload) {
  return {
    type: TYPES.REMOVE_PRODUCT_SUCCESS,
    payload,
  };
}
export function FAILURE_REQUEST(payload) {
  return {
    type: TYPES.REMOVE_PRODUCT_FAILURE,
    payload,
  };
}
