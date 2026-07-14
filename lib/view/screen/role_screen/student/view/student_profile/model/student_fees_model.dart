class StudentFeesModel {
  final String id;
  final num paidAmount;
  final num unpaidAmount;
  final String paymentMethod;
  final String paymentStatus;
  final String createdAt;
  final String updatedAt;
  final FeesManagement feesManagement;
  final List<PaymentHistory> paymentHistory;

  StudentFeesModel({
    required this.id,
    required this.paidAmount,
    required this.unpaidAmount,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.feesManagement,
    required this.paymentHistory,
  });

  factory StudentFeesModel.fromJson(Map<String, dynamic> json) {
    return StudentFeesModel(
      id: json['id'] ?? '',
      paidAmount: json['paidAmount'] ?? 0,
      unpaidAmount: json['unpaidAmount'] ?? 0,
      paymentMethod: json['paymentMethod'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      feesManagement: FeesManagement.fromJson(json['feesManagement'] ?? {}),
      paymentHistory: (json['paymentHistory'] as List?)
              ?.map((e) => PaymentHistory.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class FeesManagement {
  final String id;
  final num totalFees;
  final String classLevel;

  FeesManagement({
    required this.id,
    required this.totalFees,
    required this.classLevel,
  });

  factory FeesManagement.fromJson(Map<String, dynamic> json) {
    return FeesManagement(
      id: json['id'] ?? '',
      totalFees: json['totalFees'] ?? 0,
      classLevel: json['classLevel'] ?? '',
    );
  }
}

class PaymentHistory {
  final String id;
  final num amount;
  final String createdAt;

  PaymentHistory({
    required this.id,
    required this.amount,
    required this.createdAt,
  });

  factory PaymentHistory.fromJson(Map<String, dynamic> json) {
    return PaymentHistory(
      id: json['id'] ?? '',
      amount: json['amount'] ?? 0,
      createdAt: json['createdAt'] ?? '',
    );
  }
}
