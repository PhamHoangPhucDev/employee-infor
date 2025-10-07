import 'package:flutter/material.dart';

import '../../../core/components/appBar_component.dart';
import '../../../core/constants/app_strings.dart';
import 'widgets/item_notification.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  var list = [
    {
      "timeTitle":"Hôm nay",
      "listNotification": [
        {
          "title":"Thông báo hệ thống",
          "subtitle":"Tài khoản của bạn vừa được đăng nhập trên thiết bị mới. Nếu không phải bạn hãy đổi mật khẩu ngay.",
          "time":"2h"
        },
        {
          "title":"Khuyến mãi",
          "subtitle":"Nhận ngay ưu đãi giảm 50% cho lần mua hàng tiếp theo trong tuần này.",
          "time":"3h"
        },
        {
          "title":"Lịch họp",
          "subtitle":"Cuộc họp với phòng kỹ thuật được dời sang 15h chiều nay tại phòng họp A2.",
          "time":"1d"
        },
      ]
    },
    {
      "timeTitle":"Hôm qua",
      "listNotification": [
        {
          "title":"Cập nhật ứng dụng",
          "subtitle":"Phiên bản mới đã có sẵn, vui lòng cập nhật để trải nghiệm các tính năng mới và cải thiện hiệu suất.",
          "time":"1d2h"
        },
      ]
    },
    {
      "timeTitle":"Ngày 15/09",
      "listNotification": [
        {
          "title":"Thông báo hôm nay 01",
          "subtitle":"",
          "time":"2H"
        },
        {
          "title":"Thông báo hôm nay 02",
          "subtitle":"",
          "time":"3D"
        },
        {
          "title":"Thông báo hôm nay 03",
          "subtitle":"",
          "time":"5D"
        },
      ]
    },
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: AppStrings.notificationTitle,),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];
            print(item['listNotification'] as List<Map<String,dynamic>>);
            return ItemNotification(
              title:  item['timeTitle'] as String,
              listNotification: item['listNotification'] as List<Map<String,dynamic>>,
            );
          },
        )
      ),
    );
  }
}