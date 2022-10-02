class Users {
  final String uid;
  final String email;
  final String name;
  final String username;
  final String photo;
  final bool isPrivate;

  Users(
    this.uid,
    this.email,
    this.name,
    this.username,
    this.photo,
    this.isPrivate,
  );
  factory Users.fromJson(Map<String, dynamic> data, String uid) {
    return Users(
      uid,
      data["email"],
      data["name"],
      data["username"],
      data["photo"],
      data["private"],
    );
  }
}

class SearchUser {
  final Users user;
  final int friends;

  SearchUser(
    this.user,
    this.friends,
  );

  factory SearchUser.fromJson(Users user, int ourFriends) {
    return SearchUser(user, ourFriends);
  }
}
