import 'package:flutter/material.dart';
import 'package:shop_app/size_config.dart';

// Configuraciones de variables para disenos y tamanos de letra

const kPrimaryColor = Color(0xffff20752b);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Por favor digita tu Email";
const String kInvalidEmailError = "Por favor digite un Email correcto";
const String kPassNullError = "Por favor digite su contrasena";
const String kShortPassError = "La contrasena es muy corta";
const String kMatchPassError = "Contrasenas no se relacionan";
const String kNamelNullError = "Por favor digite su nombre";
const String kPhoneNumberNullError = "Por favor digite su numero de telefono";
const String kAddressNullError = "Por favor digite su direccion";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
