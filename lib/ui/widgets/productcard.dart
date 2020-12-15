import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latihan2/models/models.dart';
import 'package:latihan2/ui/pages/pages.dart';

class Productcard extends StatelessWidget {
  final Products product;
  Productcard({this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: ListTile(
          contentPadding: EdgeInsets.all(8),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Detailpage(product: product);
                  },
                  settings: RouteSettings(arguments: product),
                ));
          },
          title: Text(product.name, style: TextStyle(fontSize: 20)),
          subtitle: Text(NumberFormat.currency(
                  locale: 'id', symbol: 'Rp ', decimalDigits: 0)
              .format(double.tryParse(product.price))),
          leading: Container(
            width: 68,
            height: 68,
            child: CircleAvatar(
              backgroundColor: Colors.blue[100],
              backgroundImage: NetworkImage(product.image, scale: 40),
            ),
          ),
          //isThreeLine: true,
          trailing: Icon(Icons.remove_red_eye),
        ));
  }
}
