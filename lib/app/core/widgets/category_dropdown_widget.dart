import 'package:flutter/material.dart';
import 'package:miplanner_v2/app/data/dto/category_dto.dart';

class CategoryDropdownWidget extends StatelessWidget {
  final List<CategoryDto> categories;
  final int? selectedCategoryId;
  final ValueChanged<int?> onChanged;
  final String label;

  const CategoryDropdownWidget({
    super.key,
    required this.categories,
    required this.onChanged,
    this.selectedCategoryId,
    this.label = 'Categoría',
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int?>(
      initialValue: selectedCategoryId,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
      ),
      items: [
        const DropdownMenuItem<int?>(
          value: null,
          child: _CategoryItem(
            color: Colors.transparent,
            name: 'Sin categoría',
            showBorder: true,
          ),
        ),
        ...categories.map(
          (dto) => DropdownMenuItem<int?>(
            value: dto.model.id,
            child: _CategoryItem(
              color: Color(dto.model.color),
              name: dto.model.name,
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Color color;
  final String name;
  final bool showBorder;

  const _CategoryItem({
    required this.color,
    required this.name,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: showBorder ? Colors.transparent : color,
            border: showBorder
                ? Border.all(
                    color: colors.onSurface.withValues(alpha: 0.4),
                    width: 1.5,
                  )
                : null,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          name,
          style: showBorder
              ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.6),
                  )
              : null,
        ),
      ],
    );
  }
}
