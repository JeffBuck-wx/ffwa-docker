const express = require('express');
const indexRouter = require('./routes/app.js');
const cors = require("cors");

const app = express();

// middleware
app.use(cors());
app.use(express.json());
app.use('/', indexRouter);

app.listen(3001, () => {
    console.log('Express is running on port 3001.');
});