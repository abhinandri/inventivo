import 'package:hive/hive.dart';
part 'usermodel.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  String? photo;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  String password;
  @HiveField(4)
  bool isLoggedIn;

  UserModel(
      {this.photo,
      required this.name,
      required this.email,
      required this.password,
      this.isLoggedIn = false});
}

@HiveType(typeId: 2)
class CategoryModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? imagePath;
  
  @HiveField(2)
  String id;

  CategoryModel(
      {required this.name, this.imagePath, required this.id});
}

