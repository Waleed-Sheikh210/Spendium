import 'dart:async';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';

import '../Models/FamilyMemberModel.dart';
import '../Models/MembersModel.dart';
import '../main.dart';
import 'ColorUtils.dart';
import 'fontUtils.dart';

class MyButton extends StatelessWidget {
  String text, fontFamily;
  Color? color;
  Color? textColor;
  Color? borderColor;
  VoidCallback? onPress;
  double height, circularRadius, width;
  Widget? child;
  double? textSize;
  bool needBorder;
  bool applyGradient;
  List<Color>? colorForGradient;
  bool? needCenter;
  Alignment? begin;
  Alignment? end;

  MyButton(
      {this.text = "No text given",
      required this.onPress,
      this.color,
      this.fontFamily = "gibsonRegular",
      this.textColor = Colors.white,
      this.height = 14,
      this.width = 0,
      this.circularRadius = 15,
      this.child,
      this.textSize,
      this.colorForGradient,
      this.applyGradient = false,
      this.needBorder = false,
      this.borderColor,
      this.begin,
      this.end,
      this.needCenter = true});

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      duration: Duration(milliseconds: 200),
      scaleFactor: 0.8,
      onTap: () {
        Future.delayed(Duration(milliseconds: 300), onPress);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: height.h, horizontal: width.w),
        decoration: color == null
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(circularRadius),
                gradient: LinearGradient(
                    begin: begin ?? Alignment.centerLeft,
                    end: end ?? Alignment.centerRight,
                    colors: applyGradient == true
                        ? colorForGradient!
                        : [
                            ColorUtils.red,
                            ColorUtils.red,
                          ]))
            : BoxDecoration(
                borderRadius: BorderRadius.circular(circularRadius),
                border: Border.all(
                    color:
                        needBorder != true ? Colors.transparent : borderColor!),
                color: color),
        child: needCenter == true
            ? Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    color: textColor,
                    fontSize: textSize ?? 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontFamily: fontFamily,
                  color: textColor,
                  fontSize: textSize ?? 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}

class EditText extends StatelessWidget {
  Function(String?)? onChange, onSaved;
  String? Function(String?)? validator;
  final String? hintText,
      errorText,
      prefixIcon,
      suffixIcon,
      fontFamily,
      labelText;
  IconData? icon, prefixiconData;
  bool setEnable, showBorder;
  bool obscure;
  bool isDropDown, isPassword;
  TextInputAction? textInputAction;
  TextInputType? textInputType;
  TextCapitalization? textCapitalization;

  // List<TextInputFormatter>? inputFormatter;
  FocusNode? currentFocus, nextFocus;
  BuildContext context;
  Function(String)? onFieldSubmitted;
  TextEditingController? controller;
  VoidCallback? suffixClick;
  int? maxLines, maxLength, minLines;
  Color? filledcolor;
  Color bordercolor;
  Color? labelcolor;
  Color? hintColor;
  VoidCallback? ONTAP;
  bool? TExtAlign;
  bool? readonly;

  EditText({
    required this.context,
    this.onChange,
    this.hintText,
    this.errorText,
    this.icon,
    this.prefixiconData,
    this.prefixIcon,
    this.suffixIcon,
    this.fontFamily,
    this.onSaved,
    this.validator,
    this.setEnable = true,
    this.obscure = false,
    this.isDropDown = false,
    this.isPassword = false,
    this.showBorder = true,
    this.currentFocus,
    this.nextFocus,
    this.textInputAction,
    this.textInputType,
    // this.inputFormatter,
    this.onFieldSubmitted,
    this.controller,
    this.suffixClick,
    this.maxLength,
    this.minLines,
    this.maxLines = 1,
    this.filledcolor,
    this.labelText,
    this.hintColor,
    this.labelcolor,
    this.ONTAP,
    this.TExtAlign,
    this.readonly,
    this.textCapitalization,
    required this.bordercolor,
  });

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return TextFormField(
      textCapitalization: textCapitalization ?? TextCapitalization.words,
      cursorColor: ColorUtils.white,
      validator: validator,
//      autovalidate: true,
      controller: controller,
      enabled: setEnable,
      onChanged: onChange,
      onSaved: onSaved,
      maxLines: maxLines,
      readOnly: readonly ?? false,
      maxLength: maxLength,
      textAlign: TExtAlign != null ? TextAlign.center : TextAlign.start,
      minLines: minLines,

//      autofocus: true,
      focusNode: currentFocus,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      // inputFormatters: inputFormatter,
      obscureText: obscure,
//      cursorColor: accentColor,
      style: TextStyle(
        height: 1.2,
        fontSize: 14.sp,
        color: Colors.white,
        fontFamily: FontUtils.Regular,
      ),
      textAlignVertical: TextAlignVertical.center,
      onTap: ONTAP,
      onFieldSubmitted: onFieldSubmitted ??
          (value) {
            // print(navigationKey.currentContext!);
            _fieldFocusChange(currentFocus, nextFocus);
          },
      decoration: InputDecoration(
        errorMaxLines: 2,
        counterText: "",
        isCollapsed:
            prefixIcon != null || prefixiconData != null || suffixIcon != null,
        // contentPadding:
        //     // suffixIcon != null ? EdgeInsets.all(10) : EdgeInsets.all(15),
        //     suffixIcon != null
        //         ? EdgeInsets.only(
        //             left: 15,
        //             right: 3,
        //           )
        //         : EdgeInsets.all(15),
        contentPadding: EdgeInsets.only(
          // top: (currentFocus!.hasFocus || controller!.text!.isNotEmpty)
          //     ? 8
          //     : 0,
          right: 10,
          top: prefixIcon == null ? 10 : 18,
          bottom: prefixIcon == null ? 10 : 18,
          left: prefixIcon == null ? 14 : 0,
          // bottom: (currentFocus!.hasFocus || controller!.text!.isNotEmpty) ?-8:0
        ),
        hintText: hintText,
        fillColor: filledcolor ?? Colors.white,
        filled:
            // (currentFocus!.hasFocus || controller!.text.isNotEmpty)
            //     ? false
            //     :
            true,
        // fillColor: (currentFocus?.hasFocus ?? false)
        //     ? ColorUtils.fieldColor
        //     : ((controller?.text?.isEmpty ?? true)
        //         ? filledcolor
        //         : ColorUtils.fieldColor),
        prefixStyle: TextStyle(color: Colors.blue, fontSize: 16),
        // labelStyle: TextStyle(color: Colors.black, fontSize: 16, height: 1.2),

        hintStyle: TextStyle(
          fontFamily: FontUtils.SemiBold,
          color: hintColor ?? ColorUtils.white.withOpacity(0.5),
          fontSize: 14.sp,
        ),
        labelText: labelText,
        alignLabelWithHint: true,
        labelStyle: TextStyle(
            color: (currentFocus?.hasFocus ?? false)
                ? ColorUtils.white
                : ((controller?.text?.isEmpty ?? true)
                    ? ColorUtils.white.withOpacity(0.5)
                    : ColorUtils.white),
            fontSize: 14.sp,
            fontFamily: FontUtils.Medium,
            height: 1.2),
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: suffixClick,
                child: Image.asset(
                  suffixIcon!,
                  scale: 2.5,
                  color: ColorUtils.white,
                ),
              )
            : null,
        prefixIcon: prefixiconData != null
            ? Icon(
                prefixiconData,
                color: ColorUtils.black,
                size: 20,
              )
            : prefixIcon != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 17),
                      Image.asset(
                        prefixIcon!,
                        color: (currentFocus?.hasFocus ?? false)
                            ? ColorUtils.white
                            : ((controller?.text.isEmpty ?? true)
                                ? ColorUtils.black.withOpacity(0.4)
                                : ColorUtils.white),
                        scale: 3,
                      ),
                      SizedBox(width: 10),

                      // ImageIcon(
                      //   AssetImage(prefixIcon!),
                      //   color:  (currentFocus?.hasFocus ?? false)
                      //       ? ColorUtils.primary
                      //       : ((controller?.text?.isEmpty ?? true) ? Color(0xff838EA9) : ColorUtils.primary),
                      //   //scale: 2.5,
                      // ),
                    ],
                  )
                : null,
        // disabledBorder: InputBorder.none,
        errorStyle: TextStyle(color: ColorUtils.red),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: bordercolor == Colors.transparent
                ? BorderSide.none
                : BorderSide(
                    color: (currentFocus?.hasFocus ?? false)
                        ? ColorUtils.white
                        : ((controller?.text.isEmpty ?? true)
                            ? ColorUtils.white.withOpacity(0.5)
                            : ColorUtils.white))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: bordercolor == Colors.transparent
                ? BorderSide.none
                : BorderSide(
                    color: (currentFocus?.hasFocus ?? false)
                        ? ColorUtils.white
                        : ((controller?.text.isEmpty ?? true)
                            ? ColorUtils.white.withOpacity(0.4)
                            : ColorUtils.white))),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: ((controller?.text.isEmpty ?? true)
                    ? ColorUtils.red
                    // ColorUtils.black.withOpacity(0.4)
                    : ColorUtils.white))),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: ((controller?.text.isEmpty ?? true)
                    ? ColorUtils.red
                    // ColorUtils.black.withOpacity(0.4)
                    : ColorUtils.white))),
      ),
    );
  }

  _fieldFocusChange(
      /*BuildContext context,*/ FocusNode? currentFocus, FocusNode? nextFocus) {
    currentFocus?.unfocus();
    if (nextFocus != null)
      FocusScope.of(navigationKey.currentContext!).requestFocus(nextFocus);
  }
}

Widget checkBoxWidget({
  ValueChanged<bool?>? onChange,
  bool check = false,
  bool changeBG = false,
}) {
  return Container(
    decoration: BoxDecoration(
        color: !check
            ? changeBG == true
                ? ColorUtils.lightSlate
                : ColorUtils.white
            : ColorUtils.orangeColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            color:
                check == true ? ColorUtils.orangeColor : ColorUtils.lightSlate,
            width: 1)),
    alignment: Alignment.center,
    width: 18.w,
    height: 18.w,
    child: Checkbox(
        value: check,
        onChanged: onChange,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), side: BorderSide.none),
        activeColor: ColorUtils.orangeColor,
        side: BorderSide(color: ColorUtils.white, width: 5)),
  );
}

postContainer({bool needPriceLine = true, required String status}) {
  return FittedBox(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
      width: MediaQuery.of(navigationKey.currentContext!).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorUtils.lightSlate.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "3000 Lbs Powder bags",
                style: TextStyle(
                    color: ColorUtils.black,
                    fontSize: 13.sp,
                    fontFamily: FontUtils.SemiBold),
              ),
              Text(
                status,
                style: TextStyle(
                    color: ColorUtils.green,
                    fontSize: 13.sp,
                    fontFamily: FontUtils.Regular),
              ),
            ],
          ),

          SizedBox(
            height: 15.h,
          ),

          /// Drop Locations
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 5.h,
                          width: 5.h,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorUtils.orangeColor),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          index == 0 ? "New York" : "Dallas",
                          style: TextStyle(
                              color: ColorUtils.lightSlate,
                              fontSize: 13.sp,
                              fontFamily: FontUtils.Medium),
                        )
                      ],
                    ),
                    Text(
                      index == 0 ? "27 Dec" : "31 Dec",
                      style: TextStyle(
                          color: ColorUtils.lightSlate.withOpacity(0.6),
                          fontSize: 13.sp,
                          fontFamily: FontUtils.Medium),
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
              itemCount: 2),
          if (needPriceLine == true) ...[
            SizedBox(
              height: 15.h,
            ),
            Divider(
              color: ColorUtils.lightSlate,
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text("LTL",
                        style: TextStyle(
                            color: ColorUtils.black,
                            fontSize: 11.sp,
                            fontFamily: FontUtils.Medium))),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Market Price ",
                        style: TextStyle(
                          color: ColorUtils.lightSlate
                              .withOpacity(0.6)
                              .withOpacity(0.6),
                          fontFamily: FontUtils.Medium,
                          fontSize: 11.sp,
                        ),
                      ),
                      TextSpan(
                        text: "\$3200",
                        style: TextStyle(
                          color: ColorUtils.lightSlate,
                          fontSize: 15.sp,
                          fontFamily: FontUtils.SemiBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ]

          /// if Condition
        ],
      ),
    ),
  );
}

class BounceEffect extends StatelessWidget {
  Widget child;
  VoidCallback? onPress;
  double? scaleFactor;
  int? duration;

  BounceEffect(
      {Key? key,
      required this.child,
      required this.onPress,
      this.scaleFactor = 0.8,
      this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounceable(
        onTap: () {
          Future.delayed(Duration(milliseconds: 300), onPress);
        },
        duration: Duration(milliseconds: duration ?? 200),
        scaleFactor: scaleFactor ?? 0.8,
        child: child);
  }
}

Timer? _timer;

Future<void> showLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 20.0
    ..radius = 10.0
    ..progressColor = ColorUtils.teal
    ..backgroundColor = ColorUtils.black
    ..indicatorColor = ColorUtils.white
    ..textColor = ColorUtils.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;

  _timer = Timer(const Duration(seconds: 25), () {
    if (EasyLoading.isShow) {
      hideLoading();
      EasyLoading.showToast("Something went Wrong!, Try Again");
    }
  });

  return EasyLoading.show(
    status: "Loading..",
    maskType: EasyLoadingMaskType.black,
  );
}

Future<void> hideLoading() {
  _timer?.cancel();
  return EasyLoading.dismiss();
}

void toast(message) {
  if (message != null) {
    showToast(
      message,
      duration: Duration(seconds: 2),
      position: ToastPosition.bottom,
      backgroundColor: Colors.grey[800],
      radius: 5.0,
      textStyle: TextStyle(
          fontSize: 16.0, color: Colors.white, decoration: TextDecoration.none),
    );
  }
}

// whatsapp() async {
//   var contact = "+1(876) 860-1514";
//   var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
//   var iosUrl =
//       "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";
//
//   try {
//     if (Platform.isIOS) {
//       await launchUrl(Uri.parse(iosUrl));
//     } else {
//       await launchUrl(Uri.parse(androidUrl),
//           mode: LaunchMode.externalApplication);
//     }
//   } on Exception {
//     toast('WhatsApp is not installed.');
//   }
// }

class MyDropDown extends StatelessWidget {
  List array;
  String? title;
  Widget? hintText;
  String? selectedValue;
  FormFieldValidator? validator;
  ValueChanged<String?>? onChanged;
  FormFieldSetter<String>? onSaved;
  Color? borderColor;
  Color? dropdownTextColor;
  Color? dropdownArrowColor;
  Color? dropDownBGColor;
  bool needLabelText;
  TextStyle? textStyle;
  double? dropdownMaxHeight;
  EdgeInsetsGeometry? buttonPadding;

  MyDropDown({
    Key? key,
    required this.array,
    this.selectedValue,
     this.title,
    this.borderColor,
    this.hintText,
    this.dropdownTextColor,
    this.dropdownMaxHeight,
    required this.validator,
    required this.onChanged,
    required this.onSaved,
    this.textStyle,
    this.buttonPadding,
    this.needLabelText = true,
    this.dropdownArrowColor,
    this.dropDownBGColor,
  }) : super(key: key);
  final dropDownFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      focusNode: dropDownFocus,
      value: selectedValue,
      hint: hintText,

      decoration: InputDecoration(
          isDense: true,
          contentPadding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 0, bottom: 0),
          filled: true,
          fillColor: ColorUtils.black.withOpacity(0.4),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(12)),
          errorBorder: OutlineInputBorder(
              gapPadding: 0,
              borderSide: const BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(12)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(12)),
          floatingLabelStyle: TextStyle(
            fontFamily: FontUtils.Medium,
            fontSize: 15.sp,
            color: ColorUtils.white,
          ),
          labelText: needLabelText == false ? null : title,
          // label: Padding(
          //   padding: EdgeInsets.only(
          //     left: Dimentions.horizontalPadding,
          //   ),
          //   child: Text(title,style: customTextStyle(
          //     fontFamily: Font.Medium,
          //     fontSize:locator<AllergiesViewModel>().selectedStatus == null ||dropDownFocus.hasFocus ? 11.sp: 14.sp,
          //     textColor: locator<AllergiesViewModel>().selectedStatus == null ||dropDownFocus.hasFocus? ColorUtils.txtWhite :ColorUtils.white,
          //   ),),
          // ),
          errorStyle: TextStyle(color: ColorUtils.red),
          labelStyle: TextStyle(
            fontFamily: FontUtils.Medium,
            fontSize: 11.sp,
            color: ColorUtils.white,
          ),
          alignLabelWithHint: false
          //Add more decoration as you want here
          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
          ),
      isExpanded: true,
      // hint: const Text(
      //   'Select Your Gender',
      //   style: TextStyle(fontSize: 14),
      // ),
      items: array.map((item) {
        try {
          return DropdownMenuItem<String>(
            value: item["title"],
            child: Text(
              item["title"],
              style: TextStyle(
                fontSize: 14,
                fontFamily: FontUtils.Medium,
                color: dropdownTextColor ?? ColorUtils.white,
              ),
            ),
          );
        } catch (e) {
          try {
            return DropdownMenuItem<String>(
              value: item.title,
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: FontUtils.Medium,
                  color: dropdownTextColor ?? ColorUtils.white,
                ),
              ),
            );
          } catch (e) {
            try {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: FontUtils.Medium,
                    color: dropdownTextColor ?? ColorUtils.white,
                  ),
                ),
              );
            } catch (e) {
              return DropdownMenuItem<String>(
                value: item.fullname,
                child: Text(
                  item.fullname,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: FontUtils.Medium,
                    color: dropdownTextColor ?? ColorUtils.white,
                  ),
                ),
              );
            }
          }

          // }else{
          //   return DropdownMenuItem<String>(
          //     value: item["title"],
          //     child: Text(
          //       item["title"],
          //       style: TextStyle(
          //         fontSize: 14,
          //         fontFamily: Font.Medium,
          //         color: dropdownTextColor ?? ColorUtils.white,
          //       ),
          //     ),
          //
          //   );
          // }
        }
      }).toList(),
      validator: validator!,
      //   (value) {
      //   if (value == null) {
      //     return 'Please Select Patient Name.';
      //   }
      //   return null;
      // },
      onChanged: onChanged,
      onSaved: onSaved,
      //   (value) {
      //   selectedValue = value.toString();
      // },
      buttonStyleData: ButtonStyleData(
        height: dropdownMaxHeight ?? 40.h,
        padding: buttonPadding,
        overlayColor:
            MaterialStateColor.resolveWith((states) => Colors.transparent),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          // color: ColorUtils.field_background,
        ),
        // padding: EdgeInsets.only(
        //   right: 16.w,
        // ),
      ),
      style: textStyle,
      iconStyleData: IconStyleData(
        icon: RotatedBox(
          quarterTurns: 1,
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            // size: 18,
            color: dropdownArrowColor ?? ColorUtils.black,
          ),
        ),
        iconSize: 18,
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.only(left: 16, right: 0, top: 0, bottom: 0),
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 140.h,
        offset: Offset(0, -5),
        padding: EdgeInsets.symmetric(horizontal: 0
            // locator<AllergiesViewModel>().selectedStatus == null ||
            //     !dropDownFocus.hasFocus? Dimentions.horizontalPadding : 1.w,
            ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: dropDownBGColor ?? ColorUtils.black,
            border: Border.all(
              color: ColorUtils.white,
            )),
      ),
    );
  }
}


void showImageSelectOption({context, Function? completionHandler}) {
  if (Platform.isIOS) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              Navigator.pop(context);
              addImageFromSource(
                ImageSource.camera,
                    (image) {
                  completionHandler!(image);
                },
              );
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Gallery'),
            onPressed: () {
              addImageFromSource(
                ImageSource.gallery,
                    (image) {
                  completionHandler!(image);
                },
              );
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  } else {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(children: [
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text('Camera'),
          onTap: () {
            Navigator.pop(context);
            addImageFromSource(
              ImageSource.camera,
                  (image) {
                completionHandler!(image);
              },
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.photo_album),
          title: Text('Gallery'),
          onTap: () {
            addImageFromSource(
              ImageSource.gallery,
                  (image) {
                completionHandler!(image);
              },
            );
            Navigator.pop(context);
          },
        ),
      ]),
    );
  }
}

/// Add image from selected source
void addImageFromSource(ImageSource source, Function completionHandler) {
  ImagePicker().pickImage(source: source).then(
        (image) async {
      if (image == null) return null;

      // testCompressAndGetFile(File(croppedFile!.path), targetPath)
      return completionHandler(File(image.path));
    },
  ).catchError(
        (error) {
      print('Failed to pick image: $error');
    },
  );
}



class MemberDropdown extends StatelessWidget {
  final List<FamilyMemberModel> members;
  ValueChanged<FamilyMemberModel?>? onChanged;
  MemberDropdown({super.key, required this.members, this.onChanged});

  String? selectedUserName;

  int? selectedUserId;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<FamilyMemberModel>(
      decoration: const InputDecoration(
        labelText: "Select Member",
        border: OutlineInputBorder(),
      ),

      value: null,
      isExpanded: true,
      hint: Text(selectedUserName ?? "Select Member"),
      items: members.map((member) {
        return DropdownMenuItem<FamilyMemberModel>(
          value: member,
          child: Text(member.user?.name ?? "Unknown"),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
