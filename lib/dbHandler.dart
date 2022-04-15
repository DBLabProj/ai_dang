import 'package:mysql1/mysql1.dart';
import 'dart:async';

class DbHandler {
  Future connect() async {
    var settings = ConnectionSettings(
        host: '203.252.240.74',
        port: 3306,
        user: 'dblab',
        password: 'dblab6100!@#',
        db: 'test'
    );
    var conn = MySqlConnection.connect(settings);
    await Future.delayed(const Duration(milliseconds: 100));
    return conn;
  }

  Future printData(conn) async {
    var results = await conn.query('select * from users');
    return results;
  }
}