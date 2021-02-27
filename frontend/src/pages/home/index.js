/* eslint-disable react/prop-types */
import React, { useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { Container, Header, Div, Botton } from './styles';
import Card from '../../components/card';
import Text from '../../components/text';
import * as ACTION from '../../store/module/action/product';

const Home = (props) => {
  const dispatch = useDispatch();
  const data = useSelector((state) => state.product.data);

  function getProducts() {
    dispatch(ACTION.RESQUEST());
  }

  useEffect(() => {
    getProducts();
  }, []);

  return (
    <>
      <Header>
        <Text style={{ fontSize: 22, color: 'white' }} text="Produtos" />
      </Header>
      <Container>
        <Div>
          {data.map((item, index) => {
            return (
              <div
                style={{
                  display: 'flex',
                  flexDirection: 'column',
                  justifyContent: 'center',
                  alignItems: 'center',
                }}
              >
                <Card
                  onPress={() =>
                    props.history.push('/produto', { product: item })
                  }
                  key={toString(index)}
                  image={item.image_url}
                  name={item.name}
                  price={item.price}
                />
                <Botton onClick={() => alert('remove')}>Remover</Botton>
              </div>
            );
          })}
        </Div>
      </Container>
    </>
  );
};
export default Home;
