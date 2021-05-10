import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PortfolioCard extends StatelessWidget {

  final String title;
  final String value;
  final bool action;
  final Function actionCallback;
  final Color color;

  const PortfolioCard({
    @required this.title,
    @required this.value,
    @required this.action,
    @required this.actionCallback,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {

    final TextStyle kTitleStyle = TextStyle(
      fontSize: 16.5,
      height: 1.5,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w500,
    );

    final TextStyle kValueStyle = TextStyle(
      fontSize: 28.0,
      height: 1.5,
      letterSpacing: -1,
      color: color,
      fontWeight: FontWeight.bold,
    );

    return GestureDetector(
      onTap: () {
        if (action) {
          actionCallback();
        }
      },
      child:  Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: kTitleStyle),

                if (action) FaIcon(
                  FontAwesomeIcons.angleRight,
                  color: Colors.grey.shade300,
                  size: 24,
                )

              ],
            ),

            Text(value, style: kValueStyle),
          ],
        ),
      ),
    );
  }
}

