import 'package:get/get.dart';
import 'package:streamstreak/Pages/CreateStream/CreateStreamPage.dart';
import 'package:streamstreak/Pages/EditStream/EditStreamPage.dart';
import 'package:streamstreak/Pages/HomePage/HomePage.dart';

var pagePath=[
  GetPage(
    name: '/homePage',
    page:()=> Homepage(),
    transition: Transition.zoom,
    transitionDuration: Duration(milliseconds: 500)
  ),
  GetPage(
    name: '/createStreamPage',
    page:()=> CreateStreamPage(),
    transition: Transition.zoom,
  ),
  GetPage(
    name: "/editStreamPage",
    page:()=> EditStreamPage(),
    transition: Transition.zoom,
  )
];