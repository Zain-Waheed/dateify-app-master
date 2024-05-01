

import 'package:get/get.dart';

import '../localization/app_localization.dart';

class FieldValidator {
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return getTranslated(Get.context!, "please_enter_your_email_address");
    }

    if (!RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      return getTranslated(Get.context!, "please_enter_a_valid_email_address");
    }

    return null;
  }

  static String? validateTitle(String? value) {
    if (value!.isEmpty) {
      return getTranslated(Get.context!, "enter_title");
    }
    return null;
  }

  static String? validateDescription(String? value) {
    if (value!.isEmpty) {
      return getTranslated(Get.context!, "enter_description");
    }
    return null;
  }
  static String? validateGender(String? value) {
    if (value!.isEmpty) {
      return getTranslated(Get.context!, "enter_description");
    }
    return null;
  }
  static String? validateGroup(String? value) {
    if (value!.isEmpty) {
      return getTranslated(Get.context!, "please_select_a_group");
    }
    return null;
  }

  static String? validateEmailUserName(String? value) {
    if (value!.isEmpty) {
      return getTranslated(Get.context!, "enter_email_username");
    }
    return null;
  }

  static String? validateText(String? value) {
    if (value!.isEmpty) return "Text is required";
    if (value.length < 10) {
      return getTranslated(Get.context!, "min_characters");
    }
    if (value.length > 250) {
      return getTranslated(Get.context!, "max_characters");
    }

    return null;
  }

  static String? validateEmailWithoutPhone(String? value) {
    if (value!.isEmpty) {
      return getTranslated(Get.context!, "email_is_required");
    }
    if (!RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)) {
      return getTranslated(Get.context!, "enter_valid_email");
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value!.isEmpty) {
      return getTranslated(Get.context!, "name_required");
    }

    if (!RegExp(r'^[a-z A-Z,.\-]+$').hasMatch(value)) {
      return getTranslated(Get.context!, "invalid_name");
    }

    return null;
  }

  static String? validateLastName(String? value) {
    if (value!.isEmpty) {
      return getTranslated(Get.context!, "last_name_required");
    }

    if (!RegExp(r"^[A-Za-z-]{2,25}$").hasMatch(value)) {
      return getTranslated(Get.context!, "invalid_name");
    }

    return null;
  }

  static String? validatePasswordSignup(String? value) {
    if (value!.isEmpty) return getTranslated(Get.context!, "enter_password1");
    if (value.length < 6) return getTranslated(Get.context!, "password_length");
    if (!RegExp(r"^(?=.*?[0-9])").hasMatch(value)) {
      return getTranslated(Get.context!, "password_length1");
    }
    return null;
  }

  static String? validateOTP(String? value) {
    if (value!.isEmpty) return getTranslated(Get.context!, "enter_otp");
    if (value.length < 4)
      return getTranslated(Get.context!, "enter_complete_otp");
    Pattern pattern = r'^[0-9]{4}$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value.trim())) {
      return getTranslated(Get.context!, "invalid_otp");
    }

    return null;
  }

  static String? validateDateOfBirth(String ?value) {
    if (value!.isEmpty) {
      return getTranslated(Get.context!, "dob_required");
    }
    return null;
  }

  static String? validateMobile(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value!.isEmpty) {
      return getTranslated(Get.context!, "please_enter_mobile_number");
    }
    else if (!regExp.hasMatch(value)) {
      return getTranslated(Get.context!, "please_enter_valid_mobile_number");
    }
    return null;
  }

  static String? validateCreditCard(String? value){
    if (value!.isEmpty) {
      return getTranslated(Get.context!, "please_enter_mobile_number");
    }
  }

}
