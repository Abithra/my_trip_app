import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_trip_flutter_app/constant/app_colors.dart';
import 'package:my_trip_flutter_app/constant/app_textstyles.dart';
import 'package:my_trip_flutter_app/presentation/widgets/bottom_navigation_bar.dart';
import 'package:my_trip_flutter_app/presentation/widgets/custom_curved_underline_text.dart';
import 'package:my_trip_flutter_app/presentation/widgets/destination_card.dart';
import '../data/bloc/trip_place_bloc/trip_place_bloc.dart';
import '../data/bloc/trip_place_bloc/trip_place_event.dart';
import '../data/bloc/trip_place_bloc/trip_place_state.dart';
import '../data/model/trip_place.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({Key? key, required this.userName}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TripBloc _tripBloc;

  @override
  void initState() {
    super.initState();
    _tripBloc = BlocProvider.of<TripBloc>(context);
    _tripBloc.add(LoadTripData());
  }

  List<String> dynamicImagePaths = [
    'assets/images/home_card_1.jpg',
    'assets/images/home_card_2.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: width / 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.grey.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 15,
                  child: SvgPicture.asset(
                    'assets/images/avatar.svg',
                    height: 30,
                    width: 30,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    widget.userName,
                    style: AppTextStyles.bodyLarge(
                        color: AppColors.textColorLight),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CircleAvatar(
              backgroundColor: AppColors.grey.shade50,
              radius: 20,
              child: IconButton(
                icon: const Icon(Icons.notification_add_outlined),
                onPressed: () {},
                alignment: Alignment.center,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Container(
            height: height,
            width: width,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(height: height / 25),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomCurvedUnderline(
                            title: 'Explore the \nBeautiful World'),
                      ],
                    ),
                    SizedBox(height: height / 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Best Destination',
                          style: AppTextStyles.subtitle(),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'View All',
                            style: AppTextStyles.bodyMedium(
                                color: AppColors.grey.shade900),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //horizontal scrollable list view
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: BlocBuilder<TripBloc, TripState>(
                    builder: (context, state) {
                      if (state is TripLoaded) {
                        return SizedBox(
                          height: height / 2,
                          width: width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.tripPlaces.length,
                            itemBuilder: (context, index) {
                              String dynamicImagePath = dynamicImagePaths[
                                  index % dynamicImagePaths.length];
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: width / 1.2,
                                    height: 400,
                                    child: DestinationCard(
                                      tripPlace:
                                          state.tripPlaces[index].tripPlace,
                                      placeName:
                                          state.tripPlaces[index].locationName,
                                      rating: state.tripPlaces[index].rating,
                                      location: state.tripPlaces[index]
                                          .locationWithCityName,
                                      avatarImages: const [
                                        'assets/images/avatar_1.png',
                                        'assets/images/avatar_2.png',
                                        'assets/images/avatar_3.png'
                                      ],
                                      width: width,
                                      imagePath: dynamicImagePath,
                                      onTap: () {
                                        setState(() {
                                          dynamicImagePath = dynamicImagePaths[
                                              index % dynamicImagePaths.length];
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailsScreen(
                                              tripPlace:
                                                  state.tripPlaces[index],
                                              dynamicImagePath:
                                                  dynamicImagePath,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ));
                            },
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class DestinationList extends StatelessWidget {
  late final List<TripPlace> tripPlaces;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: tripPlaces.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DestinationCard(
            tripPlace: tripPlaces[index].tripPlace,
            placeName: tripPlaces[index].locationName,
            rating: tripPlaces[index].rating,
            location: tripPlaces[index].locationWithCityName,
            avatarImages: const [
              'assets/images/avatar_1.png',
              'assets/images/avatar_2.png',
              'assets/images/avatar_3.png',
            ],
            width: 100.0,
            imagePath: '',
          ),
        );
      },
    );
  }
}
