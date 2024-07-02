class Category {
  final String name;

  Category(this.name);

  factory Category.fromJson(String json) {
    return Category(json);
  }

  static List<Category> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => Category(json as String)).toList();
  }
}
