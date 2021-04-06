const db = require("../utils/db");
const config = require("./../config/config");
const oracledb = require("oracledb");

const userModel = {
  updateUser(username, newPassword) {
    const sql = `ALTER USER ${username} IDENTIFIED BY ${newPassword}`;
    console.log(sql);

    return db.load(sql);
  },
  deleteUser(username) {
    const sql = `
    BEGIN
    deleteUser('${username}');
    END;
    `;
    console.log(sql);
    return db.load(sql);
  },
  revokeUserPermission(
    username,
    privilege,
    tableName,
    // withGrantOption,
    columnValue
  ) {
    let sql = ``;

    if (columnValue === "" || columnValue === undefined) {
      sql = `REVOKE ${privilege} ON ${tableName} FROM ${username}`;
    } else {
      sql = `REVOKE ${privilege}(${columnValue}) ON ${tableName} FROM ${username}`;
    }

    console.log(sql);

    return db.load(sql);
  },
  async createUser(username, identify) {
    const sql = `BEGIN createUser('${username}','${identify}'); END;`;
    const status = await db.load(sql);
    console.log(status);
    return status;
  },
};

module.exports = userModel;
