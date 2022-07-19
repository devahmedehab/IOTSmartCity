import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smart_city/modules/home/cubit/cubit.dart';
import 'package:smart_city/modules/home/cubit/states.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:smart_city/shared/components/constants.dart';

class BathRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _hasInternet = false;
    bool lighted = false;



    Size size = MediaQuery.of(context).size;
    RefreshController _refreshController = RefreshController();

    ConnectivityResult result = ConnectivityResult.none;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeGetSuccessLightsState) {
          var model = HomeCubit.get(context).lightsModel;
          led_1 = model.data.led1;
          led_2 = model.data.led2;
          //led_3 = model.data.led3;
          led_4 = model.data.led4;
          led_5 = model.data.led5;
          led_6 = model.data.led6;
        }
      },
      builder: (context, state) {
        bool isSwitched = false;
        return Scaffold(
          appBar: defaultAppBar(context: context, title: 'Bathroom'),
          body: SmartRefresher(
            onRefresh: () async {
              await Future.delayed(Duration(microseconds: 500));
              _refreshController.refreshFailed();
              _hasInternet = await InternetConnectionChecker().hasConnection;

              result = await Connectivity().checkConnectivity();

              if (_hasInternet) {
                HomeCubit.get(context).getHomeData();
              }
            },
            onLoading: () async {
              await Future.delayed(Duration(microseconds: 500));
              _refreshController.refreshFailed();
            },
            //  enablePullUp: true,
            controller: _refreshController,
            child: Column(children: [
              SizedBox(height: 20),
              Text(
                'Today',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w200,
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                        child: Container(
                          width: 180,
                          height: 160,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            elevation: 40,
                            shadowColor: Colors.black,
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        HomeCubit.get(context).icon3,
                                        Spacer(),
                                        Switch(
                                            value: HomeCubit.get(context).isLighted3,
                                            onChanged: (value) {
                                              lighted = !lighted;
                                              if (lighted ) {
                                                HomeCubit.get(context)
                                                    .lightSwitch3();
                                                HomeCubit.get(context).postLightData(
                                                    led1: led_1, led2: led_2, led3: 1, led4: led_4,led5: led_5,led6: led_6);
                                              }
                                              else {
                                                HomeCubit.get(context)
                                                    .lightSwitch3();
                                                HomeCubit.get(context).postLightData(
                                                    led1: led_1, led2: led_2, led3: 0, led4: led_4,led5: led_5,led6: led_6);
                                              }
                                            }),
                                        SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Light',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),

                  Padding(
                    padding: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                        child: Container(
                          height: 160,
                          width: 200,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            elevation: 40,
                            shadowColor: Colors.black,
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                    ),
                                    if (gas == 0)
                                      Text(
                                        'Warning.!',
                                        style: TextStyle(
                                          fontSize: 12 + (22 * 683 / size.height),
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    if (gas != 0)
                                      Text(
                                        'All is well',
                                        style: TextStyle(
                                          fontSize: 12 + (22 * 683 / size.height),
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Gas',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              )
            ]),
          ),
        );
      },
    );
  }
}
