import 'package:bitflow_web/getx/store_get.dart';
import 'package:bitflow_web/service/aria.dart';
import 'package:bitflow_web/service/qbit.dart';
import 'package:bitflow_web/service/trans.dart';
import 'package:get/get.dart';

enum StoreType{
  aria,
  qbit,
  transmission
}

class StoreItem{
  late String name;
  late StoreType type;
  late String url;
  // Aria中没有username参数
  late String? username;
  late String password;
  StoreItem(this.name, this.type, this.url, this.username, this.password);

  final AriaService ariaService=Get.find();
  final QbitService qbitService=Get.find();
  final StoreGet storeGet=Get.find();
  final TransmissionService transmissionService=Get.find();

  Map toMap(){
    return {
      "name": name,
      "type": type.index,
      "url": url,
      "username": username??"",
      "password": password,
    };
  }

  Future<bool> checkItem() async {
    switch (type) {
      case StoreType.aria:
        final version=await ariaService.getVersion(this);
        if(version!=null){
          return true;
        }
        return false;
      case StoreType.qbit:
        final check=await qbitService.check(this);
        if(check){
          return true;
        }
        return false;
      case StoreType.transmission:
        final check=await transmissionService.check(this);
        if(check){
          return true;
        }
        return false;
    }
  }
}