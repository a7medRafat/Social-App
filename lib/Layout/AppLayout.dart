import 'package:arafa/constents/constents.dart';
import 'package:arafa/cubit/App/AppCubit.dart';
import 'package:arafa/cubit/App/AppStates.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/components.dart';

class App_layout extends StatelessWidget {

  const App_layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

        return BlocConsumer<AppCubit,AppStates>(
          listener: (BuildContext context, state) {  },
          builder: (BuildContext context, Object? state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                    'News Feed'
                ),
              ),
              body: ConditionalBuilder(
                  condition: AppCubit.get(context).model !=null,
                  builder: (context){
                    var model = AppCubit.get(context).model;
                   return Column(
                      children: [
                        if(model!.isEmailVerified ==false)
                        Container(
                          height: 50.0,
                          color: Colors.amber,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children:  [
                                const Icon(
                                  Icons.info,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 10),
                                const Expanded(
                                  child: Text('Please verify your email',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black
                                    ),),
                                ),
                                const SizedBox(width: 15),
                                TextButton(
                                    onPressed: (){},
                                    child: const Text('SEND',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                )

                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  fallback: (context)=>const Center(child: CircularProgressIndicator())
              )
            );
          },
        );

  }
}
