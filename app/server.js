const express = require('express');
const app = express();

const PORT = 3000;

app.get('/', (req, res) => {
  res.send('🍔 FoodExpress API is running!');
});

app.get('/health', (req, res) => {
  res.json({ status: 'OK' });
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
