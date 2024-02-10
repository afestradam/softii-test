const express = require('express');
const cors = require('cors')
const config = require('./config');

const tips = require('./modules/tips/routes');
const paymentsmethods = require('./modules/payments-methods/routes');

const app = express();

//Middlewares
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

//Declaración de variables
app.set('port', config.app.port);

//Rutas
//-----Tips
app.use('/api/tips', tips);
//-----Payments Methods
app.use('/api/payments-methods', paymentsmethods);

module.exports = app;