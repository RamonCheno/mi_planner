import 'package:get/get.dart';
import 'package:miplanner_v2/app/domain/usecases/delete_category_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/get_all_categories_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/save_category_usecase.dart';
import 'package:miplanner_v2/app/domain/usecases/update_category_usecase.dart';
import 'package:miplanner_v2/app/modules/category/controllers/category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(
      () => CategoryController(
        Get.find<GetAllCategoriesUseCase>(),
        Get.find<SaveCategoryUseCase>(),
        Get.find<UpdateCategoryUseCase>(),
        Get.find<DeleteCategoryUseCase>(),
      ),
    );
  }
}
