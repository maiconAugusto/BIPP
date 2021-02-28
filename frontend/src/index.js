import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import App from './App';
import Store from './store/index';
import GlobalStyles from './styles/global';

ReactDOM.render(
  <React.StrictMode>
    <Provider store={Store}>
      <App />
      <ToastContainer autoClose={5000} />
      <GlobalStyles />
    </Provider>
  </React.StrictMode>,
  document.getElementById('root')
);
