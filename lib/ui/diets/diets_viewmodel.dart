import 'package:get/get.dart';
import 'package:gym_application/models/data_response.dart';
import 'package:gym_application/repositories/data_service.dart';
import 'package:gym_application/utils/storage_helper.dart';
import 'package:gym_application/models/diet_model.dart';

class DietsViewModel extends GetxController {
  final DataService dataService;
  final StorageHelper helper;
  final _response = DataResponse<List<DietModel>>.empty().obs;

  DataResponse<List<DietModel>> get response => _response.value;

  DietsViewModel({required this.dataService, required this.helper});

  @override
  void onInit() async {
    String token = helper.getToken();
    var response = await dataService.getAllDiets(token);
    if (response.code == 200) {
      _response.value = response as DataResponse<List<DietModel>>;
    }
    super.onInit();
  }
}
