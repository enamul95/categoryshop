import 'package:categoryshop/shop/model/shop_model.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_api.g.dart';

//192.168.0.104
////localhost
@RestApi(baseUrl: "http://localhost:8080/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @POST("app-api/resturant-items")
  Future<List<ProductMoel>> getProductItemst(
      @Field("restaurantId") String restaurantId,
      @Field("restaurantBranchId") String restaurantBranchId);
}

@JsonSerializable()
class ProductMoel {
  double position = 0;
  int id;
  String productCategoryId;
  String productCategoryName;
  List<Items> products;
  ProductMoel(
      this.id, this.productCategoryId, this.productCategoryName, this.products);

  factory ProductMoel.fromJson(Map<String, dynamic> json) =>
      _$ProductMoelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductMoelToJson(this);
}

@JsonSerializable()
class Items {
  String productId;
  String productName;
  String description;
  String fileId;

  @JsonKey(name: '_price')
  int price;

  Items(this.productId, this.productName, this.description, this.fileId,
      this.price);

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}
