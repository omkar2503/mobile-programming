import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quickbite/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  final SharedPreferences _prefs;

  UserProvider(this._prefs) {
    _loadUserData();
  }

  UserModel? get user => _user;

  Future<void> _loadUserData() async {
    final userData = _prefs.getString('user_data');
    if (userData != null) {
      _user = UserModel.fromJson(userData as Map<String, dynamic>);
    } else {
      // Initialize a default user if none exists
      _user = UserModel(
        name: 'User',
        email: 'user@example.com',
        phone: '',
        address: '',
        favorites: [],
        cart: {},
      );
      await _prefs.setString('user_data', _user!.toJson().toString());
    }
    notifyListeners();
  }

  Future<void> updateUser(UserModel newUser) async {
    _user = newUser;
    await _prefs.setString('user_data', newUser.toJson().toString());
    notifyListeners();
  }

  Future<void> addToFavorites(String foodId) async {
    if (_user != null) {
      if (!_user!.favorites.contains(foodId)) {
        _user!.favorites.add(foodId);
        await updateUser(_user!);
      }
    }
  }

  Future<void> removeFromFavorites(String foodId) async {
    if (_user != null) {
      _user!.favorites.remove(foodId);
      await updateUser(_user!);
    }
  }

  Future<void> addToCart(String foodId, int quantity) async {
    if (_user != null) {
      _user!.cart[foodId] = (_user!.cart[foodId] ?? 0) + quantity;
      await updateUser(_user!);
    }
  }

  Future<void> removeFromCart(String foodId) async {
    if (_user != null) {
      _user!.cart.remove(foodId);
      await updateUser(_user!);
    }
  }

  Future<void> updateCartItem(String foodId, int quantity) async {
    if (_user != null) {
      if (quantity > 0) {
        _user!.cart[foodId] = quantity;
      } else {
        _user!.cart.remove(foodId);
      }
      await updateUser(_user!);
    }
  }
} 