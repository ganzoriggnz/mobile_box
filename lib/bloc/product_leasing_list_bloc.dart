import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobilbox/model/product_response.dart';
import 'package:mobilbox/repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

class ProductLeasingListBloc {
  final UserRepository _repository = UserRepository();
  final storage = new FlutterSecureStorage();
  final BehaviorSubject<ProductResponse> _subject =
      BehaviorSubject<ProductResponse>();

  getLeasingProducts() async {
    // var value = await storage.read(key: 'token');
    ProductResponse response = await _repository.getLeasingProducts();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ProductResponse> get subject => _subject;
}

final productsLeasingBloc = ProductLeasingListBloc();
