const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send(`
    <html>
      <body style="font-family: Arial; text-align: center; background-color: #f4f4f4;">
        <h1 style="color: #ff4757;">🍕 FoodExpress API</h1>
        <p>Status: <strong>Online</strong></p>
        <p>Environment: Production (us-east-1)</p>
        <hr>
        <p>Ready to serve Cambodian flavors to the world!</p>
      </body>
    </html>
  `);
});

app.listen(port, () => {
  console.log(`FoodExpress listening at http://localhost:${port}`);
});
