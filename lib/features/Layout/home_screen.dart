import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:task_mindd/core/utils/app_assets.dart';
import 'package:task_mindd/features/Layout/cubit/home_cubit.dart';
import 'package:task_mindd/features/Layout/cubit/home_state.dart';
import 'package:task_mindd/features/Layout/model/HomeModel.dart';
import 'package:task_mindd/features/Layout/widgets/build_new_product_item.dart';
import 'package:task_mindd/features/Layout/widgets/build_product_item.dart';
import 'package:task_mindd/features/Layout/widgets/build_recommend_item.dart';

import '../../core/utils/app_strings.dart';
import '../../core/utils/my_validators.dart';
import '../../generated/l10n.dart';
import 'all_products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchTextController;
  final pageController = PageController();

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  BeveledRectangleBorder? myBorder;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Scaffold(
                body: HomeCubit.get(context)!.homeModel == null
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ///search
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height * .06,
                                      child: TextFormField(
                                        controller: searchTextController,
                                        textInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.zero,
                                          hintText: S.of(context).search,
                                          hintStyle: TextStyle(
                                              fontSize: 20,
                                              fontFamily: AppStrings.fontFamily3,
                                              fontWeight: FontWeight.w400),
                                          prefixIcon: const Icon(
                                            IconlyBold.search,
                                            color: Color(0xff8E8E93),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        validator: (value) {
                                          return MyValidators.searchValidator(
                                              value);
                                        },
                                        onChanged: (value) {
                                          HomeCubit.get(context)!
                                              .getProductAfterFiltered(
                                                  input: value);
                                          if (searchTextController.text == "") {
                                            setState(() {
                                              HomeCubit.get(context)!
                                                  .productAfterFiltered = [];
                                            });
                                          }
                                        },
                                        onFieldSubmitted: (value) {
                                          HomeCubit.get(context)!
                                              .getProductAfterFiltered(
                                                  input: value);
                                          if (searchTextController.text == "") {
                                            setState(() {
                                              HomeCubit.get(context)!
                                                  .productAfterFiltered = [];
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.share,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              ///banners
                                const BannersSection(),
                              const SizedBox(
                                height: 20,
                              ),

                              ///categories
                                const CategoriesSection(),
                              const Divider(),

                              ///more
                              HeaderOfSections(
                                text: S.of(context).products,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AllProductsScreen(),
                                      ));
                                },
                              ),

                              const SizedBox(
                                height: 5,
                              ),

                              ///products

                              if (HomeCubit.get(context)!.productData.isEmpty)
                                const Center(child: CircularProgressIndicator()),
                              if (HomeCubit.get(context)!
                                      .productAfterFiltered
                                      .isEmpty &&
                                  searchTextController.text != "")
                                const Center(child: Text("No element")),
                              if (HomeCubit.get(context)!
                                  .productAfterFiltered
                                  .isNotEmpty)
                                const ProductAfterFilter(),
                              if (searchTextController.text == "" &&
                                  HomeCubit.get(context)!
                                      .productAfterFiltered
                                      .isEmpty)
                                const ProductsSection(),

                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(),

                              ///more
                              HeaderOfSections(
                                text: S.of(context).recommend,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AllProductsScreen(),
                                      ));
                                },
                              ),

                              ///products recommended
                                const ProductRecommendSection(),
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(),

                              ///more
                              HeaderOfSections(
                                text: S.of(context).newProduct,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AllProductsScreen(),
                                      ));
                                },
                              ),

                              ///products new
                                const NewProductSection(),
                            ],
                          ),
                        ),
                      ),
              );
            },
          ),
    );
  }
}

class BannersSection extends StatelessWidget {
  const BannersSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    return CarouselSlider(
        items: HomeCubit.get(context)!
            .homeModel!
            .data!
            .slider!
            .map(
              (e) => CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: e.image!,
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error_outline),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            )
            .toList(),
        options: CarouselOptions(
            height: 200,
            initialPage: 0,
            viewportFraction: 1.1,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal));
  },
);
  }
}

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          width: 20,
        ),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: HomeCubit.get(context)!.homeModel!.data!.categories!.length,
        itemBuilder: (context, index) => BuildCategoriesItem(
          categoriesModel:
              HomeCubit.get(context)!.homeModel!.data!.categories![index],
        ),
      ),
    );
  },
);
  }
}

class ProductAfterFilter extends StatelessWidget {
  const ProductAfterFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    return GridView.count(
      shrinkWrap: true,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height * 0.59),
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      padding: EdgeInsets.zero,
      children: List.generate(
          HomeCubit.get(context)!.productAfterFiltered.length, (index) {
        return BuildProductItem(
          productsModel: HomeCubit.get(context)!.productAfterFiltered[index],
        );
      }),
    );
  },
);
  }
}

class ProductsSection extends StatelessWidget {
  const ProductsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    return GridView.count(
      shrinkWrap: true,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height * 0.59),
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      padding: EdgeInsets.zero,
      children: List.generate(
          HomeCubit.get(context)!.productData.length < 4
              ? HomeCubit.get(context)!.productData.length // length 3
              : 4, (index) {
        return BuildProductItem(
          productsModel:
              HomeCubit.get(context)!.homeModel!.data!.products![index],
        );
      }),
    );
  },
);
  }
}

class ProductRecommendSection extends StatelessWidget {
  const ProductRecommendSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) => BuildRecommendItem(
          selectedProducts:
              HomeCubit.get(context)!.homeModel!.data!.selectedProducts![index],
        ),
      ),
    );
  },
);
  }
}

class HeaderOfSections extends StatelessWidget {
  const HeaderOfSections({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          //
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: AppStrings.fontFamily3,
              fontSize: 20),
        ),
        const Spacer(),
        ElevatedButton(
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xffEFC40B),
          ),
          onPressed:onPressed,
          child: Text(
            S.of(context).more,
            style: TextStyle(
                color: Colors.white,
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.w400,
                fontSize: 19),
          ),
        ),
      ],
    );
  }
}

class NewProductSection extends StatelessWidget {
  const NewProductSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: HomeCubit.get(context)!.homeModel!.data!.newProducts!.length,
        itemBuilder: (context, index) => BuildNewProductItem(
            newProducts:
                HomeCubit.get(context)!.homeModel!.data!.newProducts![index]),
      ),
    );
  },
);
  }
}

class BuildCategoriesItem extends StatelessWidget {
  const BuildCategoriesItem({
    super.key,
    required this.categoriesModel,
  });

  final Categories categoriesModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: CircleAvatar(
                radius: 38,
                backgroundColor: Colors.transparent,
                backgroundImage: const AssetImage(
                  AppAssets.imagesHexa,
                ),
                child: Image.network(
                  categoriesModel.icon!,
                  width: 30,
                  height: 35,
                )),
          ),
          SizedBox(
            width: 50,
            child: Text(
              categoriesModel.catName!,
              maxLines: 1,
              style: TextStyle(
                  fontFamily: AppStrings.fontFamily3,
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            ),
          )
        ],
      ),
    );
  },
);
  }
}
