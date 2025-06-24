import 'package:flutter/material.dart';

class RepositoryCard extends StatelessWidget {
  final String title;


  const RepositoryCard({super.key,
  required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.9,
      height: screenWidth * 0.9 / 2.5,
      decoration: BoxDecoration(
        color: const Color.fromARGB(80, 158, 158, 158),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(padding: EdgeInsets.all(15),child: Text(title,style: TextStyle(
        fontSize: 16
      ),)),
    );
  }
}


class RefreshRepositoryButton extends StatelessWidget {
  const RefreshRepositoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: ()=>{}, child: Text("刷新仓库"));
  }
}
