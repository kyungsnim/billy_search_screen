import 'package:billy_search_screen/retrofit/rest_client.dart';
import 'package:billy_search_screen/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:substring_highlight/substring_highlight.dart';

import 'content_webview_screen.dart';

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
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              /// Safe Area
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),

              /// ?????????
              searchBar(),
              Text(_focusNode.hasFocus.toString()),
              Text(_searchComplete.toString()),
              /// ????????? ????????? ?????? ?????? ????????? ?????? ??? ?????? ????????????
              _focusNode.hasFocus
                  ? _relatedSearchTextBody()
                  : _searchComplete
                      ? _postAndEventSearchBody()
                      : Container(),
            ],
          ),
        ));
  }

  searchBar() {
    return Container(
      /// ????????? ?????? ????????? ?????? ??????
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextField(
              onSubmitted: (text) {
                /// ??????????????? ???????????? ?????? ?????? ???????????? ??????
                _focusNode.unfocus();
                _searchComplete = true;
                _searchTextController.text = text;
              },
              focusNode: _focusNode,
              style: TextStyle(
                fontSize: mediumFontSize,
              ),
              autofocus: true,
              cursorHeight: largeFontSize,
              controller: _searchTextController,
              cursorColor: baseColor,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                fillColor: Colors.transparent,
                filled: true,
                hintText: '????????? ???????????? ????????? ???????????????',
                hintStyle: hintTextStyle,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: baseColor, width: 1.5)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: baseColor, width: 1.5)),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: baseColor, width: 1.5),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }

  Widget _relatedSearchTextBody() {
    return FutureBuilder(
        future: client!.getRelatedSearchDatas(searchText: _searchText),
        builder: (_, AsyncSnapshot snapshot) {
          /// ????????? ???????????? ????????? ??? ?????? ????????????
          if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
            return const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Color(0xFFf0d6c5)),
            );
          }

          List<RelatedSearchDatas> relatedSearchDataList = snapshot.data;

          /// ???????????? ??????????????? ?????? ?????????
          return MediaQuery.removePadding(
            context: context,
            removeTop: true, // ????????? ?????? ??????
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
        /// ??????????????? ???????????? ?????? ?????? ???????????? ??????
        _focusNode.unfocus();
        _searchComplete = true;
        _searchTextController.text = text;
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Row(children: [
          /// ???????????? ?????? ????????? ?????? ?????? ????????????
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(
              Icons.arrow_back,
              color: Colors.transparent,
            ),
          ),

          /// ?????? ???????????? ???????????????
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: smallFontSize,
          color: baseColor,
        ),
      ),
    );
  }

  Widget _postSearchBody() {
    return FutureBuilder(
        future: client!.getSearchResultData(searchText: _searchText),
        builder: (_, AsyncSnapshot snapshot) {
          /// ????????? ???????????? ????????? ??? ?????? ????????????
          if (snapshot.connectionState == ConnectionState.waiting) {
            return progressIndicator(
                height: MediaQuery.of(context).size.height * 0.8);
          }

          Data data = Data.fromJson(snapshot.data.data);

          /// ???????????? ??????????????? ?????? ?????????
          return MediaQuery.removePadding(
            context: context,
            removeTop: true, // ????????? ?????? ??????
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                _titleText('????????? ?????? ??????'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(), // ?????? ????????? ????????? ??????
                  itemCount: data.posts!.length,
                  itemBuilder: (_, index) {
                    /// ????????? 4?????? ????????????
                    if (index < 4) {
                      return _postSearchItem(post: data.posts![index]);
                    } else if (index == 5) {
                      return _morePostList();
                    }
                    return const SizedBox();
                  },
                ),
                _titleText('?????? ?????? ??????'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                /// ?????? ?????? ????????? ?????? ?????? ??????
                data.events!.isNotEmpty
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        // ?????? ????????? ????????? ??????
                        itemCount: data.events!.length,
                        itemBuilder: (_, index) {
                          return _eventSearchItem(item: data.events![index]);
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 20,
                                childAspectRatio: 1 / 2),
                      )

                    /// ????????? ?????? ??????
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '?????? ?????? ????????? ???????????????',
                            style: noEventItemTextStyle,
                          ),
                        ],
                      ),
              ],
            ),
          );
        });
  }

  Widget _postSearchItem({required Post post}) {
    return InkWell(
      onTap: () {
        /// webview
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ContentWebViewScreen(link: post.link)));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 0.5, color: unUsableColor),
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SubstringHighlight(
            textStyle: TextStyle(fontSize: mediumFontSize, color: Colors.black),
            textStyleHighlight: TextStyle(
                color: baseColor,
                fontWeight: FontWeight.w900,
                fontSize: mediumFontSize),
            text: post.title!,
            term: _searchText, // highlight
          ),
        ),
      ),
    );
  }

  Widget _eventSearchItem({required Event item}) {
    var formatter = NumberFormat('#,###,000');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ?????? ??????
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

        /// ?????? ?????????
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
          child: Text(item.brand!['name'], style: eventItemBrandTextStyle),
        ),

        /// ?????????
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
              item.title!.length > 23
                  ? item.title!.substring(0, 15) + '...'
                  : item.title!,
              style: eventItemTitleTextStyle),
        ),

        /// ????????????
        Text('${formatter.format(int.parse(item.dcprice!))}???',
            style: eventItemPriceTextStyle),

        /// ????????? ????????????
        const Spacer(),
      ],
    );
  }

  Widget _morePostList() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('??? ?????? ????????? ????????????', style: moreInfoTextStyle),
          const SizedBox(width: 10),
          Icon(
            Icons.arrow_forward_ios,
            color: baseColor,
            size: 15,
          ),
        ],
      ),
    );
  }
}
