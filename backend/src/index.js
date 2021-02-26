import app from './server/index';

const port = 8080;

app.listen(port, () => {
  console.log('server running!');
});
