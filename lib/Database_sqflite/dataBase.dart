
import 'package:sqflite/sqflite.dart'as sqfl;
class SqflDataBase{
  // create  database

  static Future<sqfl.Database> openDb() async{
   return await sqfl.openDatabase('registerDatabse',version: 1,
   onCreate: (sqfl.Database db,int version)async{
    await createTable(db);
   });
  }

  static Future<void> createTable(sqfl.Database db) async{
   await db.execute("""CREATE TABLE user (
   id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
   name TEXT,
   email TEXT,
   course TEXT,
   gender TEXT,
   password TEXT
   )""");


  }

  //CREATE new user
static Future<int> addNewuser(String name,String email,String course,String gender,String password)async{
    final db= await SqflDataBase.openDb();
    final data={'name':name,'email':email,'course':course,'gender':gender,'password':password};
    final id=db.insert('user', data);
    return id;
}

  static Future<List<Map>> checkUser(String Email)async {
    final db=await SqflDataBase.openDb();
    final data = await db.rawQuery("SELECT * FROM user WHERE email ='$Email'");
    if(data.isNotEmpty) {
      return data;
    }
    return data;
  }

  static Future<List<Map>>CheckLogin(String email, String password) async{
    final db=await SqflDataBase.openDb();
    final data = await db.rawQuery("SELECT * FROM user WHERE email='$email' AND password ='$password'");

    if(data.isNotEmpty){
      return data;

    }
    return data;
  }

  static Future<List<Map>> getAll()async{

    final db=await SqflDataBase.openDb();
    final data=await db.rawQuery("SELECT * FROM user");
    return data;
  }

  static Future<void>deleteUser(int id)async{
    final db=await SqflDataBase.openDb();
    db.delete('user',where: 'id=?',whereArgs: [id]);
  }

 }