class SalaryModel {
  final String? id;
  final String? fullname;
  final String? role;
  final String? standardwd;
  final String? actualwd;
  final String? basicsalary;
  final String? paybywd;
  final String? monthlysalarybywd;
  final String? monthlysalaryoff;
  final String? support;
  final String? totalallowance;
  final String? advance;
  final String? discipline;
  final String? total;
  final String? responsibility;

  SalaryModel({
    this.id,
    this.fullname,
    this.role,
    this.standardwd,
    this.actualwd,
    this.basicsalary,
    this.paybywd,
    this.monthlysalarybywd,
    this.monthlysalaryoff,
    this.support,
    this.totalallowance,
    this.advance,
    this.discipline,
    this.total,
    this.responsibility
  });

  factory SalaryModel.fromJson(Map<String, dynamic> json) {
    return SalaryModel(
      id: json['id'],
      fullname: json['fullname'],
      role: json['role'],
      standardwd: json['standardwd'],
      actualwd: json['actualwd'],
      basicsalary: json['basicsalary'],
      paybywd: json['paybywd'],
      monthlysalarybywd: json['monthlysalarybywd'],
      monthlysalaryoff: json['monthlysalaryoff'],
      support: json['support'],
      totalallowance: json['totalallowance'],
      advance: json['advance'],
      discipline: json['discipline'],
      total: json['total'],
      responsibility: json['responsibility']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'role': role,
      'standardwd': standardwd,
      'actualwd': actualwd,
      'basicsalary': basicsalary,
      'paybywd': paybywd,
      'monthlysalarybywd': monthlysalarybywd,
      'monthlysalaryoff': monthlysalaryoff,
      'support': support,
      'totalallowance': totalallowance,
      'advance': advance,
      'discipline': discipline,
      'total': total,
      'responsibility': responsibility
    };
  }

  Map<String, String> toMap() {
    return {
      "Họ và tên": ?fullname,
      "Chức vụ": ?role,
      "Ngày công tiêu chuẩn": ?standardwd,
      "Ngày công thực tế": ?actualwd,
      "Lương cơ bản": ?basicsalary,
      "Lương theo ngày công": ?paybywd,
      "Lương tháng theo ngày công": ?monthlysalarybywd,
      "Lương tháng nghỉ": ?monthlysalaryoff,
      "Hỗ trợ": ?support,
      "Tổng phụ cấp": ?totalallowance,
      "Tạm ứng": ?advance,
      "Kỷ luật": ?discipline,
      "Tổng": ?total,
      "Trách nhiệm": ?responsibility,
    };
  }
}

