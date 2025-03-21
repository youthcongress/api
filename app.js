const express = require('express');
const app = express();
const port = 8010;

app.set('view engine', 'ejs');
app.use('/static', express.static('static'));

app.use('/', require('./routes/routes').app);

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
    });
