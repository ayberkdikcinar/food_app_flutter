import 'package:food/core/base/base_sqliteDB.dart';
import 'package:food/model/meal_detail_model.dart';
import 'package:sqflite/sqflite.dart';

class FavouritesDatabaseProvider extends BaseSqliteDB<MealDetail> {
  final String _dbName = 'UserFavourite';
  final String _tableName = 'Favourite';
  final int _version = 1;
  @override
  Database? database;

  @override
  Future<void> open() async {
    database = await openDatabase(
      _dbName,
      version: _version,
      onCreate: (db, version) {
        createTable(db);
      },
    );
  }

  Future<void> createTable(Database db) async {
    await db.execute(
      '''CREATE TABLE $_tableName(
      idMeal VARCHAR(20) PRIMARY KEY,
      strMeal VARCHAR(50),
      strMealThumb VARCHAR(50),
      strInstructions VARCHAR(100))''',
    );
  }

  @override
  Future<List<MealDetail?>> getList() async {
    if (database != null) {
      List<Map<String, dynamic>> mealMap = await database!.query(_tableName);
      return mealMap.map((e) => MealDetail().fromJsonForDB(e)).toList();
    }
    return [];
  }

  Future<bool> mealIsExist(String id) async {
    if (database == null) {
      await open();
    }
    final mealMap = await database?.query(_tableName, where: 'idMeal = ?', whereArgs: [id]);
    if (mealMap != null) {
      if (mealMap.isNotEmpty) {
        return true;
      }
      return false;
    }
    return false;
  }

  @override
  Future<void> delete(String id) async {
    await database?.delete(_tableName, where: 'idMeal = ?', whereArgs: [id]);
    print('deleted');
  }

  @override
  Future<void> insert(MealDetail meal) async {
    await database?.insert(_tableName, meal.toJsonForDB());
    print('added');
  }

  @override
  Future<MealDetail> getById(String id) {
    throw UnimplementedError();
  }
}
