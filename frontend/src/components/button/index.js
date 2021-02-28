/* eslint-disable react/prop-types */
import React from 'react';
import { Button } from './styles';

const ButtonComponent = ({ disabled, onPress, text }) => {
  return (
    <Button disabled={disabled} onClick={onPress}>
      {text}
    </Button>
  );
};
export default ButtonComponent;
