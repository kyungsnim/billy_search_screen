import 'package:billy_search_screen/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContentWebViewScreen extends StatelessWidget {
  String? link;

  ContentWebViewScreen({Key? key, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebView(
            initialUrl: link,
            javascriptMode: JavascriptMode.unrestricted,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    /// back button
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: renderIcon(context, Icons.clear),
                    ),

                    const Spacer(),

                    /// share button
                    renderIcon(context, Icons.share),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),

                    /// book mark button
                    renderIcon(context, Icons.bookmark_border)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget renderIcon(BuildContext context, IconData icon) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: unUsableColor,
        ),
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.width * 0.1,
        child: Center(
          child: Icon(icon,
              color: Colors.white,
              size: MediaQuery.of(context).size.width * 0.06),
        ),
      ),
    ]);
  }
}
