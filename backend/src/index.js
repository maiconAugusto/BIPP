import app from './server/index';

const port = 8081;

app.listen(port, () => {
  console.log('server running!');
});
