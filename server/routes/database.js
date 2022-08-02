const Pool = require("pg").Pool;

const pool = new Pool({
    user: 'postgres',
    password: 'Whitewater-1105',
    host: 'ffwa-db',
    port: 5432,
    database: 'postgres'
});

module.exports = pool;