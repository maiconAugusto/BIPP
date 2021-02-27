import { createGlobalStyle } from 'styled-components';

export default createGlobalStyle`
  *{
    margin: 0;
    padding: 0;
    outline: 0;
    box-sizing: border-box;

    text, strong {
      font-family: 'Quicksand'
    }

    html, body, #root {
      height: 100%;
      background-color: #0C2338;
    }
  }
`;
