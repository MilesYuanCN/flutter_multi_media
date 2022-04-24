import 'package:flutter/material.dart';
import 'package:multi_media/external_plugin.dart';

class DemoExternalTexture extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DemoExternalTextureState();
  }
}

class DemoExternalTextureState extends State<DemoExternalTexture> {
  var textureId = -1;

  @override
  void initState() {
    super.initState();
    CameraExternalPlugin()
        .initialize(300, 300)
        .then((value) => textureId = value);
  }

  @override
  Widget build(BuildContext context) {
    return Texture(textureId: textureId);
  }
  @override
  void dispose() {
    CameraExternalPlugin().dispose();
    super.dispose();
  }
}
