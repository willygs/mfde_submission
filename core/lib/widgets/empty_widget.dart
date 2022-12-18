import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          children : const [
            Icon(Icons.featured_play_list_outlined),
            Text('Your Wishlist is Empty')
          ]
          
        ),
      ),
    );
  }
}