const express = require('express');

const response = require('../../network/responses')
const controller = require('./controller')

const router = express.Router();

router.get('/', GetPaymentMEthods);

async function GetPaymentMEthods(req, res) {
    try {
        const items = await controller.GetPaymentMEthods();
        response.success(req, res, items, 200);
    } catch (error) {
        response.error(req, res, error, 500);
    }
}

module.exports = router;