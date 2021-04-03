
class User {

  String firstName;
  String lastName;
  String email;
  String password;
  String dateOfBirth;
  String gender;
  List phones;
  List addresses;
  String photo;

	User.fromJsonMap(Map<String, dynamic> map): 
		firstName = map["firstName"],
		lastName = map["lastName"],
		email = map["email"],
		password = map["password"],
		dateOfBirth = map["dateOfBirth"],
		gender = map["gender"],
		phones = map["phones"],
		addresses = map["addresses"],
		photo = map["photo"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['firstName'] = firstName;
		data['lastName'] = lastName;
		data['email'] = email;
		data['password'] = password;
		data['dateOfBirth'] = dateOfBirth;
		data['gender'] = gender;
		data['phones'] = phones;
		data['addresses'] = addresses;
		data['photo'] = photo;
		return data;
	}
}
