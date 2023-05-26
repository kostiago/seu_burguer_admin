import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../../../models/product_model.dart';
import '../../../../repositories/product/product_repository.dart';
part 'product_controller.g.dart';

enum ProductStateStatus {
  initial,
  loading,
  loadead,
  error,
}

class ProductController = ProductControllerBase with _$ProductController;

abstract class ProductControllerBase with Store {
  final ProductRepository _productRepository;

  ProductControllerBase(this._productRepository);

  @readonly
  var _status = ProductStateStatus.initial;

  @readonly
  var _products = <ProductModel>[];

  @readonly
  var _filterName;

  @action
  Future<void> loadProducts() async {
    try {
      _status = ProductStateStatus.loading;
      _products = await _productRepository.findAll(_filterName);
      _status = ProductStateStatus.loadead;
    } catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      _status = ProductStateStatus.error;
    }
  }
}
