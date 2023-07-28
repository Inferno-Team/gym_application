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

class DietsViewModel extends GetxController {
  final DataService dataService;
  final StorageHelper helper;

  DietsViewModel({required this.dataService, required this.helper});

  final _isLoading = true.obs;
  final _response = DataResponse<List<DietModel>>.empty().obs;

  DataResponse<List<DietModel>> get response => _response.value;

  bool get isLoading => _isLoading.value;

  @override
  void onInit() async {
    String token = helper.getToken();
    _isLoading.value = true;
    var response = await dataService.getAllDiets(token);
    _isLoading.value = false;
    if (response.code == 200) {
      _response.value = response as DataResponse<List<DietModel>>;
    }
    super.onInit();
  }

  gotoDietPage(DietModel model)  {
    Get.toNamed(PagesRouteConst.oneDietPageRoute,
        id: 1, arguments: {'selectedDietModel': model});
  }
}
