import 'package:amazon_clone/model/user_models.dart';
import 'package:amazon_clone/resources/cloudfirestore_class.dart';
import 'package:flutter/cupertino.dart';

class UserDetailsProvider with ChangeNotifier {
  late UserDetailsModel userDtails;
  UserDetailsProvider()
      : userDtails = UserDetailsModel(
            name: "loading..", email: "loading..", address: "loading..");

  Future<void> getData() async {
    userDtails = await CloudFirestoreClass().getNameAndAddress();
    notifyListeners();
  }
}
