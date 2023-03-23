enum UserRole {
  user, ai
}

class User {
  final String name;
  final String? image;
  final UserRole role;
  final DateTime createdAt;

  User({
    required this.name,
    this.image,
    required this.role,
  }): createdAt = DateTime.now();

  static final ai = User(
    name: 'GPT-3',
    image: 'lib/assets/ai_avatar.png',
    role: UserRole.ai,
  );
}