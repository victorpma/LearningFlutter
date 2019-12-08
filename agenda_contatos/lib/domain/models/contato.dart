class Contato {
  int id;
  String nome;
  String email;
  String avatar;

  Contato();

  Contato.fromMap(Map map){
    id = map["ID_CONTATO"];
    nome = map["NM_CONTATO"];
    email = map["DS_EMAIL"];
    avatar = map["IMG_CONTATO"];
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> contatoMap = new Map();
    
    contatoMap["ID_CONTATO"] = id;
    contatoMap["NM_CONTATO"] = nome;
    contatoMap["DS_EMAIL"] = email;
    contatoMap["IMG_CONTATO"] = avatar;

    return contatoMap;
  }

  @override
  String toString() {    
    return "Contato(id: $id, nome: $nome, email: $email, imagem: $avatar";
  }
}
