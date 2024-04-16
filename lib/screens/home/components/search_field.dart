import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';

import '../../../Delegates/search_categories_delegate.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

// Buscador de productos en parte superior

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(onPressed: (){

        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SearchPage()));
      },
          icon: const Icon(Icons.search)
      )
    );
  }
}
