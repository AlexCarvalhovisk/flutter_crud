import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(User user){
      _formData['nome'] = user.nome;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)?.settings.arguments as User?;

    if(user != null){
      _loadFormData(user);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de usuário.'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final isValid = _form.currentState?.validate() ?? true;
              //Salientando que só entrara aqui se tudo no formulário estiver válido.
              if (isValid) {
                _form.currentState?.save();
                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    nome: _formData['nome'] ?? '',
                    email: _formData['email'] ?? '',
                    avatarUrl: _formData['avatarUrl'] ?? '',
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          //Aqui tô acessando o formulário
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['nome'],
                decoration: InputDecoration(labelText: 'Nome: '),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome invalido.';
                  }
                  if (value.trim().length <= 2) {
                    return 'Nome muito pequeno. É necessário no minimo 3 letras.';
                  }
                  return null;
                },
                onSaved: (value) => _formData['nome'] = value ?? '',
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: 'E-mail: '),
                onSaved: (value) => _formData['email'] = value ?? '',
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: InputDecoration(labelText: 'Url do Avatar: '),
                onSaved: (value) => _formData['avatarUrl'] = value ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
