import 'package:get/get.dart';

import '../../data/models/salary_model.dart';

class SalaryController extends GetxController {
  /// Tháng đang được chọn
  final Rx<DateTime> selectedMonth = DateTime.now().obs;

  final SalaryModel salary = SalaryModel(
    id: "1",
    fullname: "Lucy",
    role: "CEO",
    standardwd: "22",
    actualwd: "20.5",
    basicsalary: "70.000.000",
    paybywd: "3.181.818",
    monthlysalarybywd: "65.227.269",
    monthlysalaryoff: "65.227.269",
    support: "200.000",
    totalallowance: "400.000",
    advance: "1.000.000",
    discipline: "100.000",
    total: "1.100.000",
    responsibility: "0",
  );
}
