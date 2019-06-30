class ContatoModel {
  int id;
  String nome;
  String email;
  String avatar;

  ContatoModel.fromMap(Map map) {
    id = map["CD_CONTATO"];
    nome = map["NM_CONTATO"];
    email = map["DS_EMAIL"];
    avatar = map["IMG_AVATAR"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> contatoMap = new Map<String, dynamic>();

    if (id != null) contatoMap["CD_CONTATO"] = id;
    contatoMap["NM_CONTATO"] = nome;
    contatoMap["DS_EMAIL"] = email;
    contatoMap["IMG_AVATAR"] = avatar;

    return contatoMap;
  }
}
