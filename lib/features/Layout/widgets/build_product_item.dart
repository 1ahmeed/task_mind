import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:task_mindd/features/Layout/model/HomeModel.dart';

import '../../../core/utils/app_strings.dart';

class BuildProductItem extends StatelessWidget {
   BuildProductItem({
    super.key, required this.productsModel,
  });
final Products productsModel;
  double? rat;
  @override
  Widget build(BuildContext context) {
    if(productsModel.rating==null&&productsModel.rating==0.0){
      rat=1;
    }
    return SizedBox(
      width: 200,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///image
          Expanded(
            child: CachedNetworkImage(
              height: double.infinity,
              imageUrl:productsModel.mainImage!,
              fit: BoxFit.fill,
              errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error_outline)),
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator()),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ///details info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///name
                    FittedBox(
                      child: Text(
                        productsModel.name!,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            fontFamily: AppStrings.fontFamily3,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ///description info
                    Text(
                      productsModel.shortDesc!,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          fontFamily: AppStrings.fontFamily3,
                          overflow: TextOverflow.ellipsis),
                    ),
                    ///rating
                    Row(
                      children: [

                        Text(
                          "(${productsModel.rating??"10" })",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff8E8E93),
                              fontFamily: AppStrings.fontFamily2,
                              fontSize: 10),
                        ),
                        RatingBar.builder(
                          initialRating: rat??1,
                          minRating: 1,
                          // maxRating: ,
                          itemSize: 7,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(
                              horizontal: 1.0),
                          itemBuilder: (context, _) =>
                          const SizedBox(
                            child: Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    ///sale price
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                         "${productsModel.salePrice}درهم اماراتي",
                          style: TextStyle(
                              color: const Color(0xffCE9D22),
                              fontFamily: AppStrings.fontFamily3,
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                        )),
                    const SizedBox(
                      width: 5,
                    ),

                    ///old price
                    if (productsModel.discount != "0" &&
                        productsModel.discount != productsModel.salePrice)
                     FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "${productsModel.listPrice}درهم اماراتي",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12.5,
                            decoration:
                            TextDecoration.lineThrough),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (productsModel.discount != "0" &&
                        productsModel.discount != productsModel.salePrice)
                      ///discount
                    Container(
                      color: Colors.black,
                      child: Text(
                        "خصم${productsModel.discount}%",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: AppStrings.fontFamily,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
