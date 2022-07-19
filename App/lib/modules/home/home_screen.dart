import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smart_city/modules/home/cubit/cubit.dart';
import 'package:smart_city/modules/home/cubit/states.dart';
import 'package:smart_city/modules/home/screens/Garage.dart';
import 'package:smart_city/modules/home/screens/bathroom.dart';
import 'package:smart_city/modules/home/screens/bedroom.dart';
import 'package:smart_city/modules/home/screens/kitchen.dart';
import 'package:smart_city/modules/home/screens/livingroom.dart';
import 'package:smart_city/modules/home/screens/roof.dart';
import 'package:smart_city/modules/password/gatePassword.dart';
import 'package:smart_city/modules/verify/verify_email.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:smart_city/shared/components/constants.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(
      BuildContext context,
      ) {
    int selectedCard = -1;
    RefreshController _refreshController = RefreshController();
    bool _hasInternet = false;
    ConnectivityResult result = ConnectivityResult.none;

    double temperature = 7;
    Size size = MediaQuery.of(context).size;
    Color color =HomeCubit.get(context).isDark ? Colors.black :Colors.blue;

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is ParkingSuccessHomeState) {

          if (state.homeModel.status) {
            var model = HomeCubit.get(context).homeModel;
            temp = model.data.degrees[0];
            gas = model.data.degrees[1];
            hum = model.data.degrees[2];
            rain = model.data.degrees[3];
          }
        }
      },
      builder: (context, state) {
        return Scaffold(


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
            child: Center(

                child: GridView.extent(

                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 7),
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  maxCrossAxisExtent: 300.0,
                  children: <Widget>[
                    SingleChildScrollView(
                      child: InkWell(
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(20),bottomRight:Radius.circular(20) )),
                          elevation: 40,
                          shadowColor: Colors.black,

                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Garage',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Image(image: AssetImage('assets/images/garage5.png')),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),

                        ),
                        onTap: (){
                          HomeCubit.get(context).getLightsData();
                          navigateTo(context, Garage());
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      child: InkWell(
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(20),bottomRight:Radius.circular(20) )),
                          elevation: 40,
                          shadowColor: Colors.black,


                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Living Room',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Image(image: AssetImage('assets/images/living.png')),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),

                        ),
                        onTap: (){
                          HomeCubit.get(context).getLightsData();
                          navigateTo(context, LivingRoom());
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      child: InkWell(
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(20),bottomRight:Radius.circular(20) )),
                          elevation: 40,
                          shadowColor: Colors.black,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Kitchen',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Image(image: AssetImage('assets/images/kitchen1.png')),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),

                        ),
                        onTap: (){
                          HomeCubit.get(context).getLightsData();
                          navigateTo(context, Kitchen());
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      child: InkWell(
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(20),bottomRight:Radius.circular(20) )),
                          elevation: 40,
                          shadowColor: Colors.black,


                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Bathroom',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Image(image: AssetImage('assets/images/bath1.png')),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),

                        ),
                        onTap: (){
                          HomeCubit.get(context).getLightsData();
                          navigateTo(context, BathRoom());
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      child: InkWell(
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(20),bottomRight:Radius.circular(20) )),
                          elevation: 40,
                          shadowColor: Colors.black,


                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Bed Room',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Image(image: AssetImage('assets/images/bed4.png')),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),

                        ),
                        onTap: (){
                          HomeCubit.get(context).getLightsData();
                          navigateTo(context, BedRoom());
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      child: InkWell(
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(20),bottomRight:Radius.circular(20) )),
                          elevation: 40,
                          shadowColor: Colors.black,


                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Roof',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Image(image: AssetImage('assets/images/roof3.png')),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),

                        ),
                        onTap: (){
                          HomeCubit.get(context).getLightsData();
                          navigateTo(context, Roof());
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      child: InkWell(

                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(20),bottomRight:Radius.circular(20) )),
                          elevation: 40,
                          shadowColor: Colors.black,


                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Gate',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              // Image(image: AssetImage('assets/images/roof3.png')),+
                              Icon(Icons.door_sliding_outlined,size: 95,color: Colors.black,),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),

                        ),
                        onTap: (){
                          navigateTo(context, GatePassword());
                        },
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}