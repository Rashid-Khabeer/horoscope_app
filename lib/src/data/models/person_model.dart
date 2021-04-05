class Person {
  String id, email, password;
  bool hasPaid;

  Person({
    this.email,
    this.id,
    this.password,
    this.hasPaid,
  });

  Person.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    id = json['password'];
    hasPaid = json['hasPaid'];
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'hasPaid': hasPaid,
    };
  }
}
