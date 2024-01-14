
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_trip_flutter_app/constant/app_colors.dart';


class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  final primaryColor = AppColors.textColorDark;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: primaryColor,
      child: SizedBox(
        height: 56,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconBottomBar(
                  text: "Home",
                  icon: Icons.home,
                  selected: true,
                  onPressed: () {}),
              IconBottomBar(
                  text: "Calendar",
                  icon: Icons.calendar_month_sharp,
                  selected: false,
                  onPressed: () {}),
              GestureDetector(
                onTap: () {
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.grey.shade900,
                  radius: 20, // Set your desired radius
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/images/search.svg',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              IconBottomBar(
                  text: "Messages",
                  icon: Icons.messenger_outline,
                  selected: false,
                  onPressed: () {}),
              IconBottomBar(
                  text: "Profile",
                  icon: Icons.person_4_outlined,
                  selected: false,
                  onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  IconBottomBar(
      {Key? key,
        required this.text,
        required this.icon,
        required this.selected,
        required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  final accentColor = AppColors.grey.shade900;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
              icon,
              size: 25,
              color: selected ? accentColor : Colors.grey),
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 12,
              height: .1,
              color: selected
                  ? accentColor
                  : Colors.grey),
        )
      ],
    );
  }
}
