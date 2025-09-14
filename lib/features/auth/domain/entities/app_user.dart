class AppUser {
  final String uid;
  final String email;
  final String name;

  // Constructor that asks some parameters:
  AppUser({
    required this.uid,
    required this.email,
    required this.name,
  });

  // Convert JSON -> AppUser
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
    );
  }

  // Convert AppUser -> JSON
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }
}
