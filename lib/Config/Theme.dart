import 'package:flutter/material.dart';
import 'package:streamstreak/Config/Colors.dart';

var darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,


  colorScheme: const ColorScheme.dark(
    background : BackgroundColor,
    primaryContainer: ContainerColor,
    secondary: BorderColor,
    primary:WhiteColor,
  ),

  inputDecorationTheme: InputDecorationTheme(
      fillColor: BackgroundColor,
      filled:true,
      border:UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius:BorderRadius.circular(10)
      )
  ),



  textTheme :const TextTheme(
    headlineLarge: TextStyle(
      fontSize:32,
      color:ContainerColor,
      fontFamily:"Poppins",
      fontWeight: FontWeight.w800,
    ),
    headlineMedium: TextStyle(
      fontSize:30,
      color:WhiteColor,
      fontFamily:"Poppins",
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      fontSize:20,
      color:WhiteColor,
      fontFamily:"Poppins",
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontSize:18,
      color:WhiteColor,
      fontFamily:"Poppins",
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontSize:15,
      color:BorderColor,
      fontFamily:"Poppins",
      fontWeight: FontWeight.w500,
    ),
    labelLarge: TextStyle(
      fontSize:15,
      color:WhiteColor,
      fontFamily:"Poppins",
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize:12,
      color:WhiteColor,
      fontFamily:"Poppins",
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontSize:10,
      color:WhiteColor,
      fontFamily:"Poppins",
      fontWeight: FontWeight.w300,
    ),
)
);