// ignore_for_file: camel_case_types, file_names

abstract class AppLoginStates {}
class AppLoginInitialState extends AppLoginStates{}
class AppChangeVisibilityState extends AppLoginStates{}
class AppLoginLoadingState extends AppLoginStates{}
class AppLoginSuccessState extends AppLoginStates{
  final String uId;

  AppLoginSuccessState(this.uId);
}
class AppLoginErrorState extends AppLoginStates{
  final  error;

  AppLoginErrorState(this.error);
}

class googleSigningSuccessState extends AppLoginStates{}
class googleSigningErrorState extends AppLoginStates{}