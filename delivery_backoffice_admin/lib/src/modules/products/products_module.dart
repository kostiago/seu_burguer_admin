import 'package:flutter_modular/flutter_modular.dart';

import '../../repositories/product/product_repository_impl.dart';
import 'home_products/products_page.dart';

class ProductsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton(
          (i) => ProductRepositoryImpl(i()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const ProductsPage(),
        ),
      ];
}
