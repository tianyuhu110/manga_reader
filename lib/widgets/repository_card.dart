import 'package:flutter/material.dart';

const double bigRadius = 20;
const double smallRadius = 10;

class RepositoryCard extends StatelessWidget {
  final String title;

  const RepositoryCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.9,
      height: screenWidth * 0.9 / 2.5,
      decoration: BoxDecoration(
        color: const Color.fromARGB(80, 158, 158, 158),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InnerContents(title: title),
    );
  }
}

class RefreshRepositoryButton extends StatelessWidget {
  const RefreshRepositoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {},
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(bigRadius),
              bottomLeft: Radius.circular(bigRadius),
              topRight: Radius.circular(smallRadius),
              bottomRight: Radius.circular(smallRadius),
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Text(
          "刷新仓库",
          style: TextStyle(color: const Color.fromARGB(255, 53, 53, 53)),
        ),
      ),
    );
  }
}

class SettingRepository extends StatelessWidget {
  const SettingRepository({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => {},
      icon: Padding(
        padding: const EdgeInsets.only(right: 2),
        child: Icon(Icons.more_vert),
      ),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(smallRadius),
              bottomLeft: Radius.circular(smallRadius),
              topRight: Radius.circular(bigRadius),
              bottomRight: Radius.circular(bigRadius),
            ),
          ),
        ),
      ),
    );
  }
}

class InnerContents extends StatelessWidget {
  final String title;
  const InnerContents({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: Text(title, style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: RefreshRepositoryButton(),
              padding: EdgeInsets.only(bottom: 8),
            ),
            Container(
              child: SettingRepository(),
              padding: EdgeInsets.only(bottom: 8, right: 10),
            ),
          ],
        ),
      ],
    );
  }
}
