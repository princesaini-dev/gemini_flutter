import 'package:flutter/material.dart';

class EmptyDataView extends StatelessWidget {
  const EmptyDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No Data Found'),
    );
  }
}
