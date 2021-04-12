import 'package:categoryshop/repostory/rest_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItems2 extends StatefulWidget {
  @override
  _Items2 createState() => new _Items2();
}

class _Items2 extends State<ProductItems2> {
  List<ProductMoel> itemList = [];

  final items = List<ListItem>.generate(
    1200,
    (i) => i % 6 == 0
        ? HeadingItem("Heading $i")
        : MessageItem("Sender $i", "Message body $i"),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => getResutrantList(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Items...."),
      ),
      body: ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: itemList.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          final item = itemList[index];

          return ListTile(
            title: Text(item.productCategoryName),
            
            subtitle: Text(itemList[index].products[index].productName),
            // title: item.buildTitle(context),
            // subtitle: item.buildSubtitle(context),
          );
        },
      ),
    );
  }

  void getResutrantList(BuildContext context) async {
    print(" One **********************");
    final client =
        RestClient(Dio(BaseOptions(contentType: "application/json")));

    client.getProductItemst("1014", "1010").then((it) {
      print(" get inside **********************");

      //print(it[0].products[0].productName);
      this.setState(() {
        itemList = it;
      });
    }).catchError((error, stackTrace) {
      // non-200 error goes here.
      print("inner  **********************: $error");
    });
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  @override
  Widget buildSubtitle(BuildContext context) {
    return Text('No slide availabe.');
  }
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  Widget buildTitle(BuildContext context) => Text(sender);

  Widget buildSubtitle(BuildContext context) => Text(body);
}
