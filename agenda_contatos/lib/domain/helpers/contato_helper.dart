import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContatoHelper {
  static final ContatoHelper _instance = ContatoHelper.internal();

  factory ContatoHelper() => _instance;

  ContatoHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await inicializarDb();
      return _db;
    }
  }

  Future<Database> inicializarDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contatos.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newVersion) async {
      var sql = new StringBuffer();
      sql.write("CREATE IF NOT EXISTS TABLE CONTATOS(");
      sql.write("CD_CONTATO INTEGER PRIMARY KEY,");
      sql.write("NM_CONTATO TEXT,");
      sql.write("DS_EMAIL TEXT,");
      sql.write("IMG_AVATAR TEXT)");

      await db.execute(sql.toString());
    });
  }
}
