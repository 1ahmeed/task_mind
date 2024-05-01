import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mindd/features/Layout/cubit/home_cubit.dart';
import 'package:task_mindd/features/Layout/widgets/build_product_item.dart';

import '../../core/utils/app_strings.dart';
import '../../generated/l10n.dart';
import 'cubit/home_state.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              S.of(context).products,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: AppStrings.fontFamily3,
                  fontWeight: FontWeight.w400,
                  fontSize: 20),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            actions: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xffEFC40B),
                  child: Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                Divider(
                  color: Color(0xffECEDED),
                  thickness: 4,
                ),
                ///all products
                Expanded(
                  child: AllProductsSections(),
                )
              ],
            ),
          ),
        );
      },
    ));
  }
}

class AllProductsSections extends StatelessWidget {
  const AllProductsSections({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height * 0.59),
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2,
      padding: EdgeInsets.zero,
      children: List.generate(HomeCubit.get(context)!.homeModel!.data!.products!.length,
              (index) {
        return  BuildProductItem(
          productsModel: HomeCubit.get(context)!.homeModel!.data!.products![index],
        );
      }),
    );
  }
}
