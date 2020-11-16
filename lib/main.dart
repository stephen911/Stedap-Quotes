//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'loading.dart';
import 'tag.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    var url = "http://quotes.toscrape.com/";
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

  List<String> categorylist = [
    "love",
    "life",
    "inspiration",
    "humor",
    "books",
    "reading",
    "friendship",
    "friends",
    "truth"
  ];
  List<String> images = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Stedap Quotes"),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                getData();
              })
        ],
        //leading: Icon(Icons.local_library),
      ),
      drawer: Drawer(
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                child: Text(
                  "Menu",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    image: DecorationImage(image: AssetImage("corona.jpg")))),
            ListTile(
              title: Text("Home"),
              leading: Icon(Icons.home, color: Colors.lightBlue),
              onTap: () {
                print("home");
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
                title: Text("Mail"),
                leading: Icon(Icons.mail, color: Colors.lightBlue),
                onTap: () {
                  print("mail");
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text("Chrome Cast"),
                leading: Icon(Icons.cast, color: Colors.lightBlue),
                onTap: () {
                  print("mail");
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text("Send Us a message"),
                leading: Icon(Icons.message, color: Colors.lightBlue),
                onTap: () {
                  print("message");
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text("Call Us"),
                leading: Icon(Icons.call, color: Colors.lightBlue),
                onTap: () {
                  print("Call Made");
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text("Wrist Wear"),
                leading: Icon(Icons.watch, color: Colors.lightBlue),
                onTap: () {
                  print("Watch");
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text("Account"),
                leading: Icon(Icons.person, color: Colors.lightBlue),
                onTap: () {
                  print("Account");
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text("people"),
                leading: Icon(Icons.people, color: Colors.lightBlue),
                onTap: () {
                  print("people");
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text("Add a Phote"),
                leading: Icon(Icons.add_a_photo, color: Colors.lightBlue),
                onTap: () {
                  print("alarm");
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text("Alarm"),
                leading: Icon(Icons.alarm, color: Colors.lightBlue),
                onTap: () {
                  print("Alarm");
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text("Favorite"),
                leading: Icon(Icons.favorite, color: Colors.lightBlue),
                onTap: () {
                  print("favorite");
                  Navigator.pop(context);
                }),
            ListTile(
                title: Text("Close"),
                leading: Icon(Icons.exit_to_app, color: Colors.lightBlue),
                onTap: () {
                  print("add people");
                  Navigator.pop(context);
                })
          ],
        ),
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(children: <Widget>[
            SizedBox(height: 10.0),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: categorylist.map((categoryname) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Tag(name: categoryname)));
                  },
                  child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      width: size.width / 2 - 20,
                      height: size.height * 0.10,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(children: <Widget>[
                        Container(),
                        // height: 30,
                        // width: 30,
                        //child: Image.network("https://image.shutterstock.com/z/stock-photo-quote-best-inspirational-and-motivational-quotes-and-sayings-about-life-wisdom-positive-706296535.jpg", fit: BoxFit.fill,),),
                        Container(
                          child: Text(
                            categoryname.toUpperCase(),
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ])),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            if (dataisthere == false)
              Column(
                      children: [
                        SizedBox(height: 20),
                        Center(child: CircularProgressIndicator()),
                        SizedBox(height: 20),
                        GlobalLoading(),
                      ],
                    )
            else
              ListView.builder(
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
          ])),
    );
  }
}
