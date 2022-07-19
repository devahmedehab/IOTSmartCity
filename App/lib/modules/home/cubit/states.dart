import 'package:smart_city/models/home_model.dart';
import 'package:smart_city/models/light_model.dart';
import 'package:smart_city/models/pass_model.dart';

abstract class HomeStates {}
class HomeInitialState extends HomeStates{}

class ParkingLoadingHomeState extends HomeStates{}

class ParkingSuccessHomeState extends HomeStates{
  final HomeModel homeModel;

  ParkingSuccessHomeState(this.homeModel);
}

class ParkingErrorHomeState extends HomeStates {
  final String error;

  ParkingErrorHomeState(this.error);
}

class HomeGetLoadingLightsState extends HomeStates{}

class HomeGetSuccessLightsState extends HomeStates{
  final LightModel lightsModel;

  HomeGetSuccessLightsState(this.lightsModel);
}

class HomeGetErrorLightsState extends HomeStates {
  final String error;

  HomeGetErrorLightsState(this.error);

}

class HomePostLoadingLightsState extends HomeStates{}

class HomePostSuccessLightsState extends HomeStates{
  final LightModel lightModel;

  HomePostSuccessLightsState(this.lightModel);
}

class HomePostErrorLightsState extends HomeStates {
  final String error;

  HomePostErrorLightsState(this.error);

}
class HomePostLoadingPassState extends HomeStates{}

class HomePostSuccessPassState extends HomeStates{
  final PassModel passModel;

  HomePostSuccessPassState(this.passModel);
}

class HomePostErrorPassState extends HomeStates {
  final String error;

  HomePostErrorPassState(this.error);

}

class AppChangeBottomSheetState extends HomeStates{}

class AppChangeModeState extends HomeStates{}

class AppChangeLight1State extends HomeStates{}
class AppChangeLight2State extends HomeStates{}
class AppChangeLight3State extends HomeStates{}
class AppChangeLight4State extends HomeStates{}
class AppChangeLight5State extends HomeStates{}
class AppChangeLight6State extends HomeStates{}
