import 'package:flutter_5_wd/models/user_model.dart';
import 'package:flutter_5_wd/providers/model_provider.dart';

class UserProvider extends ModelProvider {
  UserProvider()
      : super(
          uri: 'users',
          fromJson: UserModel.fromJson,
        );
}
