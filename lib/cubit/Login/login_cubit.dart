// ignore_for_file: file_names, non_constant_identifier_names, curly_braces_in_flow_control_structures, avoid_print, prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_stattes.dart';


class AppLoginCubit extends Cubit <AppLoginStates> {
  AppLoginCubit() : super(AppLoginInitialState());

  static AppLoginCubit get(context) => BlocProvider.of(context);

  bool IsVisible = true;
  IconData SUffix = Icons.visibility;

  void ChangeVisibility(){
    IsVisible = !IsVisible;
    emit(AppChangeVisibilityState());
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void google(){
    signInWithGoogle().then((value) {
      print(value.user!.displayName!);
      emit(googleSigningSuccessState());
    }).catchError((error){
      print('error in ==================>${error.toString()}');
      emit(googleSigningErrorState());
    });
  }

void UserLogin({
  required String email,
  required String password
}){
  emit(AppLoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password
  ).then((value) {
        print(value.user!.uid);
        emit(AppLoginSuccessState(value.user!.uid));
  }).catchError((error){
    print('================>${error.toString()}');
    emit(AppLoginErrorState(error.toString()));
  });
}

}