import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx1st_app/controllers/cart_controller.dart';
import 'package:getx1st_app/controllers/shopping_controller.dart';

class ShoppingPage extends StatelessWidget {
  ShoppingPage({Key? key}) : super(key: key);
  // Get.put means create this controller and put it in the dependencies
  //  dependency injection get.put
  final shoppingController = Get.put(ShoppingController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GetX<ShoppingController>(builder: (controller) {
                return ListView.builder(
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${controller.products[index].productName}",
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        "${controller.products[index].productDescription}",
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${controller.products[index].price}",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  cartController
                                      .addToCart(controller.products[index]);
                                },
                                child: Text('Add to Cart'),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }),
            ),
            GetX<CartController>(builder: (controller) {
              return Text(
                'Total amount: \$ ${controller.totalPrice}',
                style: TextStyle(fontSize: 32, color: Colors.white),
              );
            }),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber,
        onPressed: () {},
        icon: Icon(
          Icons.add_shopping_cart_rounded,
          color: Colors.black,
        ),
        label: GetX<CartController>(builder: (controller) {
          return Text(
            controller.count.toString(),
            style: TextStyle(color: Colors.black, fontSize: 24),
          );
        }),
      ),
    );
  }
}
