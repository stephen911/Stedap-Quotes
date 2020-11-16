import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

import 'loading.dart';


class Tag extends StatefulWidget {
  final String name;

  const Tag({Key key, this.name}) : super(key: key);
  @override
  _TagState createState() => _TagState();
}

class _TagState extends State<Tag> {
  bool dataisthere = false;
  List<String> quotes = List();
  List<String> author = List();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    print("getting data");
    var url = "http://quotes.toscrape.com/tag/${widget.name}/";
    var response = await http.get(url);
    dom.Document document = parser.parse(response.body);
    final mainclass = document.getElementsByClassName("quote");
    setState(() {
      print(mainclass[0].getElementsByClassName("text")[0].innerHtml);
      quotes = mainclass
          .map((element) => element.getElementsByClassName("text")[0].innerHtml)
          .toList();
      print(quotes);
      author = mainclass
          .map((elements) =>
              elements.getElementsByClassName("author")[0].innerHtml)
          .toList();
      print(author);
      dataisthere = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name} Quotes"),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                getData();
              })
        ],
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              // Center(
              //   child: Text(
              //     widget.name,
              //     style: GoogleFonts.montserrat(
              //         fontSize: 20,
              //         color: Colors.black,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              dataisthere == false
                  ? Column(
                      children: [
                        SizedBox(height: 20),
                        Center(child: CircularProgressIndicator()),
                        SizedBox(height: 20),
                        GlobalLoading(),
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: quotes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          child: Card(
                            elevation: 10.0,
                            child: Column(children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.all(4),
                                child: Text(
                                  quotes[index],
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.all(4),
                                child: Text(
                                  author[index],
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                          ),
                        );
                      })
            ],
          )),
    );
  }
}

