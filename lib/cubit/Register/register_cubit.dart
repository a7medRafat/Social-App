// ignore_for_file: file_names, non_constant_identifier_names, curly_braces_in_flow_control_structures, avoid_print, prefer_const_constructors

import 'package:arafa/cubit/Register/register_states.dart';
import 'package:arafa/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class AppRegisterCubit extends Cubit <AppRegisterStates> {
  AppRegisterCubit() : super(AppRegisterInitialState());

  static AppRegisterCubit get(context) => BlocProvider.of(context);

  bool IsVisible = true;
  IconData SUffix = Icons.visibility;

  void ChangeVisibility(){
    IsVisible = !IsVisible;
    emit(AppRegisterChangeVisibilityState());
  }

void UserRegister({
  required String name,
  required String password,
  required String email,
  required String phone,

}){
  emit(AppRegisterLoadingState());
  FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password).then((value) {
        print(value.user!.email!);
        print(value.user!.uid);
        createUser(
            name: name,
            email: email,
            phone: phone,
            uId: value.user!.uid);
        emit(AppRegisterSuccessState(value.user!.uid));
  }).catchError((error){
    print(error.toString());
    emit(AppRegisterErrorState());
  }
  );
}

void createUser({
  required String? name,
  required String? email,
  required String? phone,
  required String? uId,

}){
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailVerified: false
    );

   FirebaseFirestore.instance.collection('users').doc(uId).set(
     model.ToMap()
   ).then((value) {
     emit(AppCreateUserSuccessState());
   }).catchError((error){
     print(error.toString());
     emit(AppCreateUserErrorState(error.toString()));
   });
}
}