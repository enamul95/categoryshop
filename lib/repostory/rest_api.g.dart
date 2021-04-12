// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductMoel _$ProductMoelFromJson(Map<String, dynamic> json) {
  return ProductMoel(
    json['id'] as int,
    json['productCategoryId'] as String,
    json['productCategoryName'] as String,
    (json['products'] as List<dynamic>)
        .map((e) => Items.fromJson(e as Map<String, dynamic>))
        .toList(),
  )..position = (json['position'] as num).toDouble();
}

Map<String, dynamic> _$ProductMoelToJson(ProductMoel instance) =>
    <String, dynamic>{
      'position': instance.position,
      'id': instance.id,
      'productCategoryId': instance.productCategoryId,
      'productCategoryName': instance.productCategoryName,
      'products': instance.products,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) {
  return Items(
    json['productId'] as String,
    json['productName'] as String,
    json['description'] as String,
    json['fileId'] as String,
    json['_price'] as int,
  );
}

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'description': instance.description,
      'fileId': instance.fileId,
      '_price': instance.price,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://localhost:8080/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<ProductMoel>> getProductItemst(
      restaurantId, restaurantBranchId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'restaurantId': restaurantId,
      'restaurantBranchId': restaurantBranchId
    };
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<ProductMoel>>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'app-api/resturant-items',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => ProductMoel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
