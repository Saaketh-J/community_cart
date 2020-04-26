import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroceryList extends StatelessWidget {

  List<String> list = ["Chicken", "Bell pepper", "Tofu"];
  List<Widget> shoppingList;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    shoppingList = List.generate((list.length), (index) {
      return ListItems(list[index]);
    });
    return Scaffold(
        backgroundColor: Color.fromRGBO(3, 168, 147, 1.0),
        appBar: AppBar(
          title: Text("Shopping List"),
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        ),
        body: ListView.builder(
        itemCount: shoppingList.length,
        itemBuilder: (context, index){
          return Container(
            child: shoppingList[index],
          );
        }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    );
  }
}

class ListItems extends StatelessWidget {
  var iconStyle = Icons.check_circle_outline;
  var item;

  ListItems(this.item);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.only(bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: FlatButton(
            child: Row(
              children: <Widget>[
                Icon(iconStyle),
                Container(padding: EdgeInsets.only(left: 5.0)),
                Text(item),
              ],
            ),
            onPressed: () {
              iconStyle = iconStyle == Icons.check_circle_outline
                  ? Icons.check_circle
                  : Icons.check_circle_outline;
              return FlatButton(
                  child: Row(children: <Widget>[
                Icon(iconStyle),
                Container(padding: EdgeInsets.only(left: 5.0)),
                Text(item),
              ]));
            }));
  }
}
