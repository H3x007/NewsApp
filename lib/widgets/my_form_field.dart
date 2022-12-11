import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/bloc_cubit/cubit.dart';

class MyFormField extends StatelessWidget {
  MyFormField(
      {Key? key,
      this.controller,
      required this.type,
      this.showPassword = false,
      this.onSubmit,
      this.hint,
      required this.label,
      this.validate,
      required this.suffix,
      this.suffixPressed})
      : super(key: key);

  TextEditingController? controller;
  TextInputType type;
  bool? showPassword;
  final onSubmit;
  final validate;
  final suffixPressed;
  String? hint;
  String label;
  IconData suffix;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: showPassword!,
        onFieldSubmitted: onSubmit,
        //style: NewsCubit.get(context).isDark ? titleStyle.copyWith(color: Colors.grey[300]) : titleStyle.copyWith(color: Colors.grey[700]),
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 14),
            label: Text(
              label,
              //style: subTitleStyle,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            suffixIcon: suffix != null
                ? IconButton(
                    onPressed: suffixPressed,
                    icon: Icon(suffix),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            )),
        validator: validate,
      ),
    );
  }
}
