class AppUser {
  static late String userName;
  static late String userUid;
  static late String userImage;

  void init(String name, uid, image) {
    userName = name;
    userUid = uid;
    userImage = image;
  }

  getUserName() {
    return userName;
  }

  getUserUid() {
    return userUid;
  }

  getUserImage() {
    return userImage;
  }
}
