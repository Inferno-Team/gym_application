import 'package:get/get.dart';
import 'package:gym_application/models/data_response.dart';
import 'package:gym_application/models/my_sub_model.dart';
import 'package:gym_application/models/user_subscription.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/utils/storage_helper.dart';
import 'package:gym_application/models/response.dart' as res;

class MySubViewModel extends GetxController {
  final DataService dataService;
  final StorageHelper helper;

  MySubViewModel({required this.dataService, required this.helper});

  final subs = DataResponse<List<MySubModel>>.empty().obs;

  @override
  void onInit() async {
    String token = helper.getToken();
    res.Response data = await dataService.getMySubs(token);
    if (data.code == 200) {
      subs.value = data as DataResponse<List<MySubModel>>;
    }
    super.onInit();
  }
}
