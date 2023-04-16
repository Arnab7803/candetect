class User {
  final String? fname;
  final String? lname;
  final DateTime? dob;
  final bool? gender;
  const User({this.fname, this.lname, this.dob, this.gender});

  toJson() {
    return {
      "fname": fname,
      "lname": lname,
      "age": DateTime.now().year - dob!.year,
      "gender": gender,
    };
  }
}
