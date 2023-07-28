import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_application/models/check_if_user_subscribed_model.dart';
import 'package:gym_application/models/data_response.dart';
import 'package:gym_application/models/diet_item.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/ui/home/home_viewmodel.dart';
import 'package:gym_application/utils/constances.dart';
import 'package:gym_application/utils/storage_helper.dart';
import 'package:gym_application/models/diet_model.dart';

class MyDietsViewModel extends GetxController {
  final DataService dataService;
  final StorageHelper helper;
  final _isLoading = true.obs;
  final _isUserSubscribedToSelectedDiet =
      DataResponse<CheckIfSub>.empty(data: CheckIfSub.empty()).obs;
  final _response = DataResponse<List<DietModel>>.empty().obs;
  final _selectedDietModel = DietModel.empty().obs;
  final _items = List<DietItem>.empty().obs;

  List<DietItem> get items => _items;

  DataResponse<List<DietModel>> get response => _response.value;

  bool get isLoading => _isLoading.value;

  bool get isUserSubscribed =>
      _isUserSubscribedToSelectedDiet.value.data?.value ?? false;

  DietModel get selectedDietModel => _selectedDietModel.value;

  MyDietsViewModel({required this.dataService, required this.helper});

  @override
  void onInit() async {
    String token = helper.getToken();
    _isLoading.value = true;
    var response = await dataService.getMyDiets(token);
    _isLoading.value = false;
    if (response.code == 200) {
      _response.value = response as DataResponse<List<DietModel>>;
    }
    super.onInit();
  }

  checkIfUserSubscribed() async {
    String token = helper.getToken();

    var response = await dataService.checkIfUserSubscribed(
        token, selectedDietModel.id, true);
    if (response.code == 200) {
      _isUserSubscribedToSelectedDiet.value =
          response as DataResponse<CheckIfSub>;
    }
  }

  gotoDietPage(DietModel model) async {
    // get all diet items
    String token = helper.getToken();
    _isLoading.value = true;
    _selectedDietModel.value = model;
    final response = await dataService.getDietItems(token, model.id);
    _isLoading.value = false;
    if (response.code == 200) {
      final res = response as DataResponse<List<DietItem>>;
      _items.value = res.data ?? [];
      Get.find<HomeController>().changeCurrentRoute('diet');
      Get.toNamed(PagesRouteConst.oneDietPageRoute,
          id: 1, arguments: {'selectedDietModel': selectedDietModel});
      await checkIfUserSubscribed();
    }
  }

  void onSubscribeClick() async {
    String token = helper.getToken();
    var response =
        await dataService.customerSubscribeToDiet(token, selectedDietModel.id);
    Fluttertoast.showToast(msg: response.msg);
    _isUserSubscribedToSelectedDiet.value =
        DataResponse(code: 200, data: CheckIfSub(value: true), msg: '');
  }
}
