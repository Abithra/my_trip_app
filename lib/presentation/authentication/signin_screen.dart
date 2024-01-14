import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_trip_flutter_app/presentation/authentication/signup_screen.dart';
import '../../constant/app_colors.dart';
import '../../constant/app_textstyles.dart';
import '../../data/bloc/login_bloc/login_bloc.dart';
import '../../data/bloc/login_bloc/login_event.dart';
import '../../data/bloc/login_bloc/login_state.dart';
import '../../data/bloc/user_bloc/user_bloc.dart';
import '../../data/bloc/user_bloc/user_bloc_event.dart';
import '../home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late UserBloc _userBloc;
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<LoginBloc>();
  }

  void _showSuccessMessage(String userName) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully signed in!'),
        duration: Duration(seconds: 2),
      ),
    );
    _navigateToSignUpScreen(userName);
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _navigateToSignUpScreen(String userName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(userName: userName)),
    );
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

  void validateAndSignIn() {
    String? emailError = validateEmail(_emailController.text);
    String? passwordError = validatePassword(_passwordController.text);

    if (emailError == null && passwordError == null) {
      _userBloc
          .add(SignInEvent(_emailController.text, _passwordController.text));
    }
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
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Login successful!"),
                    duration: Duration(seconds: 3),
                  ),
                );
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        HomeScreen(userName: state.user.name)));
              } else if (state is LoginErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    'Sign In Now',
                    style: AppTextStyles.heading(),
                  ),
                ),
                SizedBox(height: height / 25),
                Center(
                  child: Text(
                    'Please sign in to continue our app',
                    style: AppTextStyles.bodyLarge(color: AppColors.grey),
                  ),
                ),
                SizedBox(height: height / 15),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forget Password?',
                        style: AppTextStyles.bodyLarge(
                            color: AppColors.grey.shade900),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height / 50),
                ElevatedButton(
                  onPressed: () {
                    print("Login button pressed");
                    _loginBloc.add(
                      LoginUserEvent(
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
                    'Sign In',
                    style:
                        AppTextStyles.bodyLarge(color: AppColors.textColorDark),
                  ),
                ),
                SizedBox(height: height / 50),
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

  const CustomTextField({
    required this.controller,
    required this.label,
    this.validator,
    this.isPassword = false,
    this.isEmail = false,
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
          border: InputBorder.none, // Remove underline
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
