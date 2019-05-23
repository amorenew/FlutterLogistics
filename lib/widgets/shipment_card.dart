import 'package:flutter/material.dart';
import 'package:logistics/models/shipment.dart';
import 'package:intl/intl.dart';

class ShipmentCard extends StatelessWidget {
  final Shipment shipment;
  ShipmentCard(this.shipment);

  MaterialColor _getStatusColor() {
    switch (this.shipment.status) {
      case 'out_for_delivery':
        return Colors.green;
        break;
      case 'in_facility':
        return Colors.purple;
        break;
      case 'delivered':
        return Colors.green;
        break;
      case 'on_hold':
        return Colors.orange;
        break;
      case 'canceled':
        return Colors.red;
        break;
      default:
        return Colors.black;
        break;
    }
  }

  String _getDeliveredDate() {
    final DateTime date = DateFormat("d-M-y").parse(shipment.createdAt);
    return DateFormat("MMMM dd,y").format(date);
  }

  Widget _buildInformation() {
    return Container(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              shipment.reference,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              shipment.status,
              style: TextStyle(fontSize: 14, color: _getStatusColor()),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'From: ${shipment.from}',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _getDeliveredDate(),
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  shipment.price,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
                width: 12.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: _getStatusColor(),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(3),
                      bottomLeft: Radius.circular(3)),
                )),
            Expanded(
              child: _buildInformation(),
            )
          ],
        ),
      ),
    );
  }
}
