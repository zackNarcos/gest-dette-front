import 'package:d_liv/shared/constants/keys.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class StorageData extends GetxService {
  late GetStorage _db;
 
  //Storage en local ==> get_storage
  //Init Storage
  Future<StorageData> init() async {
    _db = GetStorage();
     await _db.writeIfNull(keyToken, '');
     await _db.writeIfNull(keyUser, '');
    return this;
  }
  //read
   T read<T>(String key){
       return _db.read(key);
   }
  //Write
   void  write(String key, dynamic value)async {
      final dynamic result = await _db.read(key);
      if(result != value){
        await _db.write(key, value);
      }

      // await _db.writeIfNull(key, value);
   }
  }
