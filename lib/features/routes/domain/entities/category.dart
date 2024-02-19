enum Category implements Comparable<Category> {
  fiveA(name: '5a'),
  fiveAPlus(name: '5a+'),
  fiveB(name: '5b'),
  fiveBPlus(name: '5b+'),
  fiveC(name: '5c'),
  fiveCPlus(name: '5c+'),
  sixA(name: '6a'),
  sixAPlus(name: '6a+'),
  sixB(name: '6b'),
  sixBPlus(name: '6b+'),
  sixC(name: '6c'),
  sixCPlus(name: '6c+'),
  sevenA(name: '7a'),
  sevenAPlus(name: '7a+'),
  sevenB(name: '7b'),
  sevenBPlus(name: '7b+'),
  sevenC(name: '7c'),
  sevenCPlus(name: '7c+'),
  eightA(name: '8a'),
  eightAPlus(name: '8a+'),
  eightB(name: '8b'),
  eightBPlus(name: '8b+'),
  eightC(name: '8c'),
  eightCPlus(name: '8c+'),
  nineA(name: '9a'),
  nineAPlus(name: '9a+'),
  nineB(name: '9b'),
  nineBPlus(name: '9b+'),
  nineC(name: '9c'),
  nineCPlus(name: '9c+');

  // Category(String categoryName) : index = categories.indexOf(categoryName);

  factory Category.fromJson(String jsonValue) =>
      Category.values.firstWhere((element) => element.name == jsonValue);

  String toJson() => name;

  @override
  String toString() => name;

  @override
  int compareTo(Category other) => index.compareTo(other.index);

  bool operator <(Category other) => index < other.index;
  bool operator >(Category other) => index > other.index;
  bool operator <=(Category other) => index <= other.index;
  bool operator >=(Category other) => index >= other.index;

  final String name;

  const Category({required this.name});
}
