import 'package:uuid/uuid.dart';

import 'package:login_app/api/models/user.model.dart';

final List<User> usersRegistered = [
  User(
      id: const Uuid().v4(),
      email: "cristian.delcid@unah.hn",
      password: "20142002062",
      phone: "99999999",
      name: "Cristian Delcid",
      profile: "assets/cristian_delcid.jpg"),
  User(
      id: const Uuid().v4(),
      email: "lf.pineda@unah.hn",
      password: "20212020009",
      phone: "33333333",
      name: "Luis Pineda",
      profile: "assets/luis_pineda.jpg"),
];