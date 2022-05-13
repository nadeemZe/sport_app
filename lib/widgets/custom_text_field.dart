import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;

  const CustomTextField({Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintStyle:const TextStyle(color:Colors.black54),
          hintText:hintText ,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:const BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:const BorderSide(
                color: Colors.black,
                width: 1
            ),
          ),
          filled: true,
          fillColor:Colors.white24 ,
      ),
    );
  }
}