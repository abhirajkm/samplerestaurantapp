import 'dart:async';

import 'package:flutter/material.dart';

/*
class CartButton extends StatefulWidget {
  final Product? product;
  final String? vendorId;
  final int? quantity;
  final Weight? selectedWeight;

  const CartButton({
    Key? key,
    this.product,
    this.vendorId,
    this.quantity,
    this.selectedWeight,
  }) : super(key: key);

  @override
  _CartButtonState createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  int _quantity = 0;
  Timer? _timer;



  _removeProduct() async {
    bool isLoading =
        Provider.of<EcommerceProvider>(context, listen: false).cartLoading;
    if (await  !isLoading) {
      _timer?.cancel();
      _timer=Timer(Duration(milliseconds: 500), () {
        Provider.of<EcommerceProvider>(context, listen: false)
            .removeFromCart(
            productCode: widget.product!.id,
            vendorId: widget.vendorId,
            unit: widget.selectedWeight!.quantity)
            .then((value) {
          if (value) {
            setState(() {
              _quantity = 0;
            });
          }
        });
      });
    }
  }

  _removeFromCart() async {
    //bool isLoading = Provider.of<EcommerceProvider>(context, listen: false).cartLoading;
    if (await isAuthorized */
/*&& !isLoading*//*
) {
      if (_quantity > 1) {
        setState(() {
          _quantity = _quantity - 1;
        });
        _timer?.cancel();
        _timer = Timer(Duration(milliseconds: 500), () {
          Provider.of<EcommerceProvider>(context, listen: false)
              .addToCart(
              product: widget.product!,
              quantity: _quantity,
              weight: widget.selectedWeight,
              vendorId: widget.vendorId)
              .then((value) {
            reload();
          });
        });
      } else {
        _removeProduct();
      }
    }
  }

  _addToCart() async {
    if (await isAuthorized) {

      if(widget.product!.productQty!>0){
        if(_quantity<widget.product!.productQty!){
          setState(() {
            _quantity = _quantity + 1;
          });
          _timer?.cancel();

          _timer = Timer(Duration(milliseconds: 500), () {
            Provider.of<EcommerceProvider>(context, listen: false)
                .addToCart(
                vendorId: widget.vendorId,
                weight: widget.selectedWeight,
                product: widget.product!,
                quantity: _quantity)
                .then((value) {
              reload();
            });
          });
        }else{
          showMessage("Stock limit exceed");
        }

      }

    }
  }

  @override
  void initState() {
    _quantity = widget.quantity ?? 0;
    super.initState();
  }

  Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };

  Color getBackgroundColor(Set<MaterialState> states) {
    if (states.any(interactiveStates.contains)) {
      return primaryColor;
    }
    return primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return _quantity == 0
        ? SizedBox(
      height: 50.0,
      child: FittedBox(
        child: TextButton(
          onPressed: _addToCart,
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.resolveWith(getBackgroundColor),
          ),
          child: TitleRegular(
            title: "Add",
            fontSize: 14,
            titleColor: white,
          ),
        ),
      ),
    )
        : Container(
      height: 50,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: buttonDecoration.copyWith(
          color: white,
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.remove,
                    color: primaryColor,
                  ),
                  onPressed: _removeFromCart),
            ),
            Container(
              width: 30,
              child: Container(
                color: primaryColor,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: TitleRegular(
                      title: "$_quantity",
                      titleColor: white,
                      fontSize: 14,
                    ),
                    onPressed: null),
              ),
            ),
            Container(
              width: 30,
              child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.add,
                    color: primaryColor,
                  ),
                  onPressed: _addToCart),
            ),
          ],
        ),
      ),
    );
  }
}*/
