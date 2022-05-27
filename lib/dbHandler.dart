import 'package:mysql1/mysql1.dart';
import 'dart:async';

Future connect() async {
  var settings = ConnectionSettings(
      host: '203.252.240.74',
      port: 3306,
      user: 'dblab',
      password: 'dblab6100!@#',
      db: 'ai_dang'
  );
  var conn = MySqlConnection.connect(settings);
  await Future.delayed(const Duration(milliseconds: 300));
  return conn;
}

Future printPreds(conn) async {
  var results = await conn.query('select * from predict');
  return results;
}

  Future insertPreds(conn) async {
  var result = await conn.query('INSERT INTO predict VALUES(?, ?, ?, ?, ?)',
                                ['P20220524-001', null, null, null, null]);
  return result;
}

  Future selectUsers(conn) async {
  var result = await conn.query('select * from user');
  return result;
}

  Future insertUsers(conn, email, gender) async {
  var result = await conn.query('INSERT INTO user VALUES(?,?,?,?,?,?,?,?)',
                                [email, gender]);
  }