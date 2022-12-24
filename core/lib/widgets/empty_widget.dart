import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        key: const Key('empty_widget'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children : const [
            Icon(Icons.featured_play_list_outlined,size: 60,),
            SizedBox(height: 10,),
            Text('Your Wishlist is Empty')
          ]
        ),
    );
  }
}