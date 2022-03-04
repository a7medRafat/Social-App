// ignore_for_file: camel_case_types, file_names

abstract class AppRegisterStates {}
class AppRegisterInitialState extends AppRegisterStates{}
class AppRegisterChangeVisibilityState extends AppRegisterStates{}
class AppRegisterLoadingState extends AppRegisterStates{}
class AppRegisterSuccessState extends AppRegisterStates{
  final String uId;

  AppRegisterSuccessState(this.uId);
}
class AppRegisterErrorState extends AppRegisterStates{}

class AppCreateUserSuccessState extends AppRegisterStates{}
class AppCreateUserErrorState extends AppRegisterStates{
  final String error;

  AppCreateUserErrorState(this.error);
}
