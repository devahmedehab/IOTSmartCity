import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smart_city/layout/cubit/cubit.dart';
import 'package:smart_city/layout/cubit/state.dart';
import 'package:smart_city/modules/About_us/about_us_screen.dart';
import 'package:smart_city/modules/parking/parking_screen.dart';
import 'package:smart_city/modules/profile/profile.dart';
import 'package:smart_city/modules/setting/settings_screen.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:smart_city/shared/components/constants.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:smart_city/shared/style/icon_broken.dart';

class LayoutScreen extends StatefulWidget {
  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

final ZoomDrawerController z = ZoomDrawerController();

class _LayoutScreenState extends State<LayoutScreen> {
  Color color = ThemeMode.light != null ? HexColor('333739') : Colors.white;

  bool _hasInternet = false;

  ConnectivityResult result = ConnectivityResult.none;

  RefreshController _refreshController = RefreshController();

  var emailController = TextEditingController();

  var nameController = TextEditingController();

  void status = showToast(text: 'Connecting...', state: ToastStates.SUCCESS);
  Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    checkRealtimeConnection();
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  StreamSubscription _streamSubscription;

  void checkRealtimeConnection() async {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile) {
        status =
            showToast(text: 'Connection Success', state: ToastStates.SUCCESS);
      } else if (event == ConnectivityResult.wifi) {
        status =
            showToast(text: 'Connection Success', state: ToastStates.SUCCESS);
      } else {
        status = showToast(text: 'Not Connected', state: ToastStates.SUCCESS);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParkingCubit, ParkingStates>(
        listener: (context, state) {
      var model = ParkingCubit.get(context).userModel;
      emailController.text = model.data.email;
      nameController.text = model.data.username;
    }, builder: (context, state) {
      var cubit = ParkingCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Smart City',
          ),
          elevation: 10,
        ),
        body: SmartRefresher(
          child: cubit.bottomScreen[cubit.currentIndex],
          onRefresh: () async {
            await Future.delayed(Duration(microseconds: 500));
            _refreshController.refreshFailed();

            _hasInternet = await InternetConnectionChecker().hasConnection;
            final text = _hasInternet
                ? 'Network Connection Success'
                : 'Network Connection Failed';
            result = await Connectivity().checkConnectivity();

            if (_hasInternet) {
              ParkingCubit.get(context).getUserData();
              showToast(text: text, state: ToastStates.SUCCESS);
            } else {
              showToast(text: text, state: ToastStates.SUCCESS);
            }
          },
          onLoading: () async {
            await Future.delayed(Duration(microseconds: 500));
            _refreshController.refreshFailed();
          },
          controller: _refreshController,
        ),
        drawer: Container(
          // color: Colors.white,
          child: ClipRRect(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(35),
                  bottomRight: Radius.circular(35)),
              child: Drawer(
                width: 300,
                child: ListView(
                  children: [
                    DrawerHeader(
                        //  decoration: BoxDecoration(color: Colors.blueGrey),
                        child: InkWell(

                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 31,
                            backgroundColor: Colors.deepPurpleAccent,
                            child: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/onboard_1.png')),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 180,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(nameController.text,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 20,
                                      // color: Colors.black,
                                      fontFamily: '',
                                    )),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  emailController.text,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: '',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () async {
                        _hasInternet =
                            await InternetConnectionChecker().hasConnection;

                        if (_hasInternet) {
                          navigateTo(
                            context,
                            ProfileScreen(),
                          );
                        } else {
                          showToast(
                              text: 'Please Check Your Network Connection',
                              state: ToastStates.ERROR);
                        }
                      },
                    )),
                    myDivider(),
                    SizedBox(
                      height: 30,
                    ),
                    buildListTile("Main Screen", IconBroken.Home, () {
                      navigateAndFinish(context, LayoutScreen());
                    }, ParkingCubit.get(context).color),
                    SizedBox(
                      height: 15,
                    ),
                    buildListTile("Profile", IconBroken.Profile, () async {
                      _hasInternet =
                          await InternetConnectionChecker().hasConnection;

                      if (_hasInternet) {
                        navigateTo(
                          context,
                          ProfileScreen(),
                        );
                      } else {
                        showToast(
                            text: 'Please Check Your Network Connection',
                            state: ToastStates.ERROR);
                      }
                    }, ParkingCubit.get(context).color),
                    SizedBox(
                      height: 15,
                    ),
                    buildListTile("Settings", IconBroken.Setting, () {
                      navigateTo(context, SettingsScreen());
                    }, ParkingCubit.get(context).color),
                    SizedBox(
                      height: 15,
                    ),
                    buildListTile("About Us", IconBroken.Info_Circle, () {
                      navigateTo(context, AboutUsScreen());
                    }, ParkingCubit.get(context).color),
                    SizedBox(
                      height: 15,
                    ),
                    myDivider(),
                    SizedBox(
                      height: 15,
                    ),
                    buildListTile("Log out", IconBroken.Logout, () {
                      signOut(context);
                    }, ParkingCubit.get(context).color),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        //

        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            cubit.changeBottom(index);
          },
          currentIndex: cubit.currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(IconBroken.Category),
              label: 'Parking',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconBroken.Home),
              label: 'Home',
            ),
          ],
        ),
      );
      // );
    });
  }
}
