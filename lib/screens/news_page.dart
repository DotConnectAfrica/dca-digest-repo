import 'package:cached_network_image/cached_network_image.dart';
import 'package:dca_digital_digests/screens/terms.dart';
import 'package:dca_digital_digests/screens/webview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import '../auth/login.dart';
import '../constants/DrawerItems.dart';
import '../models/news_model.dart';
import 'help_center.dart';
import 'my_account.dart';
import 'news_description.dart';
import 'notification_page.dart';

class NewsPageScreen extends StatefulWidget {
  State<NewsPageScreen> createState() => _NewsPageScreen();
}


class _NewsPageScreen extends State<NewsPageScreen>{



  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  final userId = FirebaseAuth.instance.currentUser?.uid;


  bool hasExistingLoan = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  double currentPage = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,
        drawer: _drawer(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: _openDrawer,
                        icon: const Icon(
                          Icons.menu_outlined,
                          size: 30.5,
                        )),
                    const Text("DCA DIGITAL DIGEST", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),),
                    Badge(
                      largeSize: 9,
                      label: Container(),
                      alignment: const AlignmentDirectional(35, 8),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return NotificationPage();
                              },
                            ));
                          },
                          icon: const Icon(
                            Icons.notifications_outlined,
                            size: 30.5,
                          )),
                    ),
                    // Switch(
                    //     value: Provider.of<ThemeService>(context).isDarkModeOn,
                    //     onChanged: (_) {
                    //       Provider.of<ThemeService>(context, listen: false)
                    //           .toggleTheme();
                    //     })

                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(child: ListView(
                  children: [
                    Container(
                      child: FutureBuilder<List<ModelNews>>(
                          future: _getNews(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              List<ModelNews> news_list = snapshot.data!;
                              if (news_list.isNotEmpty) {
                                return info_body(news_list);
                              } else {
                                return Center(child: Text('No news available'));
                              }
                            } else if(snapshot.hasError){
                              return const Center(
                                child: Text('Unable to get the Data. Check Your internet Connections !'),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ),
                  ],
                )
                )
              ],
            ),
          ),

        )
    );
  }

  Widget _drawer() {
    var drawerItems = DrawerItems.drawerItems;

    final user = FirebaseAuth.instance.currentUser;
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final email = user!.email;

    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
              color: Colors.pinkAccent,
            ),
            height: 264,
            width: double.infinity,
            margin: EdgeInsets.only(left: 8, right: 8),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          color: Colors.grey, // red as border color
                          width: .2),
                    ),
                    // child: Image.asset(
                    //   'assets/images/default_avatar.png',
                    //   fit: BoxFit.fill,
                    // ),
                    child: const Icon(
                      Icons.person,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),
                Text(
                  '${email}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 2,
                ),
                // Text(
                //   "0728492268",
                //   style: TextStyle(fontSize: 13, color: Colors.white),
                // ),
                const Text(
                  '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: Scrollbar(
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: drawerItems.length,
                itemBuilder: (BuildContext context, int index) {
                  Map item = drawerItems[index];
                  return _item(item, index, '0728492268');
                },
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
  Widget _item(Map item, int index, String? phone) {
    var user = 'auth.currentUser?.uid';
    return ListTile(
      leading: Icon(
        item['icon'],
        size: 24,
        color: Colors.pink.shade300,
      ),
      subtitle: _text(index, item, user, phone),
      title: _title(index, item, user),
      onTap: () {
        _closeDrawer();

        if (index == 0) {
          // _scaffoldKey.currentState?.openEndDrawer();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScreenMyAccount(),
            ),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HelpCenter(),
            ),
          );

          // Navigator.pop(context);
        }else if (index == 2) {

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => Terms(1),
            ),
          );

        }else if (index == 3) {

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => ScreenWebView('About DIGITAL DIGESTS','https://dotconnectafrica.com/dca-digital-digest/'),
            ),
          );

        } else if(index == 4){
          FirebaseAuth.instance.signOut();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen(),
            ),
          );
        }
      },
    );
  }
  Widget _title(index, item, user) {
    if (index == 4 && user != null) {
      return Text(
        'Logout',
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      );
    } else if (index == 4 && user == null) {
      return Text(
        'Log in',
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      );
    } else {
      return Text(
        '${item['name']}',
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      );
    }
  }

  Widget _text(index, item, user, phone) {
    if (index == 4 && user != null) {
      return Text(
        '',
        style: TextStyle(fontSize: 11, color: Colors.grey),
      );
    } else if (index == 4 && user == null) {
      return Text(
        'Login to Shebnks',
        style: TextStyle(fontSize: 11, color: Colors.grey),
      );
    } else {
      return Text(
        '${item['description']}',
        style: TextStyle(fontSize: 11, color: Colors.grey),
      );
    }
  }

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  Widget info_body(List<ModelNews> health_resources) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      // itemCount: NotificationData.health_resources_list.length,
      itemCount: health_resources.length,
      itemBuilder: (context, index) {
        int index_2 = index + 1;

        ModelNews news = health_resources[index];

        // //

        ModelNews news_next = health_resources.last == health_resources[index]
            ? health_resources[index]
            : health_resources[index_2];
        // Map item = NotificationData.health_resources_list[index];
        if (index == 0) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ScreenWebView(news_next.title, news_next.link),
                ),
              );
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: news.image!,
                            fit: BoxFit.cover,
                            // height: 220,
                            width: MediaQuery.of(context).size.width,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[300],
                              height: 160,
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[300],
                              height: 160,
                            ),
                          ),
                        ],
                      ),

                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              news.title!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${news.body!}',
                                  style: TextStyle(fontSize: 13),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                InkWell(
                                  onTap: () {
                                    // Add your logic for handling the "Read more" action here
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      '... Read more',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          ,
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );

        } else {
          return Container(
            margin: EdgeInsets.only(bottom: 4,top: 8, left: 16, right: 16),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewsDescription(news_next.title, news_next.link)));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: CachedNetworkImage(
                      imageUrl: news.image!,
                      fit: BoxFit.cover,
                      height: 120,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                news.title!,
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${news.body!}',
                                    style: TextStyle(fontSize: 13),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Add your logic for handling the "Read more" action here
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        '... Read more',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            ,
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<List<ModelNews>> _getNews() async {

    List<ModelNews> newsResults = [];

    try {
      final response = await http.Client()
          .get(Uri.parse("https://dotconnectafrica.com/dca-digital-digest/"));

      if (response.statusCode == 200) {
        var document = parse(response.body);
        var newsUnfiltered = document.getElementsByClassName('blog-grid-layout');

        for (var element in newsUnfiltered) {
          var title = element
              .getElementsByClassName('theimran-post-layout-one__title')
              .first
              .children
              .first
              .text;
          var date = element
              .getElementsByClassName('theimran-post-layout-one__blog-meta')
              .first
              .children
              .first
              .text;
          var body = element
              .getElementsByClassName('theimran-post-layout-one__excerpt')
              .first
              .children
              .first
              .text;



          var image = element
              .getElementsByClassName('theimran-post-layout-one__thumbnail')
              .first;
          var imgSrc = image.getElementsByTagName("img").first.attributes['data-src'];

          var link = element
              .getElementsByClassName('theimran-post-layout-one__thumbnail')
              .first
              .children
              .first
              .attributes['href'];

          Map<String,dynamic> data ={
            "title": title,
            "date": date,
            "body": body,
            "image": imgSrc,
            "link": link,
          };

          ModelNews news = ModelNews(data);

          newsResults.add(news);
        }
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception();
    }

    return newsResults;
  }
}

class UserDetails{
  String? username;
  String? phoneNumber;

  UserDetails({this.username, this.phoneNumber});
}