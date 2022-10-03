class Users {
  final String uid;
  final String email;
  final String name;
  final String username;
  final String photo;
  final bool isPrivate;
  final List<String> friends;

  Users(
    this.uid,
    this.email,
    this.name,
    this.username,
    this.photo,
    this.isPrivate,
    this.friends,
  );
  factory Users.fromJson(Map<String, dynamic> data, String uid, {List<String>? friendList}) {
    return Users(
      uid,
      data["email"],
      data["name"],
      data["username"],
      data["photo"],
      data["private"],
      friendList ?? [],
    );
  }
}

class SearchUser {
  final String uid;
  final Users user;
  final int friends;
  final bool isFriend;

  SearchUser(
    this.uid,
    this.user,
    this.friends,
    this.isFriend,
  );

  factory SearchUser.fromJson(String uid, Users user, int ourFriends, bool isFriend) {
    return SearchUser(
      uid,
      user,
      ourFriends,
      isFriend,
    );
  }
}
