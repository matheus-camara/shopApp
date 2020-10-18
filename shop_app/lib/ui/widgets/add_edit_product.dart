import 'package:flutter/material.dart';
import 'package:shop_app/mixins/loading.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/utils/extensions.dart';

class AddOrEditProduct extends StatefulWidget {
  final Product product;
  final GlobalKey<FormState> form;

  const AddOrEditProduct({Key key, @required this.product, @required this.form})
      : super(key: key);

  @override
  _AddOrEditProductState createState() =>
      _AddOrEditProductState(product: product);
}

class _AddOrEditProductState extends State<AddOrEditProduct>
    with StatefulLoadingWidget<AddOrEditProduct> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final TextEditingController _imageUrlController;

  Product product;

  _AddOrEditProductState({@required this.product})
      : this._imageUrlController =
            new TextEditingController(text: product.imageUrl);

  String validateInput(String value) => value.isNullOrEmpty ? "Required" : null;

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _imageUrlController.addListener(_updateImageUrl);
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: widget.form,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next,
                validator: validateInput,
                initialValue: product.title,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceFocusNode),
                onSaved: (value) =>
                    product = Product.copyWith(product, title: value),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Price"),
                validator: validateInput,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                initialValue:
                    product.price == 0 ? "" : product.price.toString(),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
                onSaved: (value) => product =
                    Product.copyWith(product, price: value.toDouble()),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Description"),
                validator: validateInput,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                initialValue: product.description,
                focusNode: _descriptionFocusNode,
                onSaved: (value) =>
                    product = Product.copyWith(product, description: value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Image Url"),
                validator: validateInput,
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                controller: _imageUrlController,
                focusNode: _imageUrlFocusNode,
                onSaved: (value) =>
                    product = Product.copyWith(product, imageUrl: value),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 20,
                height: (MediaQuery.of(context).size.height / 2) - 20,
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey)),
                child: _imageUrlController.text.isEmpty
                    ? Center(child: Text("Enter a URL"))
                    : FittedBox(
                        child: Image.network(_imageUrlController.text),
                        fit: BoxFit.cover,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
