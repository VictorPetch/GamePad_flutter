import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class Utils {
  static Future capture(GlobalKey key) async {
    if (key == null) return null;

    return Future.delayed(const Duration(milliseconds: 20), () async {
      RenderRepaintBoundary boundary =
          key.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      return pngBytes;
    });
  }

  static Future<void> createFileFromString(Uint8List bytes) async {
    String dir = (await getExternalStorageDirectory()).path;
    String fullPath = '$dir/file.png';
    File file = File(fullPath);
    var exists = false;
    // var exists = await file.exists();
    if(!exists) {
      await file.writeAsBytes(bytes);

      await ImageGallerySaver.saveImage(bytes);
    }
    Share.shareFiles([file.path], text: 'Great picture');
  }
}