


import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart'as http;
import 'package:task_mindd/features/Layout/model/HomeModel.dart';

import '../../../core/utils/constant.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit? get(context) => BlocProvider.of(context);

  HomeModel? homeModel;
  List<Products> productData = [];
  void  getHomeData(
  ) async {
    emit(HomeDataLoadingState());

    try {
      Response response = await http.post(
          Uri.parse("https://ihoneyherb.com/test-application/home/home.php"),
          headers: {
            "Accept-Language":"ar",
            // checkArabic()?"ar":"en",
          },
          body: {
            "auth_key":"xx508xx63817x7525x74g004x30706542858349x5x78f5xx34xnh468",
            "user_id":"9",
          }
      );
      if (response.statusCode == 200) {
        var responseData = await json.decode(response.body);

        if (responseData['msg'] == "success") {
          homeModel = HomeModel.fromJson(responseData);
          for (var item in responseData['data']['products']) {
            productData.add(Products.fromJson(item));
          }

          emit(HomeDataSuccessState());
        } else {
          ///emit failed
          print("xxxx${responseData['message']}");
          emit(
              HomeDataFailedState(
                  errorMessage: responseData['msg']));
        }
      }
    } catch (e) {
      print(e.toString());
      emit(HomeDataFailedState(errorMessage: e.toString()));
    }
  }



  List<Products> productAfterFiltered = [];

  void  getProductAfterFiltered({required String input}) {
    productAfterFiltered = productData
        .where((element) =>
        element.name!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    print(productData);
    emit(SearchSuccessState());
  }

}
