import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_mindd/core/utils/app_assets.dart';
import 'package:task_mindd/features/Layout/cubit/home_cubit.dart';
import 'package:task_mindd/features/Layout/favourite_screen.dart';
import 'package:task_mindd/features/Layout/menu_screen.dart';
import 'package:task_mindd/features/Layout/profile_screen.dart';

import 'cart_screen.dart';
import 'home_screen.dart';

class LayoutScreen extends StatefulWidget {
  static String routName = "/LayoutScreen";

  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  late PageController controller;
  int currentScreen = 0;
  bool isLoadingProds = true;

  List<Widget> screens = [
    const HomeScreen(),
    const MenuScreen(),
    const CartScreen(),
    const FavouriteScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: currentScreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery
        .of(context)
        .viewInsets
        .bottom == 0.0;
    return SafeArea(
      child: Scaffold(
          body: screens[currentScreen],
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Visibility(
            visible: showFab,
            child: FloatingActionButton(
              elevation: 2,
              onPressed: () {
                setState(() {
                  currentScreen = 2;
                });
              },
              shape: const StadiumBorder(
                  side: BorderSide(width: 4, color: Colors.white)),
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xff8E8E93),
              child: Icon(Icons.shopping_cart,
                  color: currentScreen == 2 ? const Color(0xffEBC00D) : null),
            ),
          ),
          bottomNavigationBar: BottomAppBar(

              height: kBottomNavigationBarHeight * 1.5,
              shape: const CircularNotchedRectangle(),
              notchMargin: 5,
              elevation: 1,
              color: const Color(0xffFFFFFF),
              child: IconTheme(
                data: const IconThemeData(color: Color(0xff8E8E93)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            currentScreen = 4;
                          });
                        },
                        child: IconButton(
                          icon: const Icon(FontAwesomeIcons.circleUser),
                          onPressed: () {
                            setState(() {
                              currentScreen = 4;
                            });
                          },
                          color: currentScreen == 4
                              ? const Color(0xffEBC00D)
                              : null,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            currentScreen = 3;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SvgPicture.asset(
                            AppAssets.imagesFavourite,
                            color: currentScreen == 3
                                ? const Color(0xffEBC00D)
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      InkWell(
                        onTap: () {
                          setState(() {
                            currentScreen = 1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SvgPicture.asset(
                            AppAssets.imagesMenu,
                            color: currentScreen == 1
                                ? const Color(0xffEBC00D)
                                : null,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            currentScreen = 0;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SvgPicture.asset(
                            AppAssets.imagesHome,
                            color: currentScreen == 0
                                ? const Color(0xffEBC00D)
                                : const Color(0xff8E8E93),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}
