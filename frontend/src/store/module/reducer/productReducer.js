import * as TYPES from '../types';

const INITIAL_STATE = {
  loading: false,
  loadingDeleting: false,
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
    case TYPES.REMOVE_PRODUCT_REQUEST: {
      const newState = { ...state, action };
      newState.loadingDeleting = true;
      return newState;
    }
    case TYPES.REMOVE_PRODUCT_SUCCESS: {
      const newState = { ...state, action };
      newState.data = state.data.filter((item) => item.id !== action.payload);
      newState.loadingDeleting = false;
      return newState;
    }
    case TYPES.REMOVE_PRODUCT_FAILURE: {
      const newState = { ...state, action };
      newState.loadingDeleting = false;
      return newState;
    }
    default: {
      return state;
    }
  }
}
