const mysql = require('mysql');
const config = require('../config');

const dbconfig = {
    host: config.mysql.host,
    port: config.mysql.port,
    user: config.mysql.user,
    password: config.mysql.password,
    database: config.mysql.database
}

let connection;

function dbConnection() {

    connection = mysql.createConnection(dbconfig);
    connection.connect((err) => {
        if(err){
            console.log('[db err]', err);
        }else{
            console.log('db connected');
        }
    });

    connection.on('error', err => {
        console.log('[db err]', err);
        if(err.code === 'PROTOCOL_CONNECTION_ERROR'){
            console.log('[db err]', err);
        } else {
            throw err;
        }
    })

}

dbConnection();

//Tips 
function GetTipsData (){
    return new Promise((resolve,reject) => {
        let newQuery = "call payedtips_select();";
        connection.query(newQuery, (err, result) => {
            return err ? reject(err) : resolve(result);
        });
    })
}
function SaveTipsData (data) {
    return new Promise((resolve,reject) => {
        let newQuery = `call payedtips_insert(${data.total_tips}, ${data.tip_split}, ${data.tip_value}, ${data.payment_method});`;
        connection.query(newQuery, (err, result) => {
            return err ? reject(err) : resolve(result);
        });
    })
}

//Payments methods
function GetPaymentsMethodsData (){
    return new Promise((resolve,reject) => {
        let newQuery = "call payedtips_select();";
        connection.query(newQuery, (err, result) => {
            return err ? reject(err) : resolve(result);
        });
    })
}

module.exports = {
    GetTipsData,
    SaveTipsData,
    GetPaymentsMethodsData
}