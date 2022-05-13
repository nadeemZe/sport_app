import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  final String? text;
  final Function? function;

  const CustomButton({Key? key,required this.text,required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed:() {function!();},
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black12)
        ),
        child: Text(
            text!,
        )
    );
  }
}