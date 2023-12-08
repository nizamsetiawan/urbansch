import 'package:get/get.dart';

class FAQModel {
  late String question;
  late String answer;
  RxBool expanded = false.obs;

  FAQModel({required this.question, required this.answer});
}
