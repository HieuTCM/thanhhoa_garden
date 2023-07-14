import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/constants/constants.dart';
import 'package:thanhhoa_garden/providers/cart/cart_provider.dart';
import 'package:thanhhoa_garden/screens/cart/cartScreen.dart';

class CartButton extends StatefulWidget {
  const CartButton({super.key});

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    return _floatingButton();
  }

  Widget _floatingButton() {
    return DraggableFab(
      child: SizedBox(
        height: 55,
        width: 55,
        child: Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              Ink(
                decoration: BoxDecoration(
                  border: Border.all(color: buttonColor, width: 3.0),
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(500.0),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const CartScreen();
                      }));
                    },
                    child: const FaIcon(FontAwesomeIcons.cartShopping),
                  ),
                ),
              ),
              Positioned(
                right: 1,
                top: 1,
                child: ClipOval(
                  child: Container(
                    color: Colors.red,
                    width: 20,
                    height: 20,
                    child: Consumer<CartProvider>(
                      builder: (context, value, _) {
                        return Center(
                            child: Text(
                          (value.list == null)
                              ? '0'
                              : value.list!.length.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
