import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  if (type == "product name") {
    if (!GetUtils.isUsername(val)) {
      return "not valid product name";
    }
  }
  if (type == "username") {
    if (!GetUtils.isNum(val)) {
      return "not valid username";
    }
  }
  if (type == "quantity") {
    if (!GetUtils.isNum(val)) {
      return "not valid quantity";
    }
  }
  if (type == "unity") {
    if (!GetUtils.isUsername(val)) {
      return "not valid unity";
    }
  }
  if (type == "purchase Price") {
    if (!GetUtils.isNum(val)) {
      return "not valid purchase Price";
    }
  }
  if (type == "sales Price") {
    if (!GetUtils.isNum(val)) {
      return "not valid sales Price";
    }
  }
  if (type == "value") {
    if (!GetUtils.isNum(val)) {
      return "not valid purchase value";
    }
  }
  if (val.isEmpty) {
    return " can't be Empty";
  }
  if (val.length < min) {
    return "value can't be then $min";
  }
  if (val.length > max) {
    return "value can't be then $max";
  }
}
