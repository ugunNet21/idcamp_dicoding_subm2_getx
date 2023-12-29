class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final List<Category> categories;
  final Menus menus;
  final List<CustomerReview> customerReviews;
  

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.categories,
    required this.menus,
    required this.customerReviews,
  });
}

class Category {
  final String name;

  Category({required this.name});
}

class Menus {
  final List<Food> foods;
  final List<Drink> drinks;

  Menus({required this.foods, required this.drinks});
}

class Food {
  final String name;

  Food({required this.name});
}

class Drink {
  final String name;

  Drink({required this.name});
}

class CustomerReview {
  final String name;
  final String review;
  final String date;

  CustomerReview({required this.name, required this.review, required this.date});
}