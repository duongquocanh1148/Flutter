
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

import 'package:food_now/fragment/favorite_fragment.dart';

class NotificationFragment extends StatefulWidget {
  const NotificationFragment({super.key});

  @override
  State<NotificationFragment> createState() => _NotificationFragmentState();
}

class _NotificationFragmentState extends State<NotificationFragment> {
  @override
  Widget build(BuildContext context) {
    return const FavoriteFragment();
  }
}