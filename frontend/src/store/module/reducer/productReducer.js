import * as TYPES from '../types';

const INITIAL_STATE = {
  loading: false,
  data: [],
};

export default function (state = INITIAL_STATE, action) {
  switch (action.type) {
    case TYPES.GET_PRODUCT_REQUEST: {
      const newState = { ...state, action };
      newState.loading = true;
      return newState;
    }
    case TYPES.PRODUCT_REQUEST_SUCCESS: {
      const newState = { ...state, action };
      newState.loading = false;
      newState.data = action.payload;
      return newState;
    }
    case TYPES.PRODUCT_REQUEST_FAILURE: {
      const newState = { ...state, action };
      newState.loading = false;
      return newState;
    }
    default: {
      return state;
    }
  }
}
