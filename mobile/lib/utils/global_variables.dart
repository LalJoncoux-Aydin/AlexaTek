import 'package:alexatek/screens/collection_screen.dart';
import 'package:alexatek/screens/object_screen.dart';
import 'package:flutter/material.dart';
import 'package:alexatek/screens/feed_screen.dart';

const String defaultAvatarUrl = 'https://cdn-icons-png.flaticon.com/512/847/847969.png';

List<Widget> homeScreenItems = <Widget>[
  const FeedScreen(),
  const ObjectScreen(),
  const CollectionScreen(),
/*  const ObjectScreen(),
  const CollectionScreen(),*/
];
