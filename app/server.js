const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send("🚀 DevOps CI/CD Pipeline Running Successfully!");
});

app.get('/health', (req, res) => {
    res.json({
        status: "UP",
        service: "AUPP DevOps App"
    });
});

app.listen(3000, () => {
    console.log("Server running on port 3000");
});
