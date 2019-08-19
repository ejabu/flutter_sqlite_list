import 'package:flutter/material.dart';

int buildNumber = 0;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Map<String, dynamic>> products = [];

  @override
  Widget build(BuildContext context) {
    buildNumber += 1;
    print("Rebuild : $buildNumber times");
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.plus_one),
            onPressed: addProduct,
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: renderProducts(),
      ),
    );
  }

  void rebuildScreen() {
    setState(() {});
  }

  void addProduct() {
    products.add({"name": "Apple", "qty": 20});
    rebuildScreen();
  }

  void editProduct(int index, int newQty) {
    products[index]['qty'] = newQty;
    rebuildScreen();
  }

  void showEditDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextField(
            onSubmitted: (String value) {
              int newQty = int.parse(value);
              editProduct(index, newQty);
              Navigator.of(context).pop();
            },
            keyboardType: TextInputType.numberWithOptions(
              decimal: true,
              signed: false,
            ),
            autofocus: true,
          ),
        );
      },
    );
  }

  Widget renderProducts() {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            showEditDialog(index);
          },
          title: Text(products[index]['name']),
          trailing: Text('${products[index]['qty']}'),
        );
      },
    );
  }
}
