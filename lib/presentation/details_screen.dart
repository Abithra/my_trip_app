import 'package:flutter/material.dart';
import 'package:my_trip_flutter_app/constant/app_colors.dart';
import 'package:my_trip_flutter_app/constant/app_textstyles.dart';
import 'package:my_trip_flutter_app/presentation/widgets/Reusable_bottom_sheet.dart';
import '../data/model/trip_place.dart';

class DetailsScreen extends StatefulWidget {
  final TripPlace tripPlace;
  final String dynamicImagePath;

  const DetailsScreen(
      {Key? key, required this.tripPlace, required this.dynamicImagePath})
      : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late String dynamicImagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.dynamicImagePath),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.1),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: AppColors.textColorDark),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Details',
                          style: AppTextStyles.heading(
                              color: AppColors.textColorDark),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.1),
                          child: const Icon(Icons.bookmark_add_outlined,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showBottomSheet(context);
    });
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ReusableBottomSheet(tripPlace: widget.tripPlace);
      },
    );
  }
}
