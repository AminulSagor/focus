import 'package:get/get.dart';

class HomeController extends GetxController {
  final contacts = [
    {
      "name": "Alice Martin",
      "number": "555-1234",
      "message": "Call Alice about the report"
    },
    {
      "name": "John Smith",
      "number": "555-5678",
      "message": "Meeting at 3 PM"
    },
    {
      "name": "Mary Johnson",
      "number": "555-8765",
      "message": "Reminder: Buy groceries"
    },
    {
      "name": "Robert Brown",
      "number": "555-4321",
      "message": "Pick up dry cleaning"
    },
  ].obs;
}
