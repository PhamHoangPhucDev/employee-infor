// import 'package:flutter/material.dart';
// import 'package:hugeicons/hugeicons.dart';
// import 'package:sizer/sizer.dart';

// import '../../../../core/theme/app_colors.dart';

// class CategoryListItem extends StatefulWidget {
//   final List<List<List<dynamic>>> icons;
//   final Function(int)? onItemSelected;

//   const CategoryListItem({
//     super.key,
//     required this.icons,
//     this.onItemSelected,
//   });

//   @override
//   State<CategoryListItem> createState() => _CategoryListItem();
// }

// class _CategoryListItem extends State<CategoryListItem> {
//   final ScrollController _scrollController = ScrollController();
//   bool _atStart = true;
//   bool _atEnd = false;

//   int selectedIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollController.addListener(_checkScroll);
//     });
//   }

//   void _checkScroll() {
//     if (!_scrollController.hasClients) return;
//     setState(() {
//       _atStart = _scrollController.offset <= 0;
//       _atEnd = _scrollController.offset >= _scrollController.position.maxScrollExtent;
//     });
//   }

//   void _scrollLeft() {
//     if (!_scrollController.hasClients) return;
//     _scrollController.animateTo(
//       (_scrollController.offset - 200).clamp(0, _scrollController.position.maxScrollExtent),
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeOut,
//     );
//   }

//   void _scrollRight() {
//     if (!_scrollController.hasClients) return;
//     _scrollController.animateTo(
//       (_scrollController.offset + 200).clamp(0, _scrollController.position.maxScrollExtent),
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         // Nút trái
//         if (!_atStart)
//           SizedBox(
//             width: 5.w,
//             child: InkWell(
//               onTap: _scrollLeft,
//               child: HugeIcon(
//                 icon: HugeIcons.strokeRoundedArrowLeft01,
//                 size: 20.sp,
//                 color: AppColors.primary,
//               ),
//             ),
//           )
//         else
//           SizedBox(width: 5.w),

//         // List icons
//         Expanded(
//           child: SizedBox(
//             height: 15.w,
//             child: ListView.builder(
//               controller: _scrollController,
//               scrollDirection: Axis.horizontal,
//               itemCount: widget.icons.length,
//               itemBuilder: (context, index) {
//                 bool isSelected = selectedIndex == index;

//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedIndex = index;
//                     });
//                     if (widget.onItemSelected != null) {
//                       widget.onItemSelected!(index);
//                     }
//                   },
//                   child: Container(
//                     width: 15.w,
//                     margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: isSelected ? AppColors.background : AppColors.primary,
//                       border: Border.all(color: isSelected ?AppColors.primary:AppColors.background, width: 1),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         HugeIcon(
//                           icon: widget.icons[index],
//                           size: 20.sp,
//                           color: isSelected ? AppColors.primary : AppColors.textLight,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),

//         // Nút phải
//         if (!_atEnd)
//           SizedBox(
//             width: 5.w,
//             child: InkWell(
//               onTap: _scrollRight,
//               child: HugeIcon(
//                 icon: HugeIcons.strokeRoundedArrowRight01,
//                 size: 20.sp,
//                 color: AppColors.primary,
//               ),
//             ),
//           )
//         else
//           SizedBox(width: 5.w),
//       ],
//     );
//   }
// }
