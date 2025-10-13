import 'package:flutter/material.dart';
import '../../../../core/components/button/text_button_component.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class FilterButtonRowComponent extends StatefulWidget {
  final List<String> filters; // danh sách nút
  final String? initialValue; // giá trị khởi tạo
  final String? prefixText; // tiêu đề trước các nút
  final void Function(String)? onChanged; // callback khi chọn nút mới

  const FilterButtonRowComponent({
    super.key,
    required this.filters,
    this.initialValue,
    this.prefixText,
    this.onChanged,
  });

  @override
  State<FilterButtonRowComponent> createState() =>
      _FilterButtonRowComponentState();
}

class _FilterButtonRowComponentState extends State<FilterButtonRowComponent>
    with SingleTickerProviderStateMixin {
  late String _selectedFilter;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialValue ?? widget.filters.first;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.9,
      upperBound: 1.0,
    );
  }

  void _onSelect(String value) async {
    if (_selectedFilter == value) return;
    await _controller.reverse(); // thu nhỏ nhẹ
    setState(() {
      _selectedFilter = value;
    });
    await _controller.forward(); // scale lên lại
    widget.onChanged?.call(value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.prefixText!=null?Text(widget.prefixText!, style: AppTypography.smallbody()):SizedBox.shrink(),
          const SizedBox(width: 8),
          ...widget.filters.map((filter) {
            final bool isSelected = _selectedFilter == filter;

            return Padding(
              padding: const EdgeInsets.only(right: 5),
              child: AnimatedScale(
                scale: isSelected ? 1.0 : 0.95,
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOut,
                child: AnimatedOpacity(
                  opacity: isSelected ? 1 : 0.7,
                  duration: const Duration(milliseconds: 150),
                  child: TextButtonComponent(
                    title: filter,
                    height: 25,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.background,
                    onPressed: () => _onSelect(filter),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
