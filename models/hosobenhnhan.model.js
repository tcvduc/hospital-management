const db = require("../utils/db");

const benhnhanModel = {
  async len() {
    const sql = `SELECT * FROM DUCCAO_ADMIN.HOSOBENHNHAN `;
    const ret = await db.load(sql);

    return ret.length;
  },
};

module.exports = benhnhanModel;
