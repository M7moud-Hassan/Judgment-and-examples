import 'package:flutter/material.dart';

class MyMenuItem extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final GestureTapCallback?  onTap;

  const MyMenuItem({Key? key, this.icon, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.indigo,
              size: 30,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              title!,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 26, color: Colors.indigo),
            )
          ],
        ),
      ),
    );
  }
}
