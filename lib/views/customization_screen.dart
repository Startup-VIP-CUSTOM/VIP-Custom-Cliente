import 'package:VipCustom/providers/order.dart';
import 'package:VipCustom/providers/orders.dart';
import 'package:VipCustom/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomizationScreen extends StatefulWidget {
  @override
  _CustomizationScreenState createState() => _CustomizationScreenState();
}

class _CustomizationScreenState extends State<CustomizationScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final _formOrders = Map<String, Object>();
  int selectedItem = 0;
  int selectedType = 0;

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formOrders.isEmpty) {
      final order = ModalRoute.of(context).settings.arguments as Order;

      if (order != null) {
        _formOrders['imageUrl'] = order.imageUrl;
        _formOrders['size'] = order.size;
        _formOrders['itemSelected'] = order.itemSelected;
        _formOrders['typeSelected'] = order.typeSelected;
        _formOrders['description'] = order.description;

        _imageUrlController.text = _formOrders['imageUrl'];
      }
    }
  }

  void _updateImage() {
    if (isValidImageUrl(_imageUrlController.text)) {
      setState(() {});
    }
  }

  bool isValidImageUrl(String url) {
    bool startWithHttp = url.toLowerCase().startsWith('http://');
    bool startWithHttps = url.toLowerCase().startsWith('https://');
    bool endsWithPng = url.toLowerCase().endsWith('.png');
    bool endsWithJpg = url.toLowerCase().endsWith('.jpg');
    bool endsWithJpeg = url.toLowerCase().endsWith('.jpeg');
    return (startWithHttp || startWithHttps) &&
        (endsWithPng || endsWithJpg || endsWithJpeg);
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImage);
    _imageUrlFocusNode.dispose();
  }

  void chanceSelectorItem(int select) {
    if (select == 1) {
      selectedItem = 1;
      _formOrders['itemSelected'] = 'camiseta';
    } else if (select == 2) {
      selectedItem = 2;
      _formOrders['itemSelected'] = 'chinelo';
    } else if (select == 3) {
      selectedItem = 3;
      _formOrders['itemSelected'] = 'mascara';
    }
    setState(() {});
  }

  void chanceSelectorType(int select) {
    if (select == 1) {
      selectedType = 1;
      _formOrders['typeSelected'] = 'centro';
    } else if (select == 2) {
      selectedType = 2;
      _formOrders['typeSelected'] = 'esquerda';
    } else if (select == 3) {
      selectedType = 3;
      _formOrders['typeSelected'] = 'direita';
    }
    setState(() {});
  }

  Future<void> _saveForm() async {
    bool isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }

    _form.currentState.save();

    final order = Order(
      id: _formOrders['id'],
      imageUrl: _formOrders['imageUrl'],
      size: _formOrders['size'],
      itemSelected: _formOrders['itemSelected'],
      typeSelected: _formOrders['typeSelected'],
      description: _formOrders['description'],
    );

    setState(() {});

    final orders = Provider.of<Orders>(context, listen: false);

    print(_formOrders['id']);
    print(_formOrders['imageUrl']);
    print(_formOrders['size']);
    print(_formOrders['itemSelected']);
    print(_formOrders['typeSelected']);
    print(_formOrders['description']);

    //try {
    await orders.addOrder(order);
    Navigator.of(context).pushNamed(AppRoutes.CONFIRMATION_SCREEN);
    /*} catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro ao salvar o produto!'),
          actions: <Widget>[
            FlatButton(
              child: Text('Fechar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }*/
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Customização'),
        backgroundColor: Colors.lightBlue[100],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue[50],
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _form,
            child: ListView(
              children: [
                Text(
                  'Escolha uma opção de produto:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Column(
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.all(deviceSize.width * 0.05),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: selectedItem == 1
                              ? Colors.cyanAccent
                              : Theme.of(context).accentColor,
                          child: Image.asset(
                            'assets/images/camiseta.png',
                            height: deviceSize.width * 0.1,
                          ),
                          onPressed: () => chanceSelectorItem(1),
                        ),
                        SizedBox(height: 10),
                        Text('Camiseta'),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.all(deviceSize.width * 0.05),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: selectedItem == 2
                              ? Colors.cyanAccent
                              : Theme.of(context).accentColor,
                          child: Image.asset(
                            'assets/images/chinelo.png',
                            height: deviceSize.width * 0.1,
                          ),
                          onPressed: () => chanceSelectorItem(2),
                        ),
                        SizedBox(height: 10),
                        Text('Chinelo'),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.all(deviceSize.width * 0.05),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: selectedItem == 3
                              ? Colors.cyanAccent
                              : Theme.of(context).accentColor,
                          child: Image.asset(
                            'assets/images/mascara.png',
                            height: deviceSize.width * 0.1,
                          ),
                          onPressed: () => chanceSelectorItem(3),
                        ),
                        SizedBox(height: 10),
                        Text('Máscara'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Escreva o tamanho do seu produto:'),
                  onSaved: (value) => _formOrders['size'] = value,
                  validator: (value) => null,
                ),
                SizedBox(height: 25),
                Text(
                  'Escolha o tipo de personalização:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 25),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.all(30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: selectedType == 1
                              ? Colors.cyanAccent
                              : Theme.of(context).accentColor,
                          child: Text('Centro'),
                          onPressed: () => chanceSelectorType(1),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.all(30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: selectedType == 2
                              ? Colors.cyanAccent
                              : Theme.of(context).accentColor,
                          child: Text('Lado esquerdo'),
                          onPressed: () => chanceSelectorType(2),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.all(30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: selectedType == 3
                              ? Colors.cyanAccent
                              : Theme.of(context).accentColor,
                          child: Text('Lado direito'),
                          onPressed: () => chanceSelectorType(3),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'URL da imagem para personalização'),
                        keyboardType: TextInputType.url,
                        controller: _imageUrlController,
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onSaved: (value) => _formOrders['imageUrl'] = value,
                        validator: (value) {
                          bool isEmpty = value.trim().isEmpty;
                          bool isInvalid = !isValidImageUrl(value);

                          if (isEmpty || isInvalid) {
                            return 'Informe uma URL válida!';
                          }

                          return null;
                        },
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(
                        top: 8,
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: _imageUrlController.text.isEmpty
                          ? Text('Informe a URL')
                          : Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Descrição do seu produto'),
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  onSaved: (value) => _formOrders['description'] = value,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RaisedButton(
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Theme.of(context).accentColor,
                        child: Text('Continuar'),
                        onPressed: () {
                          _saveForm();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
