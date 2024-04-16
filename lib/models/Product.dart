import 'package:flutter/material.dart';

// Productos modelo
class Product {
  final int id;
  final String title, description, shortDescription;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product( {
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
    required this.shortDescription,
  });
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: 2,
    images: [
      "assets/images/leche.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Leche",
    price: 2500,
    description: description,
    rating: 4.1,
    isPopular: true,
    shortDescription: shortdescription,
  ),
  Product(
    id: 3,
    images: [
      "assets/images/huevos.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Huevos",
    price: 2500,
    description: description,
    shortDescription: shortdescription,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 5,
    images: [
      "assets/images/naranjaNice.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Naranja",
    price: 2500,
    description: description,
    shortDescription: shortdescription,
  ),
  Product(
    id: 6,
    images: [
      "assets/images/UvasNice.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Uvas",
    price: 2500,
    description: description,
    shortDescription: shortdescription,
  ),
  Product(
    id: 7,
    images: [
      "assets/images/manzana.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Manzana",
    price: 2500,
    description: description,
    shortDescription: shortdescription,
  ),
  Product(
    id: 8,
    images: [
      "assets/images/margarita.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Margarita",
    price: 2500,
    description: description,
    shortDescription: shortdescription,
  ),
  Product(
    id: 9,
    images: [
      "assets/images/kiwi.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Kiwi",
    price: 2500,
    description: description,
    shortDescription: shortdescription,
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
const String shortdescription =
    "Wireless Controller for PS4™ gives you what you want in your gaming from...";