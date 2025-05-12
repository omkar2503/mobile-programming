class UserModel {
  String name;
  String email;
  String phone;
  String address;
  List<String> favorites;
  Map<String, int> cart;

  UserModel({
    required this.name,
    required this.email,
    this.phone = '',
    this.address = '',
    List<String>? favorites,
    Map<String, int>? cart,
  })  : favorites = favorites ?? [],
        cart = cart ?? {};

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'favorites': favorites,
        'cart': cart,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'],
        email: json['email'],
        phone: json['phone'] ?? '',
        address: json['address'] ?? '',
        favorites: List<String>.from(json['favorites'] ?? []),
        cart: Map<String, int>.from(json['cart'] ?? {}),
      );
} 