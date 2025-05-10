import 'package:flutter_5_wd/providers/model_provider.dart';

import '../models/post_model.dart';

class PostProvider extends ModelProvider {
  PostProvider()
      : super(
          uri: 'posts',
          fromJson: PostModel.fromJson,
        );
}
