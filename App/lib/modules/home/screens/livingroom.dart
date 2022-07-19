import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city/models/light_model.dart';
import 'package:smart_city/modules/home/cubit/cubit.dart';
import 'package:smart_city/modules/home/cubit/states.dart';
import 'package:smart_city/modules/home/custom_card.dart';
import 'package:smart_city/modules/home/weather/extraWeather.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:smart_city/shared/components/constants.dart';
import 'package:intl/intl.dart';
import 'package:smart_city/shared/components/constants.dart';

class LivingRoom extends StatefulWidget {
  @override
  State<LivingRoom> createState() => _LivingRoomState();
}

class _LivingRoomState extends State<LivingRoom> {
  var formKey = GlobalKey<FormState>();
  List listLights;
  LightModel lightsModel;

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    double temperature = 7;
    Size size = MediaQuery.of(context).size;
    RefreshController _refreshController = RefreshController();
    bool _hasInternet = false;
    ConnectivityResult result = ConnectivityResult.none;
    var lightController = TextEditingController();
    bool lighted = false;



    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeGetSuccessLightsState) {

            var model = HomeCubit.get(context).lightsModel;
            led_1 = model.data.led1;
           // led_2 = model.data.led2;
            led_3 = model.data.led3;
            led_4 = model.data.led4;
            led_5 = model.data.led5;
            led_6 = model.data.led6;
        }
      },
      builder: (context, state) {



        return Scaffold(
            appBar:defaultAppBar(context: context, title: 'Living Room'),
            body: SmartRefresher(
              onRefresh: () async {
                await Future.delayed(Duration(microseconds: 500));
                _refreshController.refreshFailed();
                _hasInternet = await InternetConnectionChecker().hasConnection;
                final color = _hasInternet ? Colors.green : Colors.red;

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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CurrentWeather(),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: SingleChildScrollView(
                          child: Container(
                            width: 200,
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
                                          HomeCubit.get(context).icon2,
                                          Spacer(),
                                          Switch(
                                              value: HomeCubit.get(context).isLighted2,
                                              onChanged: (value) {
                                                lighted = !lighted;
                                                if (lighted ) {
                                                  HomeCubit.get(context)
                                                      .lightSwitch2();
                                                  HomeCubit.get(context).postLightData(
                                                      led1: led_1, led2: 1, led3: led_3, led4: led_4,led5: led_5,led6: led_6);
                                                }
                                                else {
                                                  HomeCubit.get(context)
                                                      .lightSwitch2();
                                                  HomeCubit.get(context).postLightData(
                                                      led1: led_1, led2: 0, led3: led_3, led4: led_4,led5: led_5,led6: led_6);
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
                    /*TextButton(
                      onPressed: () {
                        lighted = !lighted;

                        if (lighted) {
                          HomeCubit.get(context).postLightData(
                              led1: 0, led2: led_2, led3: led_3, led4: led_4,led5: led_5,led6: led_6);
                        } else {
                          HomeCubit.get(context).postLightData(
                              led1: 1, led2: led_2, led3: led_3, led4: led_4,led5: led_5,led6: led_6);
                        }
                      },
                      child: Text('Ahmed'),
                    ),*/
                  ],
                ),
              ),
            ));
      },
    );
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setAppId(oneSignalId);
  }
}

class CurrentWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      height: MediaQuery.of(context).size.height - 350,
      // margin: EdgeInsets.all(2),
      padding: EdgeInsets.only(top: 10, left: 30, right: 30),
      glowColor: Color(0xff00A1FF).withOpacity(0.5),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      color: Color(0xff00A1FF),
      spreadRadius: 5,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Today',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          Container(
            height: 250,
            child: Stack(
              children: [
                if (temp >= 25 && rain == 1)
                  Image(
                    image: AssetImage('assets/images/sunny.png'),
                    fit: BoxFit.fill,
                  ),
                if (5 < temp && temp < 25 && rain == 1)
                  Image(
                    image: AssetImage('assets/images/thunder.png'),
                    fit: BoxFit.fill,
                  ),
                if (temp <= 5 && rain == 1)
                  Image(
                    image: AssetImage('assets/images/snow.png'),
                    fit: BoxFit.fill,
                  ),
                if (rain != 1)
                  Image(
                    image: AssetImage('assets/images/rainy.png'),
                    fit: BoxFit.fill,
                  ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Center(
                      child: Column(
                        children: [
                          GlowText(
                            '$temp°c',
                            style: TextStyle(
                                height: 0.1,
                                fontSize: 60,
                                fontWeight: FontWeight.bold),
                          ),
                          Text('${DateFormat.EEEE().format(DateTime.now())}',
                              style: TextStyle(
                                fontSize: 18,
                              ))
                        ],
                      )),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          SizedBox(
            height: 5,
          ),
          ExtraWeather()
        ],
      ),
    );
  }
}
