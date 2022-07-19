import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_city/models/home_model.dart';
import 'package:smart_city/models/light_model.dart';
import 'package:smart_city/models/pass_model.dart';
import 'package:smart_city/modules/home/cubit/states.dart';
import 'package:smart_city/shared/components/constants.dart';
import 'package:smart_city/shared/network/cache_helper.dart';
import 'package:smart_city/shared/network/dio_helper.dart';
import 'package:smart_city/shared/style/end_point.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super((HomeInitialState()));


  static HomeCubit get(context) => BlocProvider.of(context);


  bool isDark = false;

  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  HomeModel homeModel;


  Future getHomeData() async {
    emit(ParkingLoadingHomeState());

    await DioHelper.getData(
      url: degrees,
      token: token,

    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(ParkingSuccessHomeState(homeModel));
    }).catchError((error) {
      print(error.toString());
      emit(ParkingErrorHomeState(error.toString()));
    });
  }

  LightModel lightsModel;

  Future getLightsData() async {
    emit(HomeGetLoadingLightsState());

    await DioHelper.getData(
      url: lights,
      token: token,


    ).then((value) {
      lightsModel = LightModel.fromJson(value.data);

      emit(HomeGetSuccessLightsState(lightsModel));
      print(LightModel.fromJson(value.data));
      print(lightsModel.message);

      print(lightsModel.data.led1);
      print(lightsModel.data.led2);

      print(lightsModel.data.led3);
      print(lightsModel.data.led4);
      print(lightsModel.data.led5);
      print(lightsModel.data.led6);

    }).catchError((error) {
      print(error.toString());
      emit(HomeGetErrorLightsState(error.toString()));
    });
  }

  Future postLightData({
    int led1,
    int led2,
    int led3,
    int led4,
    int led5,
    int led6,


  }) async

  {
    emit(HomePostLoadingLightsState());

    // getLightsData();
    await DioHelper.postData(
      url: lights,
      token: token,
      data: {
        'led1': led1,
        'led2': led2,
        'led3': led3,
        'led4': led4,
        'led5': led5,
        'led6': led6,
      },
    ).then((value) {
      lightsModel = LightModel.fromJson(value.data);


      emit(HomePostSuccessLightsState(lightsModel));
    }).catchError((error) {
      print(error.toString());
      emit(HomePostErrorLightsState(error.toString()));
    });
  }

  bool isLighted1 = false;
  bool isLighted2 = false;
  bool isLighted3 = false;
  bool isLighted4 = false;
  bool isLighted5 = false;
  bool isLighted6 = false;


  Icon icon1 = Icon(Icons.flashlight_off_outlined, size: 60,);
  Icon icon2 = Icon(Icons.flashlight_off_outlined, size: 60,);
  Icon icon3= Icon(Icons.flashlight_off_outlined, size: 60,);
  Icon icon4= Icon(Icons.flashlight_off_outlined, size: 60,);
  Icon icon5 = Icon(Icons.flashlight_off_outlined, size: 60,);
  Icon icon6 = Icon(Icons.flashlight_off_outlined, size: 60,);


  void lightSwitch1() {
    if (isLighted1) {
      icon1 = Icon(
        Icons.flashlight_off_outlined,
        size: 60,
      );

      isLighted1 = !isLighted1;
    }
    else {
      icon1 = Icon(
        Icons.flashlight_on_outlined,
        size: 60,
      );
      isLighted1 = !isLighted1;
    }


    emit(AppChangeLight1State());
  }

  void lightSwitch2() {
    if (isLighted2) {
      icon2 = Icon(
        Icons.flashlight_off_outlined,
        size: 60,
      );

      isLighted2 = !isLighted2;
    }
    else {
      icon2 = Icon(
        Icons.flashlight_on_outlined,
        size: 60,
      );
      isLighted2 = !isLighted2;
    }


    emit(AppChangeLight2State());
  }

  void lightSwitch3() {
    if (isLighted3) {
      icon3 = Icon(
        Icons.flashlight_off_outlined,
        size: 60,
      );

      isLighted3 = !isLighted3;
    }
    else {
      icon3 = Icon(
        Icons.flashlight_on_outlined,
        size: 60,
      );
      isLighted3 = !isLighted3;
    }


    emit(AppChangeLight3State());
  }

  void lightSwitch4() {
    if (isLighted4) {
      icon4 = Icon(
        Icons.flashlight_off_outlined,
        size: 60,
      );

      isLighted4 = !isLighted4;
    }
    else {
      icon4 = Icon(
        Icons.flashlight_on_outlined,
        size: 60,
      );
      isLighted4 = !isLighted4;
    }


    emit(AppChangeLight4State());
  }

  void lightSwitch5() {
    if (isLighted5) {
      icon5 = Icon(
        Icons.flashlight_off_outlined,
        size: 60,
      );

      isLighted5 = !isLighted5;
    }
    else {
      icon5 = Icon(
        Icons.flashlight_on_outlined,
        size: 60,
      );
      isLighted5 = !isLighted5;
    }


    emit(AppChangeLight5State());
  }

  void lightSwitch6() {
    if (isLighted6) {
      icon6 = Icon(
        Icons.flashlight_off_outlined,
        size: 60,
      );

      isLighted6 = !isLighted6;
    }
    else {
      icon6 = Icon(
        Icons.flashlight_on_outlined,
        size: 60,
      );
      isLighted6 = !isLighted6;
    }


    emit(AppChangeLight6State());
  }

  PassModel passModel;


  Future postPassData({
    String pass,



  }) async

  {
    emit(HomePostLoadingPassState());


    await DioHelper.postData(
      url: password,
      token: token,
      data: {
        'password': pass,

      },
    ).then((value) {
      passModel = PassModel.fromJson(value.data);


      emit(HomePostSuccessPassState(passModel));
    }).catchError((error) {
      print(error.toString());
      emit(HomePostErrorPassState(error.toString()));
    });
  }
}