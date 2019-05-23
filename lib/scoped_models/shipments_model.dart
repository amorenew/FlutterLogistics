import 'package:logistics/models/shipment.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ShipmentsModel extends Model {
  List<Shipment> _shipments = [];
  int _selectedShipmentIndex;
  bool _isLoading = false;
  String _token;

  List<Shipment> get allShipments {
    return List.from(this._shipments);
  }

  List<Shipment> get allOnHoldShipments {
    return this
        ._shipments
        .where((Shipment shipment) => shipment.status == 'hold')
        .toList();
  }

  void selectShipment(int shipmentIndex) {
    this._selectedShipmentIndex = shipmentIndex;
    if (shipmentIndex != null) {
      notifyListeners();
    }
  }

  Shipment get selectedShipment {
    if (this._selectedShipmentIndex == null) return null;
    return this._shipments[_selectedShipmentIndex];
  }

  void changeShipmentStatus(String status) {
    final Shipment shipment = selectedShipment;
    _shipments[_selectedShipmentIndex] = Shipment(
        reference: shipment.reference,
        from: shipment.from,
        status: status,
        createdAt: shipment.createdAt,
        deliverAt: shipment.deliverAt,
        location: shipment.location,
        price: shipment.price);
    notifyListeners();
  }

  Future<String> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> params = {
      'username': username,
      'password': password
    };
    await http.post('https://quiz.logistechs.co/api/login',
        body: json.encode(params),
        headers: {
          'Content-Type': 'application/json'
        }).then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      _token = responseData['token'];

      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
    });
    return _token;
  }

  Future<bool> fetchShipments() async {
    _isLoading = true;
    notifyListeners();
    if (_token == null || _token.isEmpty) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      _token = prefs.get('token');
    }
    bool success = false;
    await http.get('https://quiz.logistechs.co/api/list?token=${this._token}	',
        headers: {
          'Content-Type': 'application/json'
        }).then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final list = responseData['shipments'] as List;
      _shipments =
          list.map((shipmentData) => Shipment.fromJson(shipmentData)).toList();
      _isLoading = false;
      notifyListeners();
      success = true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      success = false;
    });
    return success;
  }

  bool get isLoading {
    return _isLoading;
  }
}
