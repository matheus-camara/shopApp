import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const UserProductItem({Key key, this.title, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              color: Theme.of(context).primaryColor,
              icon: const Icon(Icons.edit),
              onPressed: () => null,
            ),
            IconButton(
              color: Theme.of(context).errorColor,
              icon: const Icon(Icons.delete),
              onPressed: () => null,
            )
          ],
        ),
      ),
    );
  }
}
