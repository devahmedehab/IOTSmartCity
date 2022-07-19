import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smart_city/modules/parking/cubit/cubit.dart';
import 'package:smart_city/modules/parking/cubit/states.dart';
import 'package:smart_city/shared/components/components.dart';
import 'package:smart_city/shared/components/constants.dart';

import '../../layout/cubit/cubit.dart';
import 'Parking.dart';


class NumOfParking extends StatefulWidget {
  Color color=Colors.green;

  String city;

  NumOfParking({@required this.city,Key key}) : super(key: key);

  @override
  State<NumOfParking> createState() => _NumOfParkingState();
}

class _NumOfParkingState extends State<NumOfParking> {
  bool _hasInternet = false;

  ConnectivityResult result = ConnectivityResult.none;

  RefreshController _refreshController = RefreshController();

  var emailController = TextEditingController();

  var nameController = TextEditingController();

  void status = showToast(text: 'Connecting...', state: ToastStates.SUCCESS);

  Connectivity _connectivity = Connectivity();

  var slotController = TextEditingController();

  @override
  Widget build(BuildContext context) => BlocConsumer<SlotsCubit,SlotsStates>(
      listener: (context, state) {

        if(state is ParkingSuccessSlotsState){
          var model = SlotsCubit.get(context).slotsModel;
          var slots={

            freeSlots=model.data.slots[6] ,
          };
          if(freeSlots==0){
            color =Colors.red;
            freeSlots='Full';

          }
          else{
            color=Colors.green;
          }
          if (slots != slots){
            SlotsCubit.get(context).getSlotsData();
          }
        }else
          print('Can\'t get slots');
      },
    builder:(context,state){

      return Scaffold(

        appBar: defaultAppBar(context: context, title: '${widget.city} Parking '),

        body:SmartRefresher(
          onRefresh: () async {
            await Future.delayed(Duration(microseconds: 500));
            _refreshController.refreshFailed();

            _hasInternet = await InternetConnectionChecker().hasConnection;
            final text = _hasInternet
                ? 'Network Connection Success'
                : 'Network Connection Failed';
            result = await Connectivity().checkConnectivity();


              SlotsCubit.get(context).getSlotsData();


          },
          onLoading: () async {
            await Future.delayed(Duration(microseconds: 500));
            _refreshController.refreshFailed();
          },
          controller: _refreshController,
          child: Column(
            children: [
              SizedBox(height: 20,),
              SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(

                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder:(context,index)=>buildChatItem(context,index),
                      separatorBuilder:(context,index)=>SizedBox(
                        height: 10.0,
                      ),
                      itemCount: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  );
}



Widget buildChatItem(BuildContext context,index,) =>

 InkWell(
    onTap: (){
      navigateTo(context, Parking(model: 'Parking ${index+1}'));
    },
    child:Card(
      elevation: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(10),
        )
      ),
      child: Container(
        child:Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 36,
                    backgroundImage: AssetImage(
                      'assets/images/22.jpg',
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child:  Text(
                            'Parking ${index+1}',
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),

                    Row(
                      children: [

                        Text(
                          'Number Of slots : 6',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        Row(
                          children: [

                              Container(
                                width: 8.0,
                                height: 8.0,
                                decoration: BoxDecoration(
                                    color: color, shape: BoxShape.circle),
                              ),

                            SizedBox(
                              width: 12,
                            ),
                            Text(
                                'Available :$freeSlots'
                            ),
                            SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )

      ),
    ),

    );

