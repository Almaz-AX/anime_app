
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSoketService {
  static const url = 'wss://api.anilibria.tv/v3/webSocket/';

  WebSocketChannel listenTitle(String title) {
    return WebSocketChannel.connect(Uri.parse('$url$title'));
  }
}
