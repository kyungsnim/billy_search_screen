import 'package:billy_search_screen/retrofit/rest_client.dart';
import 'package:billy_search_screen/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _searchText = '';
  RestClient? client;
  bool _searchComplete = false;

  _SearchScreenState() {
    _searchTextController.addListener(() {
      setState(() {
        _searchText = _searchTextController.text;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    Dio dio = Dio();
    dio.options.headers['Content-type'] = 'application/json';
    dio.options.headers['authorization'] =
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZjYjAwNGE2OTEyNDUzN2U4MGYwZDllNzVhODFmYjI3ODVkZWUzYjljOTY5OGFiZjU4ZWM1YTVjYjI2ZWMyZWRjMTBmM2NlMjYxYTdjZjQwIn0.eyJhdWQiOiIzIiwianRpIjoiZmNiMDA0YTY5MTI0NTM3ZTgwZjBkOWU3NWE4MWZiMjc4NWRlZTNiOWM5Njk4YWJmNThlYzVhNWNiMjZlYzJlZGMxMGYzY2UyNjFhN2NmNDAiLCJpYXQiOjE2MzQxMzAyNjksIm5iZiI6MTYzNDEzMDI2OSwiZXhwIjoxNjY1NjY2MjY5LCJzdWIiOiIxMDg4MzIiLCJzY29wZXMiOltdfQ.ilrAkzRppNfe8s1nPUu4ONzLDkfZq_jJ47Uk3dArcVkMQ_7Hta2S_l28CFqvfMqh8pXl7Gfqhwnxv05_1_JpKOid8wQzdRcn6006tDUb8nd5PbBr2cUyjV1v-WS0KPtIj53YnBM_p0IYEEyxXcAUJnAzjeNCqW4RioFOvLzCqcCfYa2FYXHGRwXNw515rbuR3SUbM6oQM4TfZ-xSkE-tviycy0S2rrKmUQsjjq1OCuU5TGWR6rAzcsv90XVwbtJTTiHQpBvADmA_vPoALz0m0X-1SOrAcsc9FkmzzRb6tm1nzmQU99LkjZbtOMHhieONMEjONJj89NZHfGH1XIOiqROzjg4q1qVPYBu2BNAZVnq2GgVneFacgYarxSGWZKq0Y8UDrUgmfbEMLLKujJdqKb5Qkk_W2S_UHlxofh9QZP0mEjXKzT3rOtad0XcgsQV00d9v6ohnOQU0L2Guopj4mdMTRqE_pVu0EspUYzHgjHxPcsw3iQAjrYMTaueKUm9CBvED2ZMihYQjs0kiPEIbTr_Cgnb0EsuBH0kUW5QC5s2oV5erkWUFXC60CAjsz85yyvWWJ1Tri8IgqkpOHtem2l9deLnSNt7SwaF6sO_iWW7r1dbRaDAfpE06RpzKWq1GvlI1G5abbr1Xq0stYy991wCdMFc_-aT_7Sn4XiUePRo';

    client = RestClient(dio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          /// Safe Area
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),

          /// 검색창
          searchBar(_focusNode, _searchTextController),

          /// 검색어 입력이 없을 때와 입력이 있을 때 화면 분기처리
          _focusNode.hasFocus
              ? _relatedSearchTextBody()
              : _searchComplete
                  ? _postAndEventSearchBody()
                  : Container(),
        ],
      ),
    ));
  }

  Widget _relatedSearchTextBody() {
    return FutureBuilder(
        future: client!.getRelatedSearchDatas(searchText: _searchText),
        builder: (_, AsyncSnapshot snapshot) {
          /// 데이터 불러오는 동안은 빈 화면 보여주기
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          List<RelatedSearchDatas> relatedSearchDataList = snapshot.data;

          /// 검색창과 연관검색어 공백 없애기
          return MediaQuery.removePadding(
            context: context,
            removeTop: true, // 최상단 공백 제거
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: relatedSearchDataList.length,
              itemBuilder: (_, index) {
                return relatedSearchTextItem(
                    text: relatedSearchDataList[index].name!);
              },
            ),
          );
        });
  }

  relatedSearchTextItem({required String text}) {
    return InkWell(
      onTap: () async {
        /// 연관검색어 화면에서 검색 결과 화면으로 변경
        _focusNode.unfocus();
        _searchComplete = true;
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Row(children: [
          /// 검색창과 여백 맞추기 위해 공백 넣어주기
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(
              Icons.arrow_back,
              color: Colors.transparent,
            ),
          ),

          /// 검색 텍스트는 하이라이트
          SubstringHighlight(
            textStyle: TextStyle(fontSize: mediumFontSize, color: Colors.black),
            textStyleHighlight: TextStyle(
                color: baseColor,
                fontWeight: FontWeight.w900,
                fontSize: mediumFontSize),
            text: text,
            term: _searchText, // highlight
          ),
        ]),
      ),
    );
  }

  Widget _postAndEventSearchBody() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _postSearchBody(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        ],
      ),
    );
  }

  Widget _titleText(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: smallFontSize,
        color: baseColor,
      ),
    );
  }

  Widget _postSearchBody() {
    return FutureBuilder(
        future: client!.getSearchResultData(searchText: _searchText),
        builder: (_, AsyncSnapshot snapshot) {
          /// 데이터 불러오는 동안은 빈 화면 보여주기
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }

          Data data = Data.fromJson(snapshot.data.data);

          /// 검색창과 연관검색어 공백 없애기
          return MediaQuery.removePadding(
            context: context,
            removeTop: true, // 최상단 공백 제거
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                _titleText('컨텐츠 검색 결과'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(), // 자체 스크롤 안되게 설정
                  itemCount: data.posts!.length,
                  itemBuilder: (_, index) {
                    return _postSearchItem(text: data.posts![index].title!);
                  },
                ),
                _titleText('상품 검색 결과'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  // 자체 스크롤 안되게 설정
                  itemCount: data.events!.length,
                  itemBuilder: (_, index) {
                    return _eventSearchItem(item: data.events![index]);
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1 / 2),
                ),
              ],
            ),
          );
        });
  }

  Widget _postSearchItem({required String text}) {
    return InkWell(
      onTap: () async {
        ///
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          /// 검색 텍스트는 하이라이트
          SubstringHighlight(
            textStyle: TextStyle(fontSize: mediumFontSize, color: Colors.black),
            textStyleHighlight: TextStyle(
                color: baseColor,
                fontWeight: FontWeight.w900,
                fontSize: mediumFontSize),
            text: text,
            term: _searchText, // highlight
          ),
          Divider(
            thickness: 1.5,
            color: unUsableColor.withOpacity(0.5),
          ),
        ]),
      ),
    );
  }

  Widget _eventSearchItem({required Event item}) {
    var formatter = NumberFormat('#,###,000');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 상품 사진
        Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(item.photo!),
          ),
          const Positioned(
            top: 5,
            right: 5,
            child: Icon(
              Icons.bookmark_border,
              color: Colors.white,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: baseColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(item.dcrate!, style: eventItemRateTextStyle),
              ),
            ),
          )
        ]),

        /// 상품 브랜드
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(item.brand!['name'], style: eventItemBrandTextStyle),
        ),

        /// 상품명
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Container(
            child: Text(
                item.title!.length > 23
                    ? item.title!.substring(0, 15) + '...'
                    : item.title!,
                style: eventItemTitleTextStyle),
          ),
        ),


        /// 상품가격
        Text('${formatter.format(int.parse(item.dcprice!))}원',
            style: eventItemPriceTextStyle),

        /// 최하단 공백처리
        const Spacer(),
      ],
    );
  }
}
