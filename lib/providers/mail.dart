import 'dart:convert';

import 'package:VipCustom/exceptions/http_exeption.dart';
import 'package:VipCustom/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Mail with ChangeNotifier {
  final String id;
  final String estado;
  final String cidade;
  final int cep;
  final String bairro;
  final String rua;
  final int numero;

  Mail({
    this.id,
    @required this.estado,
    @required this.cidade,
    @required this.cep,
    @required this.bairro,
    @required this.rua,
    @required this.numero,
  });
}

class Mails with ChangeNotifier {
  final String _baseUrl = '${Constants.BASE_API_URL}/clients';
  List<Mail> _items = [];
  String _token;
  String _userId;

  Mails([this._token, this._userId, this._items = const []]);

  List<Mail> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> addOrder(Mail newMail) async {
    final response = await http.post(
      "$_baseUrl/$_userId/mails.json?auth=$_token",
      body: json.encode({
        'id': newMail.id,
        'estado': newMail.estado,
        'cidade': newMail.cidade,
        'cep': newMail.cep,
        'bairro': newMail.bairro,
        'rua': newMail.rua,
        'numero': newMail.numero,
      }),
    );

    print(json.decode(response.body)['name']);

    _items.add(Mail(
      id: json.decode(response.body)['name'],
      estado: newMail.estado,
      cidade: newMail.cidade,
      cep: newMail.cep,
      bairro: newMail.bairro,
      rua: newMail.rua,
      numero: newMail.numero,
    ));
    notifyListeners();
  }

  Future<void> loadProducts() async {
    final response =
        await http.get('$_baseUrl/$_userId/mails.json?auth=$_token');
    Map<String, dynamic> data = json.decode(response.body);

    _items.clear();
    if (data != null) {
      data.forEach((mailId, mailData) {
        _items.add(Mail(
          id: mailId,
          estado: mailData['estado'],
          cidade: mailData['cidade'],
          cep: mailData['cep'],
          bairro: mailData['bairro'],
          rua: mailData['rua'],
          numero: mailData['numero'],
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> updateProduct(Mail mail) async {
    if (mail == null || mail.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == mail.id);
    if (index >= 0) {
      await http.patch(
        "$_baseUrl/$_userId/mail.json?auth=$_token",
        body: json.encode({
          'estado': mail.estado,
          'cidade': mail.cidade,
          'cep': mail.cep,
          'bairro': mail.bairro,
          'rua': mail.rua,
          'numero': mail.numero,
        }),
      );
      _items[index] = mail;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      final order = _items[index];
      _items.remove(order);
      notifyListeners();

      final response =
          await http.delete("$_baseUrl/$_userId/mails.json?auth=$_token");

      if (response.statusCode >= 400) {
        _items.insert(index, order);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do produto.');
      }
    }
  }
}
