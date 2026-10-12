import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_users.dart';
import 'package:flutter_crud/models/user.dart';

class Users with ChangeNotifier{

  final Map<String, User> _itens = {...DUMMY_USERS};

  //Por que é feito um clone dessa lista? Porque eu não quis retornar uma referência para esse MAP itens?
  // Porque se eu retorno uma referência para o itens,
  // qualquer outra parte da aplicação pode ter acesso e alterar ele sem que eu seja notificado por isso fiz o clone dele.

  List<User> get all{
    //Eu sempre vou retornar o clone, pois sempre que eu mexer nele, a classe real precisa participar.
    return [..._itens.values];
  }

  int get count{
    return _itens.length;
  }

  User byIndex(int i){
    return _itens.values.elementAt(i);
  }

  void put(User user){
    if(user == null){
      return;
    }

    //insere caso não esteja atendendo aos requisitos (ADICIONAR).
    final id = Random().nextDouble().toString();
    _itens.putIfAbsent(id, () => User(
        id: id,
        nome: user.nome,
        email: user.email,
        avatarUrl: user.avatarUrl));

    //notifyListeners();
  }
}