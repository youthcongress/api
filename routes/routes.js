const express = require('express');
const app = express.Router();

app.use('/', require('./scripts/index.js'))
app.use('/about', require('./scripts/about.js'))
app.use('/contact', require('./scripts/contact.js'))

module.exports = { app };