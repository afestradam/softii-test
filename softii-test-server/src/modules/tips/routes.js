const express = require('express');

const response = require('../../network/responses')
const controller = require('./controller')

const router = express.Router();

router.get('/', GetTips);
router.post('/', SaveTips);

async function GetTips(req, res) {
    try {
        const items = await controller.GetTips();
        response.success(req, res, items, 200);
    } catch (error) {
        response.error(req, res, error, 500);
    }
}

async function SaveTips(req, res) {
    try {
        const items = await controller.SaveTips(req.body);
        response.success(req, res, "!Saved¡", 200);
    } catch (error) {
        response.error(req, res, error, 500);
    }
}

module.exports = router;