import 'package:flutter/material.dart';
import 'package:moneytos/utils/constance/myColors/mycolor.dart';
import 'package:moneytos/utils/constance/sizedbox/sizedBox.dart';

class CustomTextFields extends StatelessWidget {
  final String text, hinttext, errortext;
  final bool error;
  final double width, height;
  final TextEditingController controller;
  final FocusNode focus;
  final bool show_hide;
  final TextInputType keyboardtype;
  final TextInputAction textInputAction;
  final Color border_color;

  const CustomTextFields({
    Key? key,
    this.text = '',
    this.hinttext = '',
    this.errortext = '',
    this.error = false,
    this.height = 51,
    this.width = double.infinity,
    required this.controller,
    required this.focus,
    required this.textInputAction,
    required this.keyboardtype,
    this.show_hide = false,
    this.border_color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //  height: height,
      width: width,
      child: Column(
        children: [
          hSizedBox2,
          hSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  text,
                  style: TextStyle(
                    color: MyColors.blackColor.withOpacity(0.50),
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              show_hide == true
                  ? Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        '',
                        style: TextStyle(
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          hSizedBox1,
          hSizedBox,
          SizedBox(
            height: height,
            child: TextField(
              textInputAction: textInputAction,
              keyboardType: keyboardtype,
              focusNode: focus,
              controller: controller,
              cursorColor: MyColors.primaryColor,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: border_color),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: border_color),
                ),
                hintText: hinttext,
                hintStyle: TextStyle(
                  color: MyColors.blackColor.withOpacity(0.30),
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          hSizedBox,
          error == true
              ? Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    errortext,
                    style: const TextStyle(
                      color: MyColors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.50,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
