class InfaqModel {
  final int? id;
  final String? donorName;
  final String? donorEmail;
  final String? donorPhone;
  final double? amount;
  final String? status;
  final bool? isAnonymous;
  final String? type;

  InfaqModel({
    this.id,
    this.donorName,
    this.donorEmail,
    this.donorPhone,
    this.amount,
    this.status,
    this.isAnonymous,
    this.type,
  });

  String get displayName =>
      isAnonymous == true ? 'Hamba Allah' : (donorName ?? '-');

  factory InfaqModel.fromJson(Map<String, dynamic> json) {
    return InfaqModel(
      id: json['id'],
      donorName: json['donor_name'],
      donorEmail: json['donor_email'],
      donorPhone: json['donor_phone'],
      amount: json['amount'],
      status: json['status'],
      isAnonymous: json['is_anonymous'] == 1 || json['is_anonymous'] == true,
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'donor_name': donorName,
        'donor_email': donorEmail,
        'donor_phone': donorPhone,
        'amount': amount,
        'status': status,
        'is_anonymous': isAnonymous,
        'type': type,
      };
}
