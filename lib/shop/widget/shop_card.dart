import 'package:categoryshop/shop/model/shop_helper.dart';
import 'package:flutter/material.dart';
import 'package:categoryshop/repostory/rest_api.dart';

class ShopCard extends StatelessWidget {
  //final ShopModel model;
  final ProductMoel model;
  final int index;
  final Function(double val) onHeight;

  const ShopCard(
      {Key? key,
      required this.model,
      required this.index,
      required this.onHeight})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      onHeight((context.size!.height) / (model.products.length));
    });
    return Column(
      children: [
        Divider(),
        Text("${model.productCategoryName}"),
        Card(
          child: _myListView(context, model.products),
        ),
      ],
    );
  }

  Widget _myListView(BuildContext context, List<Items> items) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            print("clicked card item");
            print("productName-->" + items[index].productName);
            print("productId-->" + items[index].productId);
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          items[index].productName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Text(items[index].description,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 16)),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(items[index].price.toString()),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            "http://localhost:8080/app-api/loadfile/" +
                                items[index].fileId,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  //Text(items[index].price.toString()),
                ],
              ),
            ),
            /* child: ListTile(
              title: Text(items[index].productName),
            ),
            */
          ),
        );
      },
    );
  }
}
