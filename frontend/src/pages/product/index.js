/* eslint-disable react/destructuring-assignment */
/* eslint-disable react/prop-types */
import React from 'react';
import { Container, CardContainer } from './styles';
import Card from '../../components/card';

const Product = (props) => {
  const { image_url: img, name, price } = props.location.state.product;
  return (
    <Container>
      <CardContainer>
        <Card image={img} name={name} price={price} />
      </CardContainer>
    </Container>
  );
};
export default Product;
