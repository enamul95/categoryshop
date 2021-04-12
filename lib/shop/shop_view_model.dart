import 'package:categoryshop/repostory/rest_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import './shop.dart';
import 'state/tabbar_change.dart';

abstract class ShopViewModel extends State<Shop> {
  ScrollController scrollController = ScrollController();
  int currentCategoryIndex = 0;
  ScrollController headerScrollController = ScrollController();

  List<ProductMoel> itemList = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => getResutrantList(context));
    /*shopList = List.generate(
      10,
      (index) => ShopModel(
        categoryName: "Hello",
        products: List.generate(
          6,
          (index) => Product("Product $index", index * 100),
        ),
      ),
    );

*/
    scrollController.addListener(() {
      final index = itemList
          .indexWhere((element) => element.position >= scrollController.offset);

      tabBarNotifier.changeIndex(index);

      headerScrollController.animateTo(
          index * (MediaQuery.of(context).size.width * 0.2),
          duration: Duration(seconds: 1),
          curve: Curves.decelerate);
    });
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

  void headerListChangePosition(int index) {
    scrollController.animateTo(itemList[index].position,
        duration: Duration(seconds: 1), curve: Curves.ease);
  }

  double oneItemHeight = 0;

  void fillListPositionValues(double val) {
    if (oneItemHeight == 0) {
      oneItemHeight = val;
      itemList.asMap().forEach((key, value) {
        if (key == 0) {
          itemList[key].position = 0;
        } else {
          itemList[key].position = getShopListPosition(val, key);
        }
      });
    }
  }

  double getShopListPosition(double val, int index) =>
      val * (itemList[index].products.length) + itemList[index - 1].position;
}
