import 'package:flutter/material.dart';
import 'package:logistics/pages/shipments.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/shipments_model.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: ScopedModelDescendant<ShipmentsModel>(
          builder: (context, child, model) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.png',
                    height: 150.0,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  MaterialButton(
                    minWidth: 180.0,
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('On Hold Shipments'),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute<bool>(
                        builder: (BuildContext context) => ShipmentsPage(
                              onHold: true,
                              model: model,
                            ),
                      ));
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  MaterialButton(
                    minWidth: 180.0,
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text('All Shipments'),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute<bool>(
                        builder: (BuildContext context) => ShipmentsPage(
                              onHold: false,
                              model: model,
                            ),
                      ));
                    },
                  )
                ],
              ),
        ),
      ),
    );
  }
}
