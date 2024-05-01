

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;
import 'package:http/http.dart';

import '../../../core/utils/local_data.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit? get(context) => BlocProvider.of(context);


  void login({
    required String email,
    required String password,
  })async{

    emit(LoginLoadingState());
    try {
      Response response = await http.post(
          Uri.parse("https://ihoneyherb.com/test-application/login.php"),
          headers: {
             // "Accept-Language": checkArabic()?"ar":"en"
            "Accept-Language": "ar"
          },
          body: {
            "email":email,
            "password":password,
            "platform":"1",
            "token":"asd342dsdddsd323dsdadasd3e",
            "device_id":"bfghtr5yrtytd654e6trd",
          }
      );
      if (response.statusCode==200)  {
        var responseBody=await json.decode(response.body);
        print(responseBody);
        if(responseBody["status"]==true){
          await CacheNetwork.insertIntoCache(key: "token",
              value: responseBody["data"]["auth_key"]);
          emit(LoginSuccessState());
        }else{
          //failed
          print(responseBody['msg']);

          emit(LoginFailedState(errorMessage:responseBody['msg']));
        }
      }
    } catch (e) {
      print(e.toString());

      emit(LoginFailedState(errorMessage:e.toString()));

    }

  }
}
