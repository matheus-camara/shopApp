import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/ui/screens/edit_product.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem(
      {Key key,
      @required this.id,
      @required this.title,
      @required this.imageUrl})
      : super(key: key);

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
              onPressed: () => Navigator.of(context)
                  .pushNamed(EditProductScreen.routeName, arguments: id),
            ),
            IconButton(
                color: Theme.of(context).errorColor,
                icon: const Icon(Icons.delete),
                onPressed: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("This Operation cannot be undone!",
                            textAlign: TextAlign.center),
                        content: const Text(
                          "Are you sure?",
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          RaisedButton(
                              onPressed: () {
                                Provider.of<Products>(context, listen: false)
                                    .delete(id);
                                Navigator.of(context).pop();
                              },
                              child: Row(children: [
                                const Text("Yes"),
                                Icon(
                                  Icons.done,
                                  color: Colors.green,
                                )
                              ])),
                          RaisedButton(
                              onPressed: Navigator.of(context).pop,
                              child: Row(children: [
                                const Text("No"),
                                Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                )
                              ])),
                        ],
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
