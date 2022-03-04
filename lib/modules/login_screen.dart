import 'package:arafa/Layout/AppLayout.dart';
import 'package:arafa/constents/constents.dart';
import 'package:arafa/cubit/App/AppCubit.dart';
import 'package:arafa/cubit/Login/login_stattes.dart';
import 'package:arafa/modules/register_screen.dart';
import 'package:arafa/network/local/cashHelper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/components.dart';
import '../cubit/Login/login_cubit.dart';


class AppLogin_Screen extends StatelessWidget {

  var fomKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit , AppLoginStates>(
        listener: (BuildContext context, state) {
          if(state is AppLoginSuccessState){
            CashHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, App_layout());
            });
          }
          if(state is AppLoginErrorState){
            ShowToast(msg: state.error ,
                states: ToastStates.ERROR
            );
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
                        Text('LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: defaultColor
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text('login now to communicate with friends',
                            style:Theme.of(context).textTheme.headline6!.copyWith(
                                color: Colors.black54
                            )
                        ),
                        const SizedBox(height: 40,),
                        defaultTextFiled(
                            MyController: emailController,
                            myPrefixIcon: Icons.email,
                            validation: (value){
                              if(value.isEmpty){
                                return 'field must not be empty';
                              }
                              return null;
                            },
                            labelTxt: 'E-mail',
                            radius: BorderRadius.circular(15),
                            txtType: TextInputType.emailAddress,
                            isPassword: false
                        ),
                        const SizedBox(height: 15,),
                        defaultTextFiled(
                          MyController: passwordController,
                          myPrefixIcon: Icons.lock,
                          validation: (value){
                            if(value.isEmpty){
                              return 'password is too short!';
                            }
                            return null;
                          },
                          labelTxt: 'Password',
                          radius: BorderRadius.circular(15),
                          txtType: TextInputType.visiblePassword,
                          mySuffixIconBtn: AppLoginCubit.get(context).IsVisible? Icons.visibility_off : Icons.visibility,
                          isPassword: AppLoginCubit.get(context).IsVisible,
                          suffixPressed: (){
                            AppLoginCubit.get(context).ChangeVisibility();
                          },
                        ),
                        const SizedBox(height: 30,),
                        ConditionalBuilder(
                          condition: state is ! AppLoginLoadingState ,
                          builder: (context)=>defaultButton(
                              fun: (){
                                if(fomKey.currentState!.validate()){
                                  AppLoginCubit.get(context).UserLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );

                                }
                              },
                              color: defaultColor,
                              Txt: 'login'
                          ),
                          fallback: (context)=>const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),
                            ),
                            TextButton(
                                onPressed: (){
                                  navigateTo(
                                      context,
                                      AppRegister_Screen());
                                },
                                child: const Text(
                                    'Register Now'
                                )
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('______________________',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15
                              ),
                            ),
                            SizedBox(width: 10),
                            Text('OR',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),
                            ),
                            SizedBox(width: 10),
                            Text('______________________',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15
                              ),
                            )
                          ],
                        ),
                         const SizedBox(height: 50,),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              MaterialButton(
                                height: 50,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: const BorderSide(
                                      color: Colors.grey,
                                    )
                                ),
                                  onPressed: (){
                                  AppLoginCubit.get(context).google();
                                  },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                  Image(
                                    height: 35,
                                    width: 35,
                                    image: AssetImage('images/google.png'),
                                    fit: BoxFit.cover,
                                  ),
                                    SizedBox(width: 25,),
                                    Text(
                                      'Sign in With Google',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15,),
                              MaterialButton(
                                height: 50,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: const BorderSide(
                                    color: Colors.grey,
                                  )
                                ),
                                onPressed: (){},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Image(
                                      height: 35,
                                      width: 35,
                                      image: AssetImage('images/faceBook.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: 20,),
                                    Text(
                                      'Sign in With FaceBook',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )

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
