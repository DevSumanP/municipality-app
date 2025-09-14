import 'package:municipality_app/core/extensions/strings_extensions.dart';
import 'package:municipality_app/features/services/domain/entities/service_entity.dart';

class FilterServiceUsecase {
  List<ServiceEntity> call({
    required List<ServiceEntity> services,
    required String searchQuery,
    required String selectedCategory,
  }) {
    return services.where((service) {
      final matchesSearch = service.title.containsIgnoreCase(searchQuery) ||
          service.description.containsIgnoreCase(searchQuery);
      final matchesCategory =
          selectedCategory == 'all' || service.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }
}
