class LoginResponse {
  final String message;
  final String homePage;
  final String fullName;
  final KeyDetails keyDetails;
  final List<UserDetails> userDetails;

  LoginResponse({
    required this.message,
    required this.homePage,
    required this.fullName,
    required this.keyDetails,
    required this.userDetails,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      homePage: json['home_page'],
      fullName: json['full_name'],
      keyDetails: KeyDetails.fromJson(json['key_details']),
      userDetails: (json['user_details'] as List)
          .map((data) => UserDetails.fromJson(data))
          .toList(),
    );
  }
}

class KeyDetails {
  final String apiSecret;
  final String apiKey;

  KeyDetails({
    required this.apiSecret,
    required this.apiKey,
  });

  factory KeyDetails.fromJson(Map<String, dynamic> json) {
    return KeyDetails(
      apiSecret: json['api_secret'],
      apiKey: json['api_key'],
    );
  }
}

class UserDetails {
  final String name;
  final String firstName;
  final String? lastName;
  final String email;
  final String? mobileNo;
  final String? gender;
  final String? roleProfileName;

  UserDetails({
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.mobileNo,
    this.gender,
    this.roleProfileName,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      name: json['name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      mobileNo: json['mobile_no'],
      gender: json['gender'],
      roleProfileName: json['role_profile_name'],
    );
  }
}
