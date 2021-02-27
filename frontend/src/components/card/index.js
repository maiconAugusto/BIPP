/* eslint-disable react/prop-types */
import React from 'react';
import PropTypes from 'prop-types';
import { Card, Img } from './styles';
import Text from '../text';

const CardContainer = ({ image, name, price, onPress }) => {
  function resolveSuffix(productPrice) {
    const value = productPrice.replace('.', ',');
    return value;
  }
  return (
    <Card onClick={onPress}>
      <Img src={image} />
      <div style={{ justifyContent: 'center' }}>
        <Text style={{ fontSize: 16 }} text={name} />
      </div>
      <div>
        <strong style={{ color: '#259043' }}>
          R$ {resolveSuffix(parseFloat(price).toFixed(2))}
        </strong>
      </div>
    </Card>
  );
};
CardContainer.defaultProps = {
  imageUrl: '',
  name: 'Não informado',
  price: 0.0,
};
CardContainer.protoTypes = {
  imageUrl: PropTypes.string.isRequired,
  name: PropTypes.string.isRequired,
  price: PropTypes.number.isRequired,
};
export default CardContainer;
