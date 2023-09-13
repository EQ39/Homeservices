import 'package:get/get.dart';
import 'package:homeservice/app/backend/api/handler.dart';
import 'package:homeservice/app/backend/model/category_model.dart';
import 'package:homeservice/app/backend/parse/category_parse.dart';
import 'package:homeservice/app/controller/services_controller.dart';
import 'package:homeservice/app/helper/router.dart';

class CategoryController extends GetxController implements GetxService {
  final CategoryParser parser;

  bool apiCalled = false;

  List<CategoryModel> _categoryList = <CategoryModel>[];
  List<CategoryModel> get categoryList => _categoryList;
  CategoryController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  Future<void> getAllCategories() async {
    var response = await parser.getAllCategories();
    apiCalled = true;

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      var body = myMap['data'];
      _categoryList = [];
      body.forEach((element) {
        CategoryModel datas = CategoryModel.fromJson(element);
        _categoryList.add(datas);
      });
    } else {
      ApiChecker.checkApi(response);
    }

    update();
  }

  void onFreelancerList(int id, String name) {
    Get.delete<ServicesController>(force: true);
    Get.toNamed(
      AppRouter.getServicesRoute(),
      arguments: [id, name],
    );
  }
}
