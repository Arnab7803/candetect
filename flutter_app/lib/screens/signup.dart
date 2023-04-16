import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gfgprojects/models/user.dart';
import 'package:gfgprojects/repo/user_repo.dart';
import 'signin.dart';
import '../functions/auth_functions.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  DateTime? _selectedDate = DateTime.now();
  String? _selectedOption;
  final _formKey = GlobalKey<FormState>();
  final _fname = TextEditingController();
  final _lname = TextEditingController();
  final _dob = TextEditingController();
  final _gender = FocusNode();

  String email = '';
  String password = '';
  String firstname = '';
  String lastname = '';
  String ageGroup = '';

  int maleCount = 0;
  int femaleCount = 0;
  int nonBinaryCount = 0;
  late int age;

  final userRepo = Get.put(UserRepo());

  void createUser(User user) {
    userRepo.createUser(user);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    ) as DateTime;
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void genderCount(String gender) {
    if (gender == 'MALE') {
      maleCount++;
    } else if (gender == 'FEMALE') {
      femaleCount++;
    } else {
      nonBinaryCount++;
    }
  }

  void ageCal(DateTime dateOfBirth) {
    DateTime today = DateTime.now();

    age = today.year - dateOfBirth.year;
    if (today.month < dateOfBirth.month ||
        (today.month == dateOfBirth.month && today.day < dateOfBirth.day)) {
      age--;
    }
  }

  void ageGrp(int age) {
    if (age <= 25) {
      ageGroup = '0-25';
    } else if (age > 25 && age <= 60) {
      ageGroup = '25-60';
    } else {
      ageGroup = '>60';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.tealAccent,
                Colors.yellowAccent,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create New Account",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "First Name",
                  labelStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.white.withOpacity(0.3),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                onFieldSubmitted: (_) {},
                onSaved: ((newValue) {}),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Last Name",
                  labelStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.white.withOpacity(0.3),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                onFieldSubmitted: (_) {},
                onSaved: ((newValue) {}),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.white.withOpacity(0.3),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.white.withOpacity(0.3),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                    ageCal(_selectedDate!);
                  },
                  decoration: InputDecoration(
                    hintText: 'Date of birth',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  controller: TextEditingController(
                    text: _selectedDate == null
                        ? ''
                        : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                  ),
                  onFieldSubmitted: (_) {},
                  onSaved: ((newValue) {}),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Gender',
                    ),
                    value: _selectedOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedOption = newValue;
                      });
                    },
                    items: [
                      DropdownMenuItem<String>(
                        value: '1',
                        child: Text('MALE'),
                      ),
                      DropdownMenuItem<String>(
                        value: '2',
                        child: Text('FEMALE'),
                      ),
                      DropdownMenuItem<String>(
                        value: '3',
                        child: Text('NON-BINARY'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    AuthServices.signupUser(
                        email, password, firstname, lastname, context);
                    genderCount(_selectedOption!);
                    Navigator.pushNamed(context, SignInPage.routeName);
                  }
                },
                child: Center(
                  child: Text(
                    "Create account",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(15),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          child: Image.network(
                              'https://cdn-icons-png.flaticon.com/512/2991/2991148.png'),
                        ),
                        Center(
                          child: Text(
                            "Google",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, SignInPage.routeName);
                },
                child: Text(
                  "Already An User ? Sign In",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
