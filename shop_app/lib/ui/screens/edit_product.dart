import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/constants.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/mixins/loading.dart';
import 'package:shop_app/ui/widgets/add_edit_product.dart';
import 'package:shop_app/utils/extensions.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen>
    with StatefulLoadingWidget<EditProductScreen> {
  var _loaded = false;
  var _edited = Product.empty();
  var _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void init() {
    if (!_loaded) {
      final id = ModalRoute.of(context).settings.arguments as String;
      if (id == null) {
        setState(() {
          _loaded = true;
        });
      } else {
        final product = Provider.of<Products>(context, listen: false).find(id);
        setState(() {
          _loaded = true;
          _edited = product;
        });
      }
    }
  }

  void _saveForm(Product product) async {
    _form.currentState.save();
    var products = Provider.of<Products>(context, listen: false);
    var result = await withLoader<Product>(
        product.id == null ? products.add(product) : products.update(product));

    if (result.isNull) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("An error occured"),
          content: const Text("Sorry, Something went wrong!"),
          actions: [
            FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Okay")),
          ],
        ),
      );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      appBar: AppBar(
        title: APP_NAME,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Save",
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
        onPressed: () => _saveForm(_edited),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : AddOrEditProduct(
              product: _edited,
              form: _form,
            ),
    );
  }
}
