import 'package:VipCustom/providers/client.dart';
import 'package:VipCustom/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComplementationScreen extends StatefulWidget {
  @override
  _ComplementationScreenState createState() => _ComplementationScreenState();
}

class _ComplementationScreenState extends State<ComplementationScreen> {
  final _form = GlobalKey<FormState>();
  final _formClients = Map<String, Object>();
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formClients.isEmpty) {
      final client = ModalRoute.of(context).settings.arguments as Client;

      if (client != null) {
        _formClients['id'] = client.id;
        _formClients['name'] = client.name;
        _formClients['fone'] = client.fone;
        _formClients['estado'] = client.estado;
        _formClients['cidade'] = client.cidade;
        _formClients['cep'] = client.cep;
        _formClients['bairro'] = client.bairro;
        _formClients['rua'] = client.rua;
        _formClients['numero'] = client.numero;
      }
    }
  }

  Future<void> _saveForm() async {
    bool isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }

    _form.currentState.save();

    final order = Client(
      id: _formClients['id'],
      name: _formClients['name'],
      fone: _formClients['fone'],
      estado: _formClients['estado'],
      cidade: _formClients['cidade'],
      cep: _formClients['cep'],
      bairro: _formClients['bairro'],
      rua: _formClients['rua'],
      numero: _formClients['numero'],
    );

    setState(() {
      _isLoading = true;
    });

    final orders = Provider.of<Clients>(context, listen: false);

    try {
      orders.addClient(order);
      print('id: ${_formClients['id']}');
      print('nome: ${_formClients['name']}');
      print('telefone: ${_formClients['fone']}');
      print('estado: ${_formClients['estado']}');
      print('cidade: ${_formClients['cidade']}');
      print('cep: ${_formClients['cep']}');
      print('bairro: ${_formClients['bairro']}');
      print('rua: ${_formClients['rua']}');
      print('número: ${_formClients['numero']}');
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Informações alteradas com sucessor!'),
          content: Text(
              'Suas informações foram alteradas e cadastradas com sucesso!'),
          actions: <Widget>[
            FlatButton(
              child: Text('Fechar'),
              onPressed: () => Navigator.of(context).pop(),
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
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Suas Informações'),
        backgroundColor: Colors.lightBlue[100],
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
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
                        'Preencha os campos abaixo com as suas informações:',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        initialValue: _formClients['name'],
                        decoration: InputDecoration(labelText: 'Seu nome'),
                        keyboardType: TextInputType.name,
                        onSaved: (value) => _formClients['name'] = value,
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        initialValue: _formClients['fone'],
                        decoration: InputDecoration(labelText: 'Seu telefone'),
                        keyboardType: TextInputType.phone,
                        onSaved: (value) => _formClients['fone'] = value,
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        initialValue: _formClients['estado'],
                        decoration: InputDecoration(labelText: 'Seu Estado'),
                        onSaved: (value) => _formClients['estado'] = value,
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        initialValue: _formClients['cidade'],
                        decoration: InputDecoration(labelText: 'Sua cidade'),
                        onSaved: (value) => _formClients['cidade'] = value,
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        initialValue: _formClients['cep'],
                        decoration: InputDecoration(labelText: 'Seu CEP'),
                        keyboardType: TextInputType.number,
                        onSaved: (value) => _formClients['cep'] = value,
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        initialValue: _formClients['bairro'],
                        decoration: InputDecoration(labelText: 'Seu bairro'),
                        onSaved: (value) => _formClients['bairro'] = value,
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        initialValue: _formClients['rua'],
                        decoration: InputDecoration(labelText: 'Sua rua'),
                        onSaved: (value) => _formClients['rua'] = value,
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        initialValue: _formClients['numero'],
                        decoration: InputDecoration(labelText: 'Seu número'),
                        keyboardType: TextInputType.number,
                        onSaved: (value) => _formClients['numero'] = value,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
