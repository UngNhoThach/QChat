import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/colors.dart';

class MyTextField extends StatelessWidget {
  final FormFieldSetter<String>? onSaved;
  final controller;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  const MyTextField({
    super.key,
    required this.onSaved,
    required this.validator,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15.0.h),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10.0.w),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500])),
    );
  }
}

class MyTextField_Update extends StatelessWidget {
  final FormFieldSetter<String>? onSaved;
  // final controller;
  final String? hintText;
  final String outText;

  final bool obscureText;
  final FormFieldValidator<String>? validator;
  const MyTextField_Update({
    super.key,
    required this.onSaved,
    required this.validator,
    // required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.outText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: outText,
      onSaved: onSaved,
      validator: validator,
      // controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0.sp, horizontal: 15.sp),
          // contentPadding:
          //     EdgeInsets.only(top: 4, bottom: 4, left: 20, right: 6),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10.0.w),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500])),
    );
  }
}

class MyPasswordTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Function()? onpress;

  const MyPasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (val) =>
            val!.isEmpty ? 'Pass work không được để trống!' : null,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15.0.h),
            suffixIcon: IconButton(
              // onPressed: onpress,
              icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: onpress,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])));
  }
}

class ReMyPasswordTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const ReMyPasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) =>
          val!.isEmpty ? 'Re Pass work không được để trống!' : null,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          prefix: SizedBox(width: 20.0), // Adjust the width as needed
          prefixIconConstraints: BoxConstraints(
            minWidth: 0,
            minHeight: 0,
          ),
          prefixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.paste_sharp),
            ],
          ),
          suffixIcon: const Icon(Icons.visibility_off),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500])),
    );
  }
}

class OTP extends StatelessWidget {
  final bool obscureText;

  const OTP({
    super.key,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          height: 68,
          width: 64,
          child: TextField(
            onChanged: (value) => {
              if (value.length == 1)
                {
                  FocusScope.of(context).nextFocus(),
                }
            },
            obscureText: obscureText,
            style: Theme.of(context).textTheme.headlineMedium,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 2, color: colors.main_color),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ],
    );
  }
}
