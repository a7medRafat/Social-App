// ignore_for_file: camel_case_types, prefer_const_constructors, unnecessary_string_interpolations
import 'package:arafa/Layout/AppLayout.dart';
import 'package:arafa/constents/constents.dart';
import 'package:arafa/network/local/cashHelper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../cubit/Register/register_cubit.dart';
import '../cubit/Register/register_states.dart';

class AppRegister_Screen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var fomKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppRegisterCubit(),
      child: BlocConsumer<AppRegisterCubit, AppRegisterStates>(
        listener: (BuildContext context, state) {
          if(state is AppCreateUserSuccessState){
            navigateAndFinish(context, App_layout());
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: fomKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: defaultColor),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Register now to communicate with friends',
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        coloredTextFiled(
                            MyController: nameController,
                            myPrefixIcon: Icons.person,
                            validation: (value) {
                              if (value.isEmpty) {
                                return 'Name must not be empty';
                              }
                              return null;
                            },
                            labelTxt: 'Name',
                            radius: BorderRadius.circular(15),
                            txtType: TextInputType.name,
                            isPassword: false),
                        SizedBox(
                          height: 25,
                        ),
                        coloredTextFiled(
                          MyController: emailController,
                          myPrefixIcon: Icons.email,
                          validation: (value) {
                            if (value.isEmpty) {
                              return 'email is too short!';
                            }
                            return null;
                          },
                          labelTxt: 'Email address',
                          radius: BorderRadius.circular(15),
                          txtType: TextInputType.emailAddress,
                          isPassword: false,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        coloredTextFiled(
                          MyController: passwordController,
                          myPrefixIcon: Icons.lock,
                          validation: (value) {
                            if (value.isEmpty) {
                              return 'password is too short!';
                            }
                            return null;
                          },
                          labelTxt: 'Password',
                          radius: BorderRadius.circular(15),
                          txtType: TextInputType.visiblePassword,
                          mySuffixIconBtn:
                          AppRegisterCubit.get(context).IsVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          isPassword: AppRegisterCubit.get(context).IsVisible,
                          suffixPressed: () {
                            AppRegisterCubit.get(context).ChangeVisibility();
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        coloredTextFiled(
                          MyController: phoneController,
                          myPrefixIcon: Icons.phone_android_outlined,
                          validation: (value) {
                            if (value.isEmpty) {
                              return 'Phone is too short!';
                            }
                            return null;
                          },
                          labelTxt: 'Phone',
                          radius: BorderRadius.circular(15),
                          txtType: TextInputType.phone,
                          isPassword: false,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ConditionalBuilder(
                          condition: state is! AppRegisterLoadingState,
                          builder: (context) => defaultButton(
                              fun: () {
                                if (fomKey.currentState!.validate()) {
                                  AppRegisterCubit.get(context).UserRegister(
                                      name: nameController.text,
                                      password: passwordController.text,
                                      email: emailController.text,
                                      phone: phoneController.text
                                  );
                                }
                              },
                              color: defaultColor,
                              Txt: 'login'
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
