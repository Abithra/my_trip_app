import 'package:flutter/material.dart';
import 'package:my_trip_flutter_app/constant/app_colors.dart';
import '../../constant/app_textstyles.dart';

class DestinationCard extends StatelessWidget {
  final String imagePath;
  final String tripPlace;
  final String placeName;
  final double rating;
  final String location;
  final List<String> avatarImages;
  final double width;
  final VoidCallback? onTap;

  DestinationCard({
    super.key,
    required this.imagePath,
    required this.tripPlace,
    required this.placeName,
    required this.rating,
    required this.location,
    required this.avatarImages,
    required this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300,
              width: 50,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              height: 90,
              width: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        placeName,
                        style: AppTextStyles.subtitle(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                          ),
                          Text(
                            rating.toString(),
                            style: AppTextStyles.subtitle(),
                          ),
                        ],
                      )
                    ],
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
                          Text(
                            location,
                            style:
                                AppTextStyles.bodyMedium(color: AppColors.grey),
                          ),
                        ],
                      ),
                      SizedBox(width: width * 0.25),
                      Row(
                        children: [
                          for (int i = 0; i < avatarImages.length + 1; i++)
                            Align(
                              widthFactor: 0.5,
                              child: i < avatarImages.length
                                  ? CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundImage:
                                            AssetImage(avatarImages[i]),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        '+50',
                                        style: AppTextStyles.bodyMedium(),
                                      ),
                                    ),
                            )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
