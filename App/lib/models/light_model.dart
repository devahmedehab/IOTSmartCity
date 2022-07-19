class LightModel {
  bool status;
  String message;
  Data data;

  LightModel({this.status, this.message, this.data});

  LightModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int led1;
  int led2;
  int led3;
  int led4;
  int led5;
  int led6;

  Data({this.led1, this.led2, this.led3, this.led4});

  Data.fromJson(Map<String, dynamic> json) {
    led1 = json['led1'];
    led2 = json['led2'];
    led3 = json['led3'];
    led4 = json['led4'];
    led5 = json['led5'];
    led6 = json['led6'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['led1'] = this.led1;
    data['led2'] = this.led2;
    data['led3'] = this.led3;
    data['led4'] = this.led4;
    data['led5'] = this.led5;
    data['led6'] = this.led6;
    return data;
  }
}