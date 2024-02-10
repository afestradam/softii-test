 const db = require('../../db/mysql');

 function GetPaymentMEthods() {
    return db.GetPaymentMEthodsData();
 }

 module.exports = {
   GetPaymentMEthods
 }