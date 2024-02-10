 const db = require('../../db/mysql');

 function GetTips() {
    return db.GetTipsData();
 }

 function SaveTips(data) {
   return db.SaveTipsData(data);
}


 module.exports = {
    GetTips,
    SaveTips
 }