import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class LearnWebView extends StatefulWidget {
  final String? link;
  final String? title;

  LearnWebView(
      this.title,
      this.link,
      );

  @override
  State<LearnWebView> createState() => _WebViewState();
}

class _WebViewState extends State<LearnWebView> {
  double progress = 0;

  InAppWebViewController? controler;
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          widget.title!,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(widget.link!),
          ),
          onWebViewCreated: (InAppWebViewController _controller) {
            controler = _controller;
          },
          onProgressChanged:
              (InAppWebViewController _controller, int _progress) {
            setState(() {
              progress = _progress / 100;
            });
          },
        ),
        progress < 1
            ? SizedBox(
          child: LinearProgressIndicator(
            color: Colors.pink,
            backgroundColor: Colors.white,
            value: progress,
          ),
        )
            : SizedBox()
      ]),
    );
  }
}
