import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_tile.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    //Aqui instanciei a classe.
    final users = Provider.of<Users>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de usuários.'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              //Fiz um teste aqui usando a função abaixo para ver se estava excluindo corretamente...
              //users.remove(users.byIndex(0));
              //Testei o incluir e o atualizar e funcionou, pois se não consta na lista ele add, else, ele atualiza.
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        //A vantagem de usar esse atributo é que ele só cria o que está na tela, quando vai rolando ele vai gerando o resto.
        itemCount: users.count,
        //No corpo da tela, fiz o projeto trazer a lista de nomes.
        itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
      ),
    );
  }
}
