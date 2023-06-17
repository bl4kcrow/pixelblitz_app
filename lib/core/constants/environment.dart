import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  Environment._();

  static final String rawgApiKey = dotenv.get(
    'RAWG_API_KEY',
  );
}
