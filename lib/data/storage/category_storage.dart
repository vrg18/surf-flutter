import 'package:places/data/res/mocks.dart';
import 'package:places/domain/category.dart';

/// Получение из БД и запись в БД категорий
class CategoryStorage {
  List<Category> initialFillingOfListOfCategories() {
    return List<Category>.from(mockCategories); // todo будет заменено данными из базы
  }
}
