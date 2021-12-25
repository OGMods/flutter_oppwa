import 'package:pigeon/pigeon.dart';

enum State {
  pending,
  success,
  error,
}

class Book {
  String? title;
  String? author;
}

@HostApi()
abstract class BookApi {
  @async
  List<Book?> search(String keyword);
}
