import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meme.dart';
import '../services/api_service.dart';

final memeProvider = FutureProvider<List<Meme>>((ref) async {
  return ApiService().fetchMemes();
});
