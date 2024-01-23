class SellerUserModel {
  final bool? approved;
  final String? sellerId;
  final String? businessName;
  final String? cityValue;
  final String? countryValue;
  final String? email;
  final String? phoneNumber;
  final String? stateValue;
  final String? taxNumber;
  final String? taxRegistered;

  SellerUserModel({
    required this.approved,
    required this.sellerId,
    required this.businessName,
    required this.cityValue,
    required this.countryValue,
    required this.email,
    required this.phoneNumber,
    required this.stateValue,
    required this.taxNumber,
    required this.taxRegistered,
  });

  SellerUserModel.fromJson(Map<String, Object?> json)
      : this(
          approved: json['approved']! as bool,
          sellerId: json['sellerId']! as String,
          businessName: json['businessName']! as String,
          cityValue: json['cityValue']! as String,
          countryValue: json['countryValue']! as String,
          email: json['email']! as String,
          phoneNumber: json['phoneNumber']! as String,
          stateValue: json['stateValue']! as String,
          taxNumber: json['taxNumber']! as String,
          taxRegistered: json['taxRegistered']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'approved': approved,
      'sellerId': sellerId,
      'businessName': businessName,
      'cityValue': cityValue,
      'countryValue': countryValue,
      'email': email,
      'phoneNumber': phoneNumber,
      'stateValue': stateValue,
      'taxNumber': taxNumber,
      'taxRegistered': taxRegistered,
    };
  }
}
