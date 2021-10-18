// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResultData _$SearchResultDataFromJson(Map<String, dynamic> json) =>
    SearchResultData(
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SearchResultDataToJson(SearchResultData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      posts: (json['posts'] as List<dynamic>?)
          ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'posts': instance.posts,
      'events': instance.events,
    };

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      title: json['title'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
    };

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      photo: json['photo'] as String?,
      dcrate: json['dcrate'] as String?,
      brand: json['brand'] as Map<String, dynamic>?,
      title: json['title'] as String?,
      dcprice: json['dcprice'] as String?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'photo': instance.photo,
      'dcrate': instance.dcrate,
      'brand': instance.brand,
      'title': instance.title,
      'dcprice': instance.dcprice,
    };

RelatedSearchDatas _$RelatedSearchDatasFromJson(Map<String, dynamic> json) =>
    RelatedSearchDatas(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$RelatedSearchDatasToJson(RelatedSearchDatas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://billyapi.com/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<RelatedSearchDatas>> getRelatedSearchDatas(
      {required searchText}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<RelatedSearchDatas>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/tag/search?q=$searchText&per_page=8',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) =>
            RelatedSearchDatas.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<SearchResultData> getSearchResultData({required searchText}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchResultData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '/tag/data?search=$searchText&per_page=6',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchResultData.fromJson(_result.data!);
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
