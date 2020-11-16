class User{
  final String email;
  final String id;
  final String name;

  const User({this.email, this.id, this.name});

  static const empty = User(email: '', id: '', name: null);
}