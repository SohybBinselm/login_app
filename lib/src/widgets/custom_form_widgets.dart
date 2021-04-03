import 'package:flutter/material.dart';

class MyCustomInput extends StatelessWidget {
  final String labelText;
  final EdgeInsets containerMargin;
  final String initialValue;
  final String hintText;
  final Color labelColor;
  final bool expands;
  final FormFieldValidator<String> validator;
  final int inputMaxLines;
  final bool enabled;
  final TextInputType inputType;
  final EdgeInsets contentPadding;
  final ValueChanged<String> onFieldSubmitted;
  final TextInputAction textInputAction;
  final ValueChanged<String> onChanged;
  final FormFieldSetter<String> onSaved;
  final TextEditingController textEditingController;
  final bool obscureText;
  final bool readOnly;
  final Color cursorColor;
  final double inputSize;
  final Color focusedBorderColor;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final bool filledEnabled;
  final FocusNode focusNode;
  final TextAlign textAlign;
  final BoxShadow boxShadow;
  final FloatingLabelBehavior floatingLabelBehavior;
  final BorderSide border;

  MyCustomInput(
      {this.labelText,
      this.contentPadding =
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
      this.hintText,
      this.onChanged,
      this.enabled = true,
      this.textInputAction,
      this.onSaved,
      this.textEditingController,
      this.expands = false,
      this.initialValue,
      this.inputMaxLines = 1,
      this.containerMargin = const EdgeInsets.symmetric(horizontal: 16),
      this.boxShadow,
      this.inputType,
      this.validator,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.labelColor,
      Key key,
      this.filledEnabled = true,
      this.focusNode,
      this.border,
      this.onFieldSubmitted,
      this.textAlign = TextAlign.start,
      this.cursorColor,
      this.inputSize = 15.0,
      this.floatingLabelBehavior,
      this.focusedBorderColor = const Color(0X99000000),
      this.readOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: containerMargin,
      child: TextFormField(
        expands: expands,
        textInputAction: textInputAction,
        style: TextStyle(
            color: Colors.black,
            fontSize: inputSize,
            fontWeight: FontWeight.w500),
        maxLines: inputMaxLines ?? 1,
        validator: validator,
        textAlign: textAlign,
        keyboardType: inputType,
        onFieldSubmitted: onFieldSubmitted,
        initialValue: initialValue,
        obscureText: obscureText,
        onChanged: onChanged,
        onSaved: onSaved,
        readOnly: readOnly,
        controller: textEditingController,
        cursorColor: cursorColor,
        decoration: InputDecoration(errorStyle: TextStyle(
          color: Colors.red[500],
          fontSize: 12
        ),
            hintText: hintText,
            prefixIconConstraints: BoxConstraints(maxWidth: 20),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            focusColor: Theme.of(context).primaryColor,
            floatingLabelBehavior:
                floatingLabelBehavior ?? FloatingLabelBehavior.auto,
            hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              width: 1,
              color: Colors.grey.withOpacity(0.6),
            )),
            labelText: labelText,
            fillColor: Colors.white,
            filled: filledEnabled,
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.grey.withOpacity(0.6),
              ),
            )),
      ),
    );
  }
}

class MyCustomFormButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressedEvent;
  final Color textColor;
  final double height;
  final double radius;
  final double fontSize;
  final EdgeInsetsGeometry margin;
  final Color backgroundColor;
  final double width;
  final bool enableBorder;

  MyCustomFormButton(
      {Key key,
      @required this.onPressedEvent,
      this.buttonText,
      this.fontSize = 14.0,
      this.height = 46.0,
      this.margin = const EdgeInsets.symmetric(horizontal: 18.0),
      this.radius = 4.0,
      this.textColor = const Color(0xFF000000),
      this.backgroundColor = const Color(0xFFDFC828),
      this.width,
      this.enableBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: enableBorder
              ? Border.all(
                  color: Theme.of(context).primaryColor,
                )
              : null),
      child: MaterialButton(
        disabledColor: Theme.of(context).buttonColor.withOpacity(0.5),
        onPressed: onPressedEvent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        elevation: 0,
        color: backgroundColor,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
          ),
        ),
      ),
    );
  }
}




