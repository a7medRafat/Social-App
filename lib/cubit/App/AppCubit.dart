import 'package:arafa/cubit/App/AppStates.dart';
import 'package:arafa/models/userModel.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constents/constents.dart';

class AppCubit extends Cubit<AppStates>{
  
  AppCubit() : super(AppInitialStates());
  
  static AppCubit get(context)=> BlocProvider.of(context);

  UserModel? model;

  void getUserData(){

    FirebaseFirestore.instance.collection('users').doc(uId.toString()).get().then((value) {
      print('dataaaaaaa ==>>> ${value.data()}');
      emit(AppGetUserDataSuccessStates());
    }).catchError((error){
      print('error in creating user =====> ${error.toString()}');
      emit(AppGetUserDataErrorStates());
    });
  }



  
}