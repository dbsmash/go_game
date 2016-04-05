import 'dart:html';
import 'package:react/react_client.dart' as reactClient;
import 'package:react/react.dart';

import 'package:go/go_game.dart';

main() async {
  reactClient.setClientConfiguration();
  render(BoardSvg({}), querySelector('#content'));
}
