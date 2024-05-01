import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../resources/app_colors.dart';
import '../resources/text_styles.dart';

class CustomListTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget leading;
  final Widget trailing;

  const CustomListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.leading,
    required this.trailing,
  }) : super(key: key);

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);

    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
         widget.leading,
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    widget.   title,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.ModernEra(
                      AppColors.mainPurpleColor,
                      10.sp,
                      FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  widget. subtitle,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.ModernEra(
                    AppColors.mainPurpleColor,
                    10.sp,
                    FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 50),
          InkWell(
            onTap: () {
              // handle onTap here
              print('Delete');
            },
            child:widget. trailing,
          ),
        ],
      ),
    );
  }
}

