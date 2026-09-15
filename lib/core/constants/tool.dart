import 'package:flutter/material.dart';

/// حقل إدخال عام قابل لإعادة الاستخدام
Widget defaultTextField({
  required TextEditingController controller,
  required String label,
  String? hint,
  IconData? prefixIcon,
  IconData? suffixIcon,
  VoidCallback? onSuffixPressed,
  TextInputType? keyboardType,
  bool obscureText = false,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
  void Function(String)? onSubmitted,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText,
    validator: validator,
    onChanged: onChanged,
    onFieldSubmitted: onSubmitted,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
      suffixIcon: suffixIcon == null
          ? null
          : IconButton(
        onPressed: onSuffixPressed,
        icon: Icon(suffixIcon),
      ),
      border: const OutlineInputBorder(),
    ),
  );
}

/// زر أساسي عام
Widget defaultButton({
  required String text,
  required VoidCallback onPressed,
  double height = 50,
  double radius = 10,
  Color? backgroundColor,
  Color textColor = Colors.white,
  double fontSize = 16,
}) {
  return SizedBox(
    width: double.infinity,
    height: height,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

/// نص قابل لإعادة الاستخدام
Widget defaultText({
  required String text,
  double fontSize = 16,
  FontWeight? fontWeight,
  Color? color,
  TextAlign? textAlign,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

/// مسافة رأسية
Widget verticalSpace(double height) {
  return SizedBox(height: height);
}

/// مسافة أفقية
Widget horizontalSpace(double width) {
  return SizedBox(width: width);
}

/// خط فاصل
Widget defaultDivider({
  double height = 1,
  Color? color,
}) {
  return Container(
    width: double.infinity,
    height: height,
    color: color ?? Colors.grey.shade300,
  );
}

/// زر أيقونة عام
Widget defaultIconButton({
  required IconData icon,
  required VoidCallback onPressed,
  Color? color,
  double? size,
  String? tooltip,
}) {
  return IconButton(
    onPressed: onPressed,
    icon: Icon(
      icon,
      color: color,
      size: size,
    ),
    tooltip: tooltip,
  );
}

/// الانتقال إلى صفحة جديدة
void navigateTo(
    BuildContext context,
    Widget screen,
    ) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => screen,
    ),
  );
}

/// الانتقال إلى صفحة جديدة مع إزالة الصفحات السابقة
void navigateAndFinish(
    BuildContext context,
    Widget screen,
    ) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => screen,
    ),
        (route) => false,
  );
}
