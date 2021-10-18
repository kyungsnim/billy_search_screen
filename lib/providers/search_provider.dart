 import 'package:billy_search_screen/retrofit/rest_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {

  RestClient? client;

  final TextEditingController _searchTextController = TextEditingController();
  String _searchText = '';
  bool _searchComplete = false;

  SearchResultData? _searchResultData;
  List<RelatedSearchDatas>? _relatedSearchData;

  void setRelatedSearchData(setRelatedSearchData) {
    _relatedSearchData = setRelatedSearchData;
    notifyListeners();
  }

  void setSearchResultData(setSearchResultData) {
    _searchResultData = setSearchResultData;
    notifyListeners();
  }

  void setComplete() {
    _searchComplete = true;
    notifyListeners();
  }

  void updateSearchText() {
    _searchText = _searchTextController.text;
    notifyListeners();
  }

  Future<List<RelatedSearchDatas>?> getRelatedSearchDatas (String searchText) async {
    Dio dio = Dio();
    dio.options.headers['Content-type'] = 'application/json';
    dio.options.headers['authorization'] =
    'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZjYjAwNGE2OTEyNDUzN2U4MGYwZDllNzVhODFmYjI3ODVkZWUzYjljOTY5OGFiZjU4ZWM1YTVjYjI2ZWMyZWRjMTBmM2NlMjYxYTdjZjQwIn0.eyJhdWQiOiIzIiwianRpIjoiZmNiMDA0YTY5MTI0NTM3ZTgwZjBkOWU3NWE4MWZiMjc4NWRlZTNiOWM5Njk4YWJmNThlYzVhNWNiMjZlYzJlZGMxMGYzY2UyNjFhN2NmNDAiLCJpYXQiOjE2MzQxMzAyNjksIm5iZiI6MTYzNDEzMDI2OSwiZXhwIjoxNjY1NjY2MjY5LCJzdWIiOiIxMDg4MzIiLCJzY29wZXMiOltdfQ.ilrAkzRppNfe8s1nPUu4ONzLDkfZq_jJ47Uk3dArcVkMQ_7Hta2S_l28CFqvfMqh8pXl7Gfqhwnxv05_1_JpKOid8wQzdRcn6006tDUb8nd5PbBr2cUyjV1v-WS0KPtIj53YnBM_p0IYEEyxXcAUJnAzjeNCqW4RioFOvLzCqcCfYa2FYXHGRwXNw515rbuR3SUbM6oQM4TfZ-xSkE-tviycy0S2rrKmUQsjjq1OCuU5TGWR6rAzcsv90XVwbtJTTiHQpBvADmA_vPoALz0m0X-1SOrAcsc9FkmzzRb6tm1nzmQU99LkjZbtOMHhieONMEjONJj89NZHfGH1XIOiqROzjg4q1qVPYBu2BNAZVnq2GgVneFacgYarxSGWZKq0Y8UDrUgmfbEMLLKujJdqKb5Qkk_W2S_UHlxofh9QZP0mEjXKzT3rOtad0XcgsQV00d9v6ohnOQU0L2Guopj4mdMTRqE_pVu0EspUYzHgjHxPcsw3iQAjrYMTaueKUm9CBvED2ZMihYQjs0kiPEIbTr_Cgnb0EsuBH0kUW5QC5s2oV5erkWUFXC60CAjsz85yyvWWJ1Tri8IgqkpOHtem2l9deLnSNt7SwaF6sO_iWW7r1dbRaDAfpE06RpzKWq1GvlI1G5abbr1Xq0stYy991wCdMFc_-aT_7Sn4XiUePRo';

    RestClient client = RestClient(dio);
    _relatedSearchData = await client.getRelatedSearchDatas(searchText: searchText);
    notifyListeners();
    return _relatedSearchData;
  }

  Future<SearchResultData?> getSearchResultData (String searchText) async {
    Dio dio = Dio();
    dio.options.headers['Content-type'] = 'application/json';
    dio.options.headers['authorization'] =
    'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZjYjAwNGE2OTEyNDUzN2U4MGYwZDllNzVhODFmYjI3ODVkZWUzYjljOTY5OGFiZjU4ZWM1YTVjYjI2ZWMyZWRjMTBmM2NlMjYxYTdjZjQwIn0.eyJhdWQiOiIzIiwianRpIjoiZmNiMDA0YTY5MTI0NTM3ZTgwZjBkOWU3NWE4MWZiMjc4NWRlZTNiOWM5Njk4YWJmNThlYzVhNWNiMjZlYzJlZGMxMGYzY2UyNjFhN2NmNDAiLCJpYXQiOjE2MzQxMzAyNjksIm5iZiI6MTYzNDEzMDI2OSwiZXhwIjoxNjY1NjY2MjY5LCJzdWIiOiIxMDg4MzIiLCJzY29wZXMiOltdfQ.ilrAkzRppNfe8s1nPUu4ONzLDkfZq_jJ47Uk3dArcVkMQ_7Hta2S_l28CFqvfMqh8pXl7Gfqhwnxv05_1_JpKOid8wQzdRcn6006tDUb8nd5PbBr2cUyjV1v-WS0KPtIj53YnBM_p0IYEEyxXcAUJnAzjeNCqW4RioFOvLzCqcCfYa2FYXHGRwXNw515rbuR3SUbM6oQM4TfZ-xSkE-tviycy0S2rrKmUQsjjq1OCuU5TGWR6rAzcsv90XVwbtJTTiHQpBvADmA_vPoALz0m0X-1SOrAcsc9FkmzzRb6tm1nzmQU99LkjZbtOMHhieONMEjONJj89NZHfGH1XIOiqROzjg4q1qVPYBu2BNAZVnq2GgVneFacgYarxSGWZKq0Y8UDrUgmfbEMLLKujJdqKb5Qkk_W2S_UHlxofh9QZP0mEjXKzT3rOtad0XcgsQV00d9v6ohnOQU0L2Guopj4mdMTRqE_pVu0EspUYzHgjHxPcsw3iQAjrYMTaueKUm9CBvED2ZMihYQjs0kiPEIbTr_Cgnb0EsuBH0kUW5QC5s2oV5erkWUFXC60CAjsz85yyvWWJ1Tri8IgqkpOHtem2l9deLnSNt7SwaF6sO_iWW7r1dbRaDAfpE06RpzKWq1GvlI1G5abbr1Xq0stYy991wCdMFc_-aT_7Sn4XiUePRo';

    RestClient client = RestClient(dio);

    _searchResultData = await client.getSearchResultData(searchText: searchText);
    notifyListeners();
    return _searchResultData;
  }

  bool get searchComplete => _searchComplete;
  SearchResultData get searchResultData => _searchResultData!;
  List<RelatedSearchDatas> get relatedSearchData => _relatedSearchData!;

  TextEditingController get searchTextController => _searchTextController;
  String get searchText => _searchText;

  String getSearchText() {
    return _searchTextController.text;
  }
}