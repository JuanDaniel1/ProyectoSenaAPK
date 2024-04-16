import 'package:flutter/material.dart';
import 'package:shop_app/components/rounded_icon_btn.dart';
import 'package:shop_app/models/Product.dart';

import '../../../constants.dart';
import '../../../models/producto_model.dart';
import '../../../size_config.dart';

class ColorDots extends StatefulWidget {
  const ColorDots({super.key, required this.model});
  final ProductoModel? model;
  @override
  State<ColorDots> createState() => _ColorDotsState();

}

class _ColorDotsState extends State<ColorDots> {
  int counter = 1;
  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    if (counter > 1) {
      setState(() {
        counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo


    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          Text(widget.model!.productoPrice.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          Spacer(),
          RoundedIconBtn(
            icon: Icons.remove,
            press: () {decrementCounter();},
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
          Text(counter.toString()),
          SizedBox(width: getProportionateScreenWidth(10)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: () {
              incrementCounter();
            },
          ),
        ],
      ),
    );
  }
}



class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
        Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}