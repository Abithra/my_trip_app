import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_trip_flutter_app/constant/app_colors.dart';
import 'package:my_trip_flutter_app/constant/app_textstyles.dart';
import 'package:my_trip_flutter_app/presentation/authentication/signin_screen.dart';
import '../../data/bloc/user_bloc/user_bloc.dart';
import '../../data/bloc/user_bloc/user_bloc_event.dart';
import '../../data/bloc/user_bloc/user_bloc_state.dart';
import '../../data/model/user.dart';
import '../onboarding/onboarding.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = context.read<UserBloc>();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'Name should only contain letters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
        .hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  void validateAndSignUp() {
    String? nameError = validateName(_nameController.text);
    String? emailError = validateEmail(_emailController.text);
    String? passwordError = validatePassword(_passwordController.text);

    if (nameError == null && emailError == null && passwordError == null) {
      User user = User(
        id: 0,
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

    }
  }


  void navigateToSignInScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: CircleAvatar(
            backgroundColor: AppColors.grey.shade50,
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.grey,
            ),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Onboarding()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Registration successful!"),
                    duration: Duration(seconds: 3),
                  ),
                );
                _userBloc.add(
                  SaveUserEvent(
                    name: _nameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                );
              } else if (state is UserFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Registration Unsuccessful'),
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    'Sign Up Now',
                    style: AppTextStyles.heading(),
                  ),
                ),
                SizedBox(height: height / 25),
                Text(
                  'Please fill the details and create a new account',
                  style: AppTextStyles.bodyLarge(color: AppColors.grey),
                ),
                SizedBox(height: height / 15),
                CustomTextField(
                  controller: _nameController,
                  label: 'Name',
                  isName: true,
                  validator: validateName,
                ),
                SizedBox(height: height / 30),
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  isEmail: true,
                  validator: validateEmail,
                ),
                SizedBox(height: height / 30),
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  isPassword: true,
                  validator: validatePassword,
                ),
                SizedBox(height: height / 50),
                Text(
                  'Password must be 8 characters',
                  style: AppTextStyles.bodySmall(color: AppColors.grey),
                ),
                SizedBox(height: height / 20),
                ElevatedButton(
                  onPressed: () {
                    print("Submit button pressed");
                    _userBloc.add(
                      SaveUserEvent(
                        name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.textColorDark,
                    backgroundColor: AppColors.grey.shade900,
                    minimumSize: const Size(200, 60),
                  ),
                  child: Text(
                    'Sign Up',
                    style:
                    AppTextStyles.subtitle(color: AppColors.textColorDark),
                  ),
                ),
                SizedBox(height: height / 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: AppTextStyles.bodyMedium(color: AppColors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()));
                      },
                      child: Text(
                        'Sign In',
                        style: AppTextStyles.bodyMedium(
                            color: AppColors.grey.shade900),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool isEmail;
  final bool isName;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.isPassword = false,
    this.isEmail = false,
    this.isName = false,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: AppColors.grey.shade100,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword && !_isPasswordVisible,
        decoration: InputDecoration(
          labelText: widget.label,
          border: InputBorder.none,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
