// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste/models/user.dart';
import 'package:teste/provider/users.dart';
import 'package:teste/routes/app_routes.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? CircleAvatar(
            child: Icon(Icons.person),
          )
        : CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl),
          );
    return ListTile(
      leading: avatar,
      title: Text(user.nome),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.orange,
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FORMEDIT,
                arguments: user,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Excluir Usuário'),
                  content: Text('Tem certeza?'),
                  actions: <Widget>[
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text('Não'),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                    FlatButton(
                        textColor: Colors.blue,
                        child: Text('Sim'),
                        onPressed: () => Navigator.of(context).pop(true),                                                 
                        ),
                  ],
                ),
              ).then((confirmed){
                if(confirmed){
                  Provider.of<Users>(context, listen: false).remove(user);
                }
              });
            },
          ),
        ]),
      ),
    );
  }
}
