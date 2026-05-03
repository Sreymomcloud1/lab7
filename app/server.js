const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send("Updated from main branch_test1_test2");
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
