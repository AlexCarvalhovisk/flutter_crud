import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_users.dart';
import 'package:flutter_crud/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _itens = {...DUMMY_USERS};

  // Retorna uma cópia da lista de usuários.
  List<User> get all {
    return [..._itens.values];
  }

  int get count {
    return _itens.length;
  }

  User byIndex(int i) {
    return _itens.values.elementAt(i);
  }

  void put(User user) {
    final id = user.id;

    if (id != null && id.trim().isNotEmpty && _itens.containsKey(id)) {
      // Atualiza um usuário existente.
      _itens.update(id, (_) => user);
    } else {
      // Cria um novo usuário com um ID gerado.
      final newId = Random().nextInt(1 << 32).toString();

      _itens[newId] = User(
        id: newId,
        nome: user.nome,
        email: user.email,
        avatarUrl: user.avatarUrl,
      );
    }

    notifyListeners();
  }

  // Remove um usuário pelo seu ID.
  void remove(User user) {
    final id = user.id;

    if (id != null && _itens.containsKey(id)) {
      _itens.remove(id);
      notifyListeners();
    }
  }
}
