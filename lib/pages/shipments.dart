import 'package:flutter/material.dart';
import 'package:logistics/models/shipment.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/shipments_model.dart';
// import 'package:rxdart/subjects.dart';
import '../widgets/shipment_card.dart';

class ShipmentsPage extends StatefulWidget {
  final ShipmentsModel model;
  final bool onHold;
  ShipmentsPage({@required this.onHold, @required this.model});

  @override
  State<StatefulWidget> createState() {
    return _ShipmentsPageState();
  }
}

class _ShipmentsPageState extends State<ShipmentsPage> {
  Widget appBarTitle = new Text(
    "Search by reference",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<Shipment> _shipmentsList;
  bool _isSearching;
  String _searchText = "";

  _ShipmentsPageState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    widget.model.fetchShipments().then((bool success) => _shipmentsList =
        widget.onHold
            ? widget.model.allOnHoldShipments
            : widget.model.allShipments);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      appBar: buildBar(context),
      body: _buildPageContent(),
    );
  }

  Widget _buildPageContent() {
    return ScopedModelDescendant<ShipmentsModel>(
        builder: (context, child, model) {
      if (_shipmentsList == null || _shipmentsList.isEmpty) {
        if (model.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text('No shipments there.'));
        }
      }
      return new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: _isSearching ? _buildSearchList() : _buildList(),
      );
    });
  }

  List<ShipmentCard> _buildList() {
    return _shipmentsList
        .map((shipment) => new ShipmentCard(shipment))
        .toList();
  }

  List<ShipmentCard> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _shipmentsList
          .map((shipment) => new ShipmentCard(shipment))
          .toList();
    } else {
      List<Shipment> _searchList = List();
      for (int i = 0; i < _shipmentsList.length; i++) {
        Shipment shipment = _shipmentsList.elementAt(i);
        if (shipment.reference
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          _searchList.add(shipment);
        }
      }
      return _searchList.map((shipment) => new ShipmentCard(shipment)).toList();
    }
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(
        centerTitle: true,
        title: appBarTitle,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.appBarTitle = new TextField(
                    controller: _searchQuery,
                    style: new TextStyle(
                      color: Colors.white,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Filter by reference",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _searchQuery.clear();
    });
  }
}

// class ShipmentCard extends StatelessWidget {
//   final Shipment shipment;
//   ShipmentCard(this.shipment);
//   @override
//   Widget build(BuildContext context) {
//     return new ListTile(title: new Text(this.shipment.reference));
//   }
// }
