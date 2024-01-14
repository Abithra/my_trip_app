import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../../constant/app_colors.dart';
import '../../constant/app_textstyles.dart';
import '../../data/model/trip_place.dart';

class ReusableBottomSheet extends StatelessWidget {
  final TripPlace tripPlace;

  const ReusableBottomSheet({super.key, required this.tripPlace});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(tripPlace.tripPlace,
                                style: AppTextStyles.subtitle()),
                            Text(
                              tripPlace.locationWithCityName,
                              style: AppTextStyles.bodyLarge(
                                  color: AppColors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/avatar_1.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: height / 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.grey,
                    ),
                    SizedBox(width: width / 90),
                    Text(
                      tripPlace.locationName,
                      style: AppTextStyles.bodySmall(color: AppColors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    Text(
                      tripPlace.rating.toString(),
                      style: AppTextStyles.bodyLarge(
                          color: AppColors.textColorLight),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      tripPlace.numberOfPersons.toString(),
                      style: AppTextStyles.bodyLarge(
                          color: AppColors.grey.shade900),
                    ),
                    Text(
                      '/Persons',
                      style: AppTextStyles.bodyLarge(color: AppColors.grey),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: height / 30,
            ),
            SizedBox(
              width: width,
              height: 58,
              child: Row(
                children: List.generate(
                  4,
                  (index) {
                    return Row(
                      children: [
                        Container(
                          width: 43,
                          height: 58,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/image_${index + 1}.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        const SizedBox(width: 35)
                      ],
                    );
                  },
                )..addAll([
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 43,
                              height: 58,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image:
                                      AssetImage('assets/images/image_5.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            const SizedBox(width: 25),
                            // Add space between images
                            Center(
                              child: Text(
                                '+16',
                                style: AppTextStyles.subtitle(
                                    color: AppColors.textColorDark),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ]),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height / 30,
                ),
                Text(
                  'About Destination',
                  style: AppTextStyles.title(color: AppColors.textColorLight),
                ),
                SizedBox(
                  height: height / 60,
                ),
                ReadMoreText(
                  tripPlace.description,
                  trimLines: 4,
                  colorClickableText: Colors.blue,
                  textAlign: TextAlign.justify,
                  style:
                      AppTextStyles.bodyLarge(color: AppColors.textColorLight),
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Read more',
                  trimExpandedText: 'Show less',
                ),
                SizedBox(
                  height: height / 30,
                ),
              ],
            ),
            SizedBox(
              width: width,
              height: 70,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.textColorDark,
                  backgroundColor: AppColors.grey.shade900,
                ),
                child: Text(
                  'Book Now',
                  style: AppTextStyles.subtitle(color: AppColors.textColorDark),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
