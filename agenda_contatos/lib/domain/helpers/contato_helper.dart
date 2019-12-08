import 'package:agenda_contatos/domain/models/contato.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String _contatoTabela = "Contatos";
final String _idColuna = "ID_CONTATO";
final String _nomeColuna = "NM_CONTATO";
final String _emailColuna = "DS_EMAIL";
final String _avatarColuna = "IMG_CONTATO";

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
      db.execute("CREATE IF NOT EXISTS TABLE $_contatoTabela("
          "$_idColuna INTEGER PRIMARY KEY,"
          "$_nomeColuna TEXT,"
          "$_emailColuna TEXT,"
          "$_avatarColuna TEXT)");
    });
  }

  Future<Contato> inserirContato(Contato contato) async {
    var dbContato = await db;

    contato.id = await dbContato.insert(_contatoTabela, contato.toMap());

    return contato;
  }

  Future<Contato> obterContato(int idContato) async {
    var dbContato = await db;

    List<Map> contatos = await dbContato.query(_contatoTabela,
        columns: [_idColuna, _nomeColuna, _emailColuna, _avatarColuna],
        where: "$_idColuna = ?",
        whereArgs: [idContato]);

    if (contatos.length > 0)
      return Contato.fromMap(contatos.first);
    else
      return null;
  }

  Future<int> excluirContato(int idContato) async {
    var dbContato = await db;

    return await dbContato.delete(_contatoTabela,
        where: "$_idColuna = ?", 
        whereArgs: [idContato]);
  }
  
  Future<int> atualizarContato(Contato contato) async{
    var dbContato = await db;

     return await dbContato.update(_contatoTabela, 
        contato.toMap(),
        where:"$_idColuna = ?",
        whereArgs: [contato.id]);
  }

  Future<List<Contato>> obterContatos() async{
    var dbContato = await db;

    List contatoMap = await dbContato.rawQuery("SELECT * FROM $_contatoTabela");

    List<Contato> contatos = new List<Contato>();

    for(Map map in contatoMap){
      contatos.add(Contato.fromMap(map));
    }

    return contatos;
  }

  Future dispose() async{
    var dbContato = await db;

    dbContato.close();
  }
}