import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste/models/user.dart';
import 'package:teste/provider/users.dart';
import 'package:teste/routes/app_routes.dart';

class UserForm extends StatelessWidget {

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};


  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Usuário'),
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
                decoration: InputDecoration(labelText: 'E-Mail'),
                onSaved: (value) => _formData['email'] = value!,
              ),
              TextFormField(
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