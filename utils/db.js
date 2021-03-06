const oracledb = require("oracledb");

oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

async function run(sql) {
  let connection;

  try {
    connection = await oracledb.getConnection({
      host: "localhost",
      port: 1521,
      user: "DUCCAO_ADMIN",
      password: "DUCCAO_ADMIN",
      database: "HospitalManagement",
      privilege: require("oracledb").DEFAULT,
    });

    // connection = await oracledb.getConnection({
    //   host: "localhost",
    //   port: 1521,
    //   user: "sys",
    //   password: "1",
    //   database: "HospitalManagement",
    //   privilege: require("oracledb").SYSDBA,
    // });

    // MAY ONG BI LOI GI R
    //

    const result = await connection.execute(sql);

    return result.rows;
  } catch (err) {
    console.log("error in oracledb: ", err);
    throw new Error(err);
  } finally {
    if (connection) {
      try {
        await connection.close();
      } catch (err) {
        console.log("connection to oracle error: ", err);
        throw new Error(err);
      }
    }
  }
}

async function userRun(sql, username, password) {
  let connection;

  try {
    connection = await oracledb.getConnection({
      host: "localhost",
      port: 1521,
      user: username,
      password: password,
      database: "HospitalManagement",
      privilege: require("oracledb").DEFAULT,
    });

    const result = await connection.execute(sql);

    return result.rows;
  } catch (err) {
    console.log("error in oracledb: ", err);
    throw new Error(err);
  } finally {
    if (connection) {
      try {
        await connection.close();
      } catch (err) {
        console.log("connection to oracle error: ", err);
        throw new Error(err);
      }
    }
  }
}

async function runProcedure(procName, para1, para2) {
  let connection;

  try {
    connection = await oracledb.getConnection({
      host: "localhost",
      port: 1521,
      user: "DUCCAO_ADMIN",
      password: "DUCCAO_ADMIN",
      database: "HospitalManagement",
      privilege: require("oracledb").DEFAULT,
    });
    // connection = await oracledb.getConnection({
    //   host: "localhost",
    //   port: 1521,
    //   user: "sys",
    //   password: "1",
    //   database: "NodeOra",
    //   privilege: require("oracledb").SYSDBA,
    // });
    const executeCommand = `BEGIN
    ${procName}('${para1}', '${para2}');
  END;`;

    console.log(executeCommand);

    const result = await connection.execute(executeCommand, {
      // bind variables
      // para1: {
      //   dir: oracledb.BIND_IN,
      //   val: para1,
      //   type: oracledb.DB_TYPE_NVARCHAR,
      // },
      // para2: {
      //   dir: oracledb.BIND_IN,
      //   val: para1,
      //   type: oracledb.DB_TYPE_NVARCHAR,
      // },
      //   para2: { dir: oracledb.BIND_OUT, type: oracledb.STRING, maxSize: 40 },
    });

    return result.rows;
  } catch (err) {
    console.log("error in oracledb: ", err);
    throw new Error(err);
  } finally {
    if (connection) {
      try {
        await connection.close();
      } catch (err) {
        console.log("error in oracledb: ", err);
        throw new Error(err);
      }
    }
  }
}

module.exports = {
  load: (sql) => {
    return run(sql);
  },

  userLoad(sql, username, password) {
    return userRun(sql, username, password);
  },

  loadProc: (procName, para1, para2) => {
    return runProcedure(procName, para1, para2);
  },
};
