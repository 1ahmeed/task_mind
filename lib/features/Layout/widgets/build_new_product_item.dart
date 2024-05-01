import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:task_mindd/features/Layout/model/HomeModel.dart';

import '../../../core/utils/app_strings.dart';

class BuildNewProductItem extends StatelessWidget {
  const BuildNewProductItem({
    super.key, required this.newProducts,
  });
final NewProducts newProducts;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 260,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///image
          Expanded(
            child: Center(
              child: CachedNetworkImage(
                height: double.infinity,
                imageUrl:
               newProducts.mainImage!,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error_outline)),
                placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator()),
              ),
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
                    ///name of product
                    FittedBox(
                      child: Text(
                        newProducts.name!,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: AppStrings.fontFamily3,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ///describtion
                    Text(
                      newProducts.shortDesc!,
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

                        RatingBar.builder(
                          initialRating:newProducts.rating??4,
                          // unratedColor: Color,
                          minRating: 1,
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
                        Text(
                          "(${newProducts.rating??"10" })",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff8E8E93),
                              fontFamily: AppStrings.fontFamily2,
                              fontSize: 10),
                        ),
                      ],
                    ),
                    ///salePrice
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${newProducts.salePrice}درهم اماراتي",
                          style: TextStyle(
                              color: const Color(0xffFF0000),
                              fontFamily: AppStrings.fontFamily3,
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                        )),

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
