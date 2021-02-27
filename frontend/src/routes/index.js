import React from 'react';
import { BrowserRouter, Switch, Route } from 'react-router-dom';

import Home from '../pages/home';
import Product from '../pages/product';

const Routes = () => {
  return (
    <BrowserRouter>
      <Switch>
        <Route path="/" exact component={Home} />
        <Route path="/produto" exact component={Product} />
      </Switch>
    </BrowserRouter>
  );
};
export default Routes;
