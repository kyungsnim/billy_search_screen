import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://billyapi.com/api/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/tag/search?q={searchText}&per_page=8')
  Future<List<RelatedSearchDatas>>? getRelatedSearchDatas(
      {@Path() required String searchText});

  @GET('/tag/data?search={searchText}&per_page=6')
  Future<SearchResultData> getSearchResultData(
      {@Path() required String searchText});
}

@JsonSerializable()
class SearchResultData {
  Map<String, dynamic>? data;

  SearchResultData({
    this.data,
  });

  factory SearchResultData.fromJson(Map<String, dynamic> json) =>
      _$SearchResultDataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultDataToJson(this);
}

@JsonSerializable()
class Data {
  List<Post>? posts;
  List<Event>? events;

  Data({
    this.posts,
    this.events,
  });

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Post {
  String? title;
  String? link;

  Post({this.title, this.link});

  factory Post.fromJson(Map<String, dynamic> json) =>
      _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable()
class Event {
  String? photo;
  String? dcrate;
  Map<String, dynamic>? brand;
  String? title;
  String? dcprice;

  Event({this.photo, this.dcrate, this.brand, this.title, this.dcprice});

  factory Event.fromJson(Map<String, dynamic> json) =>
      _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}

@JsonSerializable()
class RelatedSearchDatas {
  int? id;
  String? name;

  RelatedSearchDatas({
    this.id,
    this.name,
  });

  factory RelatedSearchDatas.fromJson(Map<String, dynamic> json) =>
      _$RelatedSearchDatasFromJson(json);

  Map<String, dynamic> toJson() => _$RelatedSearchDatasToJson(this);
}
