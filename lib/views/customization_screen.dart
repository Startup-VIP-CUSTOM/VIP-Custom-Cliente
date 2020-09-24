import 'package:VipCustom/providers/prices.dart';
import 'package:VipCustom/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:VipCustom/providers/order.dart';
import 'package:VipCustom/providers/orders.dart';

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
  int selectedStore = 0;

  String dropdownValue = 'One';

  String priced = '0.00';

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImage);
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
      _formOrders['size'] = '12';
    } else if (select == 2) {
      selectedItem = 2;
      _formOrders['itemSelected'] = 'chinelo';
      _formOrders['size'] = '29-30';
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

  void chanceSelectorStore(int select) {
    if (select == 1) {
      selectedStore = 1;
      _formOrders['store'] = 'Rainer';
      _formOrders['price'] =
          Prices().store1Tax(_formOrders['itemSelected']).toStringAsFixed(2);
      priced = _formOrders['price'];
    } else if (select == 2) {
      selectedStore = 2;
      _formOrders['store'] = 'João';
      _formOrders['price'] =
          Prices().store2Tax(_formOrders['itemSelected']).toStringAsFixed(2);
      priced = _formOrders['price'];
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
      //id: _formOrders['id'],
      imageUrl: _formOrders['imageUrl'],
      size: _formOrders['size'],
      itemSelected: _formOrders['itemSelected'],
      typeSelected: _formOrders['typeSelected'],
      description: _formOrders['description'],
      price: _formOrders['price'],
      store: _formOrders['store'],
    );

    final orders = Provider.of<Orders>(context, listen: false);

    print('id: ${_formOrders['id']}');
    print('url: ${_formOrders['imageUrl']}');
    print('tamanho: ${_formOrders['size']}');
    print('item selecionado: ${_formOrders['itemSelected']}');
    print('tipo do item: ${_formOrders['typeSelected']}');
    print('descrição ${_formOrders['description']}');
    print('preço: ${_formOrders['price']}');
    print('loja: ${_formOrders['store']}');

    try {
      orders.addOrder(order);
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Produto cadastrado com sucessor!'),
          content:
              Text('Parabéns, sua personalização foi encaminhada ao vendedor!'),
          actions: <Widget>[
            FlatButton(
              child: Text('Fechar'),
              onPressed: () => Navigator.of(context).pushNamed(AppRoutes.HOME),
            ),
          ],
        ),
      );
    } catch (error) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Customização'),
        backgroundColor: Colors.lightBlue[100],
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
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
                              ? Colors.cyanAccent[100]
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
                              ? Colors.cyanAccent[100]
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
                              ? Colors.cyanAccent[100]
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
                _formOrders['itemSelected'] == 'camiseta'
                    ? DropdownButton<String>(
                        value: _formOrders['size'],
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            _formOrders['size'] = newValue;
                          });
                        },
                        items: <String>['12', '14', '16', 'P', 'M', 'G', 'GG']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    : _formOrders['itemSelected'] == 'chinelo'
                        // ? Column(
                        //     children: [
                        //       ListTile(
                        //         title: const Text('32'),
                        //         leading: Radio(
                        //           value: '32',
                        //           groupValue: _formOrders['size'],
                        //           onChanged: (value) {
                        //             setState(() {
                        //               _formOrders['size'] = value;
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //       ListTile(
                        //         title: const Text('35'),
                        //         leading: Radio(
                        //           value: '35',
                        //           groupValue: _formOrders['size'],
                        //           onChanged: (value) {
                        //             setState(() {
                        //               _formOrders['size'] = value;
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //       ListTile(
                        //         title: const Text('40'),
                        //         leading: Radio(
                        //           value: '40',
                        //           groupValue: _formOrders['size'],
                        //           onChanged: (value) {
                        //             setState(() {
                        //               _formOrders['size'] = value;
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //       ListTile(
                        //         title: const Text('42'),
                        //         leading: Radio(
                        //           value: '42',
                        //           groupValue: _formOrders['size'],
                        //           onChanged: (value) {
                        //             setState(() {
                        //               _formOrders['size'] = value;
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //     ],
                        //   )
                        ? DropdownButton<String>(
                            value: _formOrders['size'],
                            elevation: 16,
                            style: TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                _formOrders['size'] = newValue;
                              });
                            },
                            items: <String>[
                              '29-30',
                              '31-32',
                              '33-34',
                              '35-36',
                              '37-38',
                              '39-40',
                              '41-42',
                              '43-44'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )
                        : TextFormField(
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
                              ? Colors.cyanAccent[100]
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
                              ? Colors.cyanAccent[100]
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
                              ? Colors.cyanAccent[100]
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
                SizedBox(height: 25),
                Text(
                  'Escolha um vendedor:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.all(deviceSize.width * 0.05),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: selectedStore == 1
                              ? Colors.cyanAccent[100]
                              : Theme.of(context).accentColor,
                          child: Text('Loja 1'),
                          onPressed: () => _formOrders['itemSelected'] != null
                              ? chanceSelectorStore(1)
                              : showDialog<Null>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text('Selecione uma produto!'),
                                    content: Text(
                                        'Você só pode escolher o vendedor após escolher o produto!'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('Fechar'),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                    SizedBox(width: deviceSize.width * 0.3),
                    Column(
                      children: [
                        RaisedButton(
                          padding: EdgeInsets.all(deviceSize.width * 0.05),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: selectedStore == 2
                              ? Colors.cyanAccent[100]
                              : Theme.of(context).accentColor,
                          child: Text('Loja dois'),
                          onPressed: () => _formOrders['itemSelected'] != null
                              ? chanceSelectorStore(2)
                              : showDialog<Null>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text('Selecione uma produto!'),
                                    content: Text(
                                        'Você só pode escolher o vendedor após escolher o produto!'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('Fechar'),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Card(
                  color: Colors.blue[100],
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Preço: R\$$priced',
                            style: TextStyle(fontSize: 19),
                          ),
                        ),
                        //SizedBox(height: 25),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 100,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                color: Colors.lightGreenAccent[100],
                                child: Text('Finalizar'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
