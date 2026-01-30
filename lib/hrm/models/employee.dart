class Employee {
  final String id;
  final String firstName;
  final String lastName;
  final String gender;
  final DateTime dateOfBirth;
  final String mobileNumber;
  final String email;
  final String address;
  final DateTime joiningDate;
  final String employmentType; // Permanent / Contract / Intern
  final String status; // Active / Inactive
  final String? profilePhoto;

  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dateOfBirth,
    required this.mobileNumber,
    required this.email,
    required this.address,
    required this.joiningDate,
    required this.employmentType,
    required this.status,
    this.profilePhoto,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as String,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      mobileNumber: json['mobileNumber'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      joiningDate: DateTime.parse(json['joiningDate'] as String),
      employmentType: json['employmentType'] as String,
      status: json['status'] as String,
      profilePhoto: json['profilePhoto'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'mobileNumber': mobileNumber,
      'email': email,
      'address': address,
      'joiningDate': joiningDate.toIso8601String(),
      'employmentType': employmentType,
      'status': status,
      'profilePhoto': profilePhoto,
    };
  }

  String get fullName => '$firstName $lastName';
}
