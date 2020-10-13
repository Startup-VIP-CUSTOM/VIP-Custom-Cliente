import 'dart:convert';

import 'package:VipCustom/exceptions/http_exeption.dart';
import 'package:VipCustom/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Client with ChangeNotifier {
  final String id;
  final String name;
  final String fone;
  final String estado;
  final String cidade;
  final String cep;
  final String bairro;
  final String rua;
  final String numero;

  Client({
    this.id,
    @required this.name,
    @required this.fone,
    @required this.estado,
    @required this.cidade,
    @required this.cep,
    @required this.bairro,
    @required this.rua,
    @required this.numero,
  });
}

class Clients with ChangeNotifier {
  final String _baseUrl = '${Constants.BASE_API_URL}/clients';
  List<Client> _items = [];
  String _token;
  String _userId;

  Clients([this._token, this._userId, this._items = const []]);

  List<Client> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> addClient(Client newClient) async {
    final response = await http.post(
      "$_baseUrl.json?auth=$_token",
      body: json.encode({
        'id': newClient.id,
        'name': newClient.name,
        'fone': newClient.fone,
        'estado': newClient.estado,
        'cidade': newClient.cidade,
        'cep': newClient.cep,
        'bairro': newClient.bairro,
        'rua': newClient.rua,
        'numero': newClient.numero,
      }),
    );

    print(json.decode(response.body)['name']);

    _items.add(Client(
      id: json.decode(response.body)['name'],
      name: newClient.name,
      fone: newClient.fone,
      estado: newClient.estado,
      cidade: newClient.cidade,
      cep: newClient.cep,
      bairro: newClient.bairro,
      rua: newClient.rua,
      numero: newClient.numero,
    ));
    notifyListeners();
  }

  Future<void> loadClients() async {
    final response = await http.get('$_baseUrl/$_userId.json?auth=$_token');
    Map<String, dynamic> data = json.decode(response.body);

    _items.clear();
    if (data != null) {
      data.forEach((clientId, clientData) {
        _items.add(Client(
          id: clientId,
          name: clientData['name'],
          fone: clientData['fone'],
          estado: clientData['estado'],
          cidade: clientData['cidade'],
          cep: clientData['cep'],
          bairro: clientData['bairro'],
          rua: clientData['rua'],
          numero: clientData['numero'],
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> updateClient(Client client) async {
    if (client == null || client.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == client.id);
    if (index >= 0) {
      await http.patch(
        "$_baseUrl/$_userId.json?auth=$_token",
        body: json.encode({
          'estado': client.estado,
          'cidade': client.cidade,
          'cep': client.cep,
          'bairro': client.bairro,
          'rua': client.rua,
          'numero': client.numero,
        }),
      );
      _items[index] = client;
      notifyListeners();
    }
  }

  Future<void> deleteclient(String id) async {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      final order = _items[index];
      _items.remove(order);
      notifyListeners();

      final response =
          await http.delete("$_baseUrl/$_userId.json?auth=$_token");

      if (response.statusCode >= 400) {
        _items.insert(index, order);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do produto.');
      }
    }
  }
}
