import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children : const [
            Icon(Icons.search_off_rounded ,size: 60,),
            SizedBox(height: 10,),
            Text('Oops! No Data Found')
          ]
          
        ),
      ),
    );
  }
}