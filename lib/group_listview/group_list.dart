import 'package:categoryshop/repostory/rest_api.dart';
import 'package:categoryshop/util/app_color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';

class ProductItems extends StatefulWidget {
  @override
  _Items createState() => new _Items();
}

class _Items extends State<ProductItems> {
  List<ProductMoel> itemList = [];
  final items = List<ListItem>.generate(
    1200,
    (i) => i % 6 == 0
        ? HeadingItem("Heading $i")
        : MessageItem("Sender $i", "Message body $i"),
  );

  Map<String, List> _elements1 = {
    'Team A': ['Klay Lewis', 'Ehsan Woodard', 'River Bains'],
    'Team B': ['Toyah Downs', 'Tyla Kane'],
    'Team C': ['Marcus Romero', 'Farrah Parkes', 'Fay Lawson', 'Asif Mckay'],
    'Team D': [
      'Casey Zuniga',
      'Ayisha Burn',
      'Josie Hayden',
      'Kenan Walls',
      'Mario Powers'
    ],
    'Team Q': ['Toyah Downs', 'Tyla Kane', 'Toyah Downs'],
  };

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
        title: Text("Product Items"),
      ),
      body: GroupListView(
        //sectionsCount: _elements.keys.toList().length,
        sectionsCount: itemList.length,
        countOfItemInSection: (int section) {
          // itemList[index.section].products[index.index].productName
          return itemList[section].products.length;
          // return itemList.length;
        },
        itemBuilder: _itemBuilder,
        groupHeaderBuilder: (BuildContext context, int section) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Text(
              //  _elements.keys.toList()[section],
              itemList[section].productCategoryName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 10),
        sectionSeparatorBuilder: (context, section) => SizedBox(height: 10),
      ),

      /* ListView.builder(
        // Let the ListView know how many items it needs to build.
        itemCount: itemList.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
      
        itemBuilder: (context, index) {
          final item = itemList[index];

          return ListTile(
           // title: item.buildTitle(context),
            // title: item.buildTitle(context),
            // subtitle: item.buildSubtitle(context),
            title: Text(item.productCategoryName),
            subtitle: Text(item[i]),

            // children: item.products.map((subItem){
            //  }
            //subtitle: Text(item[index].productName),
          );
        },
      ),
      */
    );
  }

  Widget _itemBuilder(BuildContext context, IndexPath index) {
    //String user = _elements.values.toList()[index.section][index.index];
    // String user = itemList[index.section].productCategoryName;
    String user = itemList[index.section].products[index.index].productName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 8,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 10.0),
          leading: CircleAvatar(
            child: Text(
              _getInitials(user),
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            backgroundColor: _getAvatarColor(user),
          ),
          title: Text(
            // _elements.values.toList()[index.section][index.index],
            itemList[index.section].products[index.index].productName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }

  String _getInitials(String user) {
    var buffer = StringBuffer();
    var split = user.split(" ");
    for (var s in split) buffer.write(s[0]);

    return buffer.toString().substring(0, split.length);
  }

  Color _getAvatarColor(String user) {
    return AppColors
        .avatarColors[user.hashCode % AppColors.avatarColors.length];
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

  // Widget buildSubtitle(BuildContext context) => ;
}

/// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);

  Widget buildTitle(BuildContext context) => Text(sender);

  Widget buildSubtitle(BuildContext context) => Text(body);
}
