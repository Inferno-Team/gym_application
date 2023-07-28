import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gym_application/models/check_if_user_subscribed_model.dart';
import 'package:gym_application/models/data_response.dart';
import 'package:gym_application/models/diet_item.dart';
import 'package:gym_application/models/diet_model.dart';
import 'package:gym_application/models/response.dart' as res;
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/ui/home/home_viewmodel.dart';
import 'package:gym_application/utils/storage_helper.dart';

class DietViewModel extends GetxController {
  final DataService dataService;
  final StorageHelper helper;

  DietViewModel({required this.dataService, required this.helper});

  final _isLoading = true.obs;
  final _selectedDietModel = DietModel.empty().obs;

  bool get isLoading => _isLoading.value;

  final _isUserSubscribedToSelectedDiet =
      DataResponse<CheckIfSub>.empty(data: CheckIfSub.empty()).obs;

  bool get isUserSubscribed =>
      _isUserSubscribedToSelectedDiet.value.data?.value ?? false;

  DietModel get selectedDietModel => _selectedDietModel.value;

  setSelectedDietModel(DietModel model) async {
    _selectedDietModel.value = model;
    // _selectedDietModel.value = model;
    _isLoading.value = true;
    String token = helper.getToken();
    final response = await dataService.getDietItems(token, model.id);
    _isLoading.value = false;
    if (response.code == 200) {
      final res = response as DataResponse<List<DietItem>>;
      _items.value = res.data ?? [];
      Get.find<HomeController>().changeCurrentRoute('diet');
      await checkIfUserSubscribed();
    }
  }

  final _items = List<DietItem>.empty().obs;

  List<DietItem> get items => _items;

  checkIfUserSubscribed() async {
    String token = helper.getToken();

    var response = await dataService.checkIfUserSubscribed(
        token, selectedDietModel.id, true);
    if (response.code == 200) {
      _isUserSubscribedToSelectedDiet.value =
          response as DataResponse<CheckIfSub>;
    }
  }

  void onSubscribeClick() async {
    String token = helper.getToken();
    // check sub status
    res.Response response;
    if (isUserSubscribed) {
      response = await dataService.customerUnSubscribeToDiet(
          token, selectedDietModel.id);
      _isUserSubscribedToSelectedDiet.value =
          DataResponse(code: 200, data: CheckIfSub(value: false), msg: '');
    } else {
      response = await dataService.customerSubscribeToDiet(
          token, selectedDietModel.id);
      _isUserSubscribedToSelectedDiet.value =
          DataResponse(code: 200, data: CheckIfSub(value: true), msg: '');
    }

    Fluttertoast.showToast(msg: response.msg);
  }
}
