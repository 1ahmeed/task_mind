import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:task_mindd/features/Layout/model/HomeModel.dart';

import '../../../core/utils/app_strings.dart';

class BuildRecommendItem extends StatelessWidget {
   BuildRecommendItem({
    super.key, required this.selectedProducts,
  });
  final SelectedProducts selectedProducts;
 double? rat;

  @override
  Widget build(BuildContext context) {
  if(selectedProducts.rating==null&&selectedProducts.rating==0.0){
     rat=1;
  }
    return SizedBox(
      width: 150,
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
                selectedProducts.mainImage!,
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
          ///details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///name
                    FittedBox(
                      child: Text(
                        selectedProducts.name!,
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
                    ///description info
                    Text(
                      selectedProducts.shortDesc!,
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
                          initialRating:rat ?? 1,
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
                          "(${selectedProducts.rating??"10" })",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff8E8E93),
                              fontFamily: AppStrings.fontFamily2,
                              fontSize: 10),
                        ),
                      ],
                    ),
                    ///sale price
                    FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${selectedProducts.salePrice}درهم اماراتي",
                          style: TextStyle(
                              color: const Color(0xffFF0000),
                              fontFamily: AppStrings.fontFamily3,
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                        )),
                    const SizedBox(
                      width: 5,
                    ),

                    ///old price
                    if (selectedProducts.discount != "0" &&
                        selectedProducts.discount != selectedProducts.listPrice)
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "${selectedProducts.listPrice}درهم اماراتي",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: AppStrings.fontFamily3,
                            fontWeight: FontWeight.w400,
                            decoration:
                            TextDecoration.lineThrough),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ///discount
                    Container(
                      color: Colors.black,
                      child: Text(
                        "خصم${selectedProducts.discount}%",
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
