/* eslint-disable react/prop-types */
import React, { useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { Container, Header, Div, Botton } from './styles';
import Card from '../../components/card';
import Text from '../../components/text';
import * as ACTION_GET from '../../store/module/action/product';
import * as ACTION_REMOVE from '../../store/module/action/removeProduct';

const Home = (props) => {
  const dispatch = useDispatch();
  const data = useSelector((state) => state.product.data);

  function getProducts() {
    dispatch(ACTION_GET.RESQUEST());
  }

  function removeProduct(id) {
    dispatch(ACTION_REMOVE.RESQUEST(id));
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
          {data.map((item) => {
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
                  key={item.id}
                  image={item.image_url}
                  name={item.name}
                  price={item.price}
                />
                <Botton onClick={() => removeProduct(item.id)}>Remover</Botton>
              </div>
            );
          })}
        </Div>
      </Container>
    </>
  );
};
export default Home;
