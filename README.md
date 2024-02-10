# softii-test
Prueba técnica

Esta prueba se realizó usando las siguientes tecnologías:
- Vue.js
- Typescript
- Node.js
- Express.js

Consta de 3 carpetas.
- DB: contiene el backup de la base de datos MySql.
- softii-test: contiene el front desarrollado con vue y typescript
- softii-test-server: contiene el back desarrollado con express.

El back corre en el puerto 4000 y solo contiene 3 rutas
Consulta de todas las propinas
GET: http://localhost:4000/api/tips

Registro d euna nueva propina
POST: http://localhost:4000/api/tips

Consulta de métodos de pagos
GET: http://localhost:4000/api/payments-methods

El back consta del las siguientes variables de entorno
PORT = 4000
MYSQL_HOST = localhost
MYSQL_PORT = 3306
MYSQL_USER = root
MYSQL_PASSWORD = root
MYSQL_DB = softii_test

