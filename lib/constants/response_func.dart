import 'package:flutter/material.dart';


double getHeight(context){
  double h=MediaQuery.of(context).size.height;
  return  h ;
}

double getWidth(context){
  double w=MediaQuery.of(context).size.width;
  return  w ;
}
