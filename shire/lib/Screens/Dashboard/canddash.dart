// ignore_for_file: prefer_final_fields, sort_child_properties_last, prefer_const_constructors, unused_import

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shire/Screens/Auth/screens/welcome_screen.dart';
import 'package:shire/Screens/FilePicker/filepicker.dart';
import 'package:shire/Screens/FilePicker/fp.dart';
import 'package:shire/Screens/FilePicker/fp1.dart';
import 'package:shire/Screens/FilePicker/fp2.dart';
import 'package:shire/animation.dart';
import 'package:shire/back.dart';
import 'package:shire/jsondisplay1.dart';
import 'package:shire/main.dart';

class CandDash extends StatefulWidget {
  const CandDash({Key? key}) : super(key: key);

  @override
  State<CandDash> createState() => _DashBoardState();
}

class _DashBoardState extends State<CandDash> {
  final String? userName = FirebaseAuth.instance.currentUser?.displayName;

  late final PageController pageController;
  ScrollController _scrollController = ScrollController();
  int pageNo = 0;

  Timer? carasouelTmer;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == 4) {
        pageNo = 0;
      }
      pageController.animateToPage(
        pageNo,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCirc,
      );
      pageNo++;
    });
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    carasouelTmer = getTimer();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showBtmAppBr = false;
        setState(() {});
      } else {
        showBtmAppBr = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  bool showBtmAppBr = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(
                height: 36.0,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ListTile(
                  onTap: () {},
                  selected: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  selectedTileColor: Colors.lightBlueAccent,
                  title: Text(
                    "Hello Candidate",
                    style: Theme.of(context).textTheme.titleMedium!.merge(
                          const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0,
                          ),
                        ),
                  ),
                  subtitle: Text(
                    "Welcome",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  trailing: PopUpMen(
                    menuList: const [
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.person,
                          ),
                          title: Text("My Profile"),
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.bag,
                          ),
                          title: Text("Edit Profile"),
                        ),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        child: Text("Settings"),
                      ),
                      PopupMenuItem(
                        child: Text("About Us"),
                      ),
                      // PopupMenuDivider(),
                      // PopupMenuItem(
                      //   child: ListTile(
                      //     leading: Icon(
                      //       Icons.logout,

                      //     ),

                      //     title: Text("Log Out"),

                      //   ),
                      // ),
                    ],
                    icon: CircleAvatar(
                      backgroundImage: const NetworkImage(
                          '../../../assets/images/LOGO 1.png'),
                      child: Container(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    pageNo = index;
                    setState(() {});
                  },
                  itemBuilder: (_, index) {
                    return AnimatedBuilder(
                      animation: pageController,
                      builder: (ctx, child) {
                        return child!;
                      },
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text("Hello you tapped at ${index + 1} "),
                            ),
                          );
                        },
                        onPanDown: (d) {
                          carasouelTmer?.cancel();
                          carasouelTmer = null;
                        },
                        onPanCancel: () {
                          carasouelTmer = getTimer();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: 8, left: 8, top: 24, bottom: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 5,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.circle,
                        size: 12.0,
                        color: pageNo == index
                            ? Colors.indigoAccent
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: GridB(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: showBtmAppBr
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) {
      //           return FP();
      //         },
      //       ),
      //     );
      //   },
      //   child: const Icon(
      //     Icons.upload_file,
      //   ),
      // ),
      bottomNavigationBar: AnimatedContainer(
        child: BottomAppBar(
          notchMargin: 8.0,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.dashboard,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Json();
                      },
                    ),
                  );
                },
                icon: const Icon(
                  CupertinoIcons.search,
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MyAnimatedText();
                      },
                    ),
                  );
                },
                icon: const Icon(
                  CupertinoIcons.settings,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (!mounted) return;
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ButtonSelection();
                  }));
                },
                icon: const Icon(
                  CupertinoIcons.person_crop_circle_fill_badge_xmark,
                ),
              ),
            ],
          ),
        ),
        duration: const Duration(
          milliseconds: 800,
        ),
        curve: Curves.easeInOutSine,
        height: showBtmAppBr ? 70 : 0,
      ),
    );
  }
}

class PopUpMen extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const PopUpMen({Key? key, required this.menuList, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}

class FabExt extends StatelessWidget {
  const FabExt({
    Key? key,
    required this.showFabTitle,
  }) : super(key: key);

  final bool showFabTitle;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      label: AnimatedContainer(
        duration: const Duration(seconds: 2),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            const Icon(CupertinoIcons.cart),
            SizedBox(width: showFabTitle ? 12.0 : 0),
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              child: showFabTitle ? const Text("Go to cart") : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}

class GridB extends StatefulWidget {
  const GridB({Key? key}) : super(key: key);

  @override
  State<GridB> createState() => _GridBState();
}

class _GridBState extends State<GridB> {
  final List<Map<String, dynamic>> gridMap = [
    {
      "title": "Senior Engineer",
      "description": "2-5 years experience",
      "images":
          "https://thumbs.dreamstime.com/b/frontal-male-passport-photo-isolated-white-background-eu-standardization-frontal-male-passport-photo-isolated-white-149548031.jpg"
    },
    {
      "title": "Junior Engineer",
      "description": "0-1 years experience",
      "images":
          "https://thumbs.dreamstime.com/b/frontal-male-passport-photo-isolated-white-background-eu-standardization-frontal-male-passport-photo-isolated-white-149548031.jpg"
    }
    // {
    //   "title": "USER 3",
    //   "description": "EEE",
    //   "images":
    //       "https://thumbs.dreamstime.com/b/frontal-male-passport-photo-isolated-white-background-eu-standardization-frontal-male-passport-photo-isolated-white-149548031.jpg"
    // },
    // {
    //   "title": "USER 4",
    //   "description": "ECE",
    //   "images":
    //       "https://thumbs.dreamstime.com/b/frontal-male-passport-photo-isolated-white-background-eu-standardization-frontal-male-passport-photo-isolated-white-149548031.jpg"
    // },
    // {
    //   "title": "USER 5",
    //   "description": "ECE",
    //   "images":
    //       "https://thumbs.dreamstime.com/b/frontal-male-passport-photo-isolated-white-background-eu-standardization-frontal-male-passport-photo-isolated-white-149548031.jpg"
    // },
    // {
    //   "title": "USER 6",
    //   "description": "CSE",
    //   "images":
    //       "https://thumbs.dreamstime.com/b/frontal-male-passport-photo-isolated-white-background-eu-standardization-frontal-male-passport-photo-isolated-white-149548031.jpg"
    // }
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        mainAxisExtent: 310,
      ),
      itemCount: gridMap.length,
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FP1(),
                  ),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FP2(),
                  ),
                );
                break;
              // add more cases for each item in the gridMap list
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                16.0,
              ),
              color: Colors.amberAccent.shade100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: Image.network(
                    "${gridMap.elementAt(index)['images']}",
                    height: 170,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${gridMap.elementAt(index)['title']}",
                        style: Theme.of(context).textTheme.titleMedium!.merge(
                              const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "${gridMap.elementAt(index)['description']}",
                        style: Theme.of(context).textTheme.titleSmall!.merge(
                              TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.grey.shade500,
                              ),
                            ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              CupertinoIcons.eye,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              CupertinoIcons.pen,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}
