import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import App from './App';
import Store from './store/index';
import GlobalStyles from './styles/global';

ReactDOM.render(
  <React.StrictMode>
    <Provider store={Store}>
      <App />
      <GlobalStyles />
    </Provider>
  </React.StrictMode>,
  document.getElementById('root')
);
