import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/cart_provider.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(title: Text('My Cart')),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final product = cart[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(product['imageUrl'] as String),
              radius: 40,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Provider.of<CartProvider>(
                //   context,
                //   listen: false,
                // ).removeFromCart(product);

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Remove Item'),
                      content: Text(
                        'Are you sure you want to remove this item from the cart?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<CartProvider>(
                              context,
                              listen: false,
                            ).removeFromCart(product);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Remove',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            title: Text(
              product['title'] as String,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text(
              'Size: ${(product['sizes'] as List<int>).first}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          );
        },
      ),
    );
  }
}
