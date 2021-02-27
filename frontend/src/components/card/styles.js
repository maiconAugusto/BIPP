import styled from 'styled-components';

export const Card = styled.div`
  display: flex;
  flex-direction: column;
  width: 200px;
  height: 290px;
  border-radius: 8px;
  background-color: white;
  align-items: center;
  margin: 10px;
  cursor: pointer;

  div {
    display: flex;
    flex: 1;
    flex-direction: column;
    text-align: center;
  }
`;
export const Img = styled.img`
  margin-top: 10px;
  height: 170px;
  background-color: transparent;
`;
