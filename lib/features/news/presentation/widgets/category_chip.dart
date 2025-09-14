import 'package:flutter/material.dart';
import '../../../../../shared/helpers/ui_helpers.dart';
import '../../domain/entities/news_category_entity.dart';

class NewsCategoryFilter extends StatelessWidget {
  final List<NewsCategoryEntity> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const NewsCategoryFilter({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => UIHelpers.addHorizontalSpace(12),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category.id;

          return GestureDetector(
            onTap: () => onCategorySelected(category.id),
            child: NewsCategoryChip(
              category: category,
              isSelected: isSelected,
            ),
          );
        },
      ),
    );
  }
}

class NewsCategoryChip extends StatelessWidget {
  final NewsCategoryEntity category;
  final bool isSelected;

  const NewsCategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse("0xff${category.color}"));

    return Material(
      color: isSelected ? color : Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(20),
      elevation: isSelected ? 2 : 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: isSelected
              ? null
              : Border.all(
                  color:
                      Theme.of(context).colorScheme.outline.withOpacity(0.3),
                ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          category.name,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}
