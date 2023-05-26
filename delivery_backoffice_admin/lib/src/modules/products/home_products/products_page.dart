import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../core/ui/widgets/base_headers.dart';
import 'widgets/products_item.dart';

import 'widgets/product_controller.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final controller = Modular.get<ProductController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      reaction((_) => controller.status, (status) {
        late final ReactionDisposer statusDisposer;
        switch (status) {
          case ProductStateStatus.initial:
            // TODO: Handle this case.
            break;
          case ProductStateStatus.loading:
            // TODO: Handle this case.
            break;
          case ProductStateStatus.loadead:
            // TODO: Handle this case.
            break;
          case ProductStateStatus.error:
            // TODO: Handle this case.
            break;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.only(
        top: 40,
        left: 40,
        right: 40,
      ),
      child: Column(
        children: [
          BaseHeaders(
            title: 'Administrar produtos',
            buttonLabel: 'Adicionar',
            buttonPressed: () {},
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 280,
                mainAxisExtent: 280,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return const ProductsItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}
