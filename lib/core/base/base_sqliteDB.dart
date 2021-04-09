import 'package:food/core/base/base_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseSqliteDB<T extends BaseModel> {
  Future<void> open();
  Future<List<T?>> getList();
  Future<void> delete(String id);
  Future<void> insert(T model);
  Future<T> getById(String id);
  Database? database;
}
