const db = require("../utils/db");
const config = require("../config/config");
const oracledb = require("oracledb");

oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

async function proc_CreateUser(pi_username, pi_password) {
  let connection;

  try {
    connection = await oracledb.getConnection({
      host: "localhost",
      port: 1521,
      user: "sys",
      password: "1",
      database: "NodeOra",
      privilege: require("oracledb").SYSDBA,
    });
    const result = await connection.execute(
      
      `BEGIN
           createUser(:pi_username, :pi_password);
        END;`,
      {
        pi_username: `${pi_username}`,
        pi_password: `${pi_password}`
      }
    );
    // console.log(result);
    // return result.rows;
  } catch (err) {
    console.error(err);
  } finally {
    if (connection) {
      try {
        await connection.close();
      } catch (err) {
        console.error(err);
      }
    }
  }
}

const createUserModel = {
  async createUser(username, identify) {
    const status = await proc_CreateUser(username, identify);

    return -1;
  },
};

module.exports = createUserModel;
