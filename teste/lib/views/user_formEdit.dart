import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste/models/user.dart';
import 'package:teste/provider/users.dart';

class UserFormEdit extends StatelessWidget {

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(User user){
    if(user != null){
      _formData['id'] = user.id;
      _formData['nome'] = user.nome;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;

    }
  }

  @override
  Widget build(BuildContext context) {

    final User user = ModalRoute.of(context)?.settings.arguments as User;
    _loadFormData(user);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Usuário'),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              final isValid = _form.currentState?.validate();

              if(isValid == true){
                _form.currentState?.save();
                Provider.of<Users>(context, listen: false).put(User(
                  id: _formData['id'].toString(),
                  nome: _formData['nome'].toString(),
                  email: _formData['email'].toString(),
                  avatarUrl: _formData['avatarUrl'].toString(),
                ));
                Navigator.of(context).pop();
              }
            },
          icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['nome'],
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value){
                  if(value == null || value.trim().isEmpty){
                    return 'Insira um nome!';
                  }
                  if(value.trim().length < 3){
                    return 'O nome deve ter mais de 3 letras!';
                  }

                  return null;
                },
                onSaved: (value) => _formData['nome'] = value!,
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: 'E-Mail'),
                onSaved: (value) => _formData['email'] = value!,
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: InputDecoration(labelText: 'Url do Avatar'),
                onSaved: (value) => _formData['avatarUrl'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}