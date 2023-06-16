import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:jsr_forms/cubit/authentication_cubit/auth_cubit.dart';
import 'package:jsr_forms/cubit/signup_cubit/signup_cubit.dart';
import 'package:jsr_forms/custom_widgets/custom_button.dart';
import 'package:jsr_forms/custom_widgets/input_text_field.dart';
import 'package:jsr_forms/utilities/common_utilities.dart';
import 'package:jsr_forms/utilities/extensions.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) =>
            SignupCubit(context.read<AuthCubit>()),
        child: BlocListener<SignupCubit, SignupState>(
          listener: (context, state) {
            var cubit = context.read<SignupCubit>();
            if(state.status == FormzSubmissionStatus.success) {
              Navigator.popUntil(context, (route) => route.isFirst);
            }
            if (state.msg != '') {
              CommonUtils.showSnackBar(context, state.msg);
              cubit.clearErrorMsg();
            }
          },
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFF0B5CF8), Color(0xFF000000)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
              ),
              Positioned(
                  top: -50,
                  left: -30,
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Color(0xFFFFFFFF), Colors.transparent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  )),
              Positioned(
                  top: 25,
                  right: 10,
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Color(0xFF0056FF), Color(0xFF183671)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  )),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SIGN UP',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ).paddingForOnly(top: 180).wrapCenter(),
                    const Text(
                      'Email',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                        .paddingWithSymmetry(horizontal: 20, vertical: 4)
                        .paddingForOnly(top: 20),
                    InputTextField<SignupCubit, SignupState>(
                      buildWhen: (p, c) => p.email != c.email,
                      onValueChanged: (value, cubit) =>
                          cubit.onEmailChanged(value),
                      getErrorMsg: (state) =>
                          state.email.isPure || state.email.isValid
                              ? null
                              : 'Invalid Email',
                    ).paddingForOnly(bottom: 0),
                    const Text(
                      'Username',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                        .paddingWithSymmetry(horizontal: 20, vertical: 4),
                    InputTextField<SignupCubit, SignupState>(
                      buildWhen: (p, c) => p.username != c.username,
                      onValueChanged: (value, cubit) =>
                          cubit.onUsernameChanged(value),
                      getErrorMsg: (state) =>
                      state.username.length >= 4 || state.username.isEmpty
                          ? null
                          : 'Invalid Username',
                    ).paddingForOnly(bottom: 0),
                    const Text(
                      'Password',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ).paddingWithSymmetry(horizontal: 20, vertical: 4),
                    InputTextField<SignupCubit, SignupState>(
                      obscureText: true,
                      buildWhen: (p, c) => p.password != c.password,
                      onValueChanged: (value, cubit) =>
                          cubit.onPasswordChanged(value),
                      getErrorMsg: (state) =>
                          state.password.isPure || state.password.isValid
                              ? null
                              : 'Invalid Password',
                    ).paddingForOnly(bottom: 0),
                    const Text(
                      'Confirm Password',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ).paddingWithSymmetry(horizontal: 20, vertical: 4),
                    InputTextField<SignupCubit, SignupState>(
                      obscureText: true,
                      buildWhen: (p, c) => p.confirmPassword != c.confirmPassword,
                      onValueChanged: (value, cubit) =>
                          cubit.onConfirmPasswordChanged(value),
                      getErrorMsg: (state) =>
                          state.password.value == state.confirmPassword.value
                              ? null
                              : 'Passwords do not match',
                    ).paddingForOnly(bottom: 0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          title: 'LOGIN',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            );
                          },
                        ),
                        CustomCubitButton<SignupCubit, SignupState>(
                                onTap: (state, cubit) => cubit.onButtonPressed(),
                                isEnabled: (state) =>
                                    state.email.isValid &&
                                    state.password.isValid &&
                                    state.password.value ==
                                        state.confirmPassword.value &&
                                    state.username.length >= 4,
                                isLoading: (state) =>
                                    state.status ==
                                    FormzSubmissionStatus.inProgress,
                                title: 'SIGN UP')
                            .wrapCenter(),
                      ],
                    ).paddingWithSymmetry(horizontal: 20, vertical: 20)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
