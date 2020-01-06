import 'package:flutter/material.dart';
import 'package:shop_app/domain/constants.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/utils/extensions.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _edited =
      Product(id: null, title: "", description: "", imageUrl: "", price: 0);

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  String validateInput(String value) => value.isNullOrEmpty ? "Required" : null;

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    _form.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: APP_NAME,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: "Title"),
                  textInputAction: TextInputAction.next,
                  validator: validateInput,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceFocusNode),
                  onSaved: (value) => _edited = Product(
                      title: value,
                      id: null,
                      description: _edited.description,
                      imageUrl: _edited.imageUrl,
                      price: _edited.price,
                      isFavorite: _edited.isFavorite),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Price"),
                  validator: validateInput,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) => FocusScope.of(context)
                      .requestFocus(_descriptionFocusNode),
                      onSaved: (value) => _edited = Product(
                      title: _edited.title,
                      id: null,
                      description: _edited.description,
                      imageUrl: _edited.imageUrl,
                      price: value.toDouble(),
                      isFavorite: _edited.isFavorite),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Description"),
                  validator: validateInput,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  onSaved: (value) => _edited = Product(
                      title: _edited.title,
                      id: null,
                      description: value,
                      imageUrl: _edited.imageUrl,
                      price: _edited.price,
                      isFavorite: _edited.isFavorite),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: _imageUrlController.text.isEmpty
                          ? Text("Enter a URL")
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Image Url"),
                        validator: validateInput,
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (_) => _saveForm(),
                        onSaved: (value) => _edited = Product(
                      title: _edited.title,
                      id: null,
                      description: _edited.description,
                      imageUrl: value,
                      price: _edited.price,
                      isFavorite: _edited.isFavorite),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
}
