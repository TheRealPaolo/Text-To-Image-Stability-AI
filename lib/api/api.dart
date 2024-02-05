// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../screen/page1.dart';

Future textToImage(
  BuildContext context,
  String prompt,
) async {
  Uint8List image = Uint8List(0);

  const url = 'https://api.stability.ai';
  final urlA = Uri.parse(
      '$url/v1alpha/generation/stable-diffusion-512-v2-1/text-to-image');

  // HTTP POST request to the Stability AI API
  final response = await http.post(
    urlA,
    headers: {
      'Content-Type': 'application/json',
      'Authorization':
          //add ypur secreat key here
          'Bearer HERE YOUR STABILITY AI API KEY',
      'Accept': 'image/png',
    },
    body: jsonEncode({
      'cfg_scale': 15,
      'clip_guidance_preset': 'FAST_BLUE',
      'height': 510,
      'width': 510,
      'samples': 1,
      'steps': 160,
      'seed': 0,
      'style_preset': "3d-model",
      'text_prompts': [
        {
          'text': prompt,
          'weight': 1,
        }
      ],
    }),
  );

  if (response.statusCode == 200) {
    try {
      image = (response.bodyBytes);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageScreen(imageA: image),
          ));
      return response.bodyBytes;
    } on Exception {
      return AlertDialog(
        title: const Text('Failed'),
        content: const Text('Not enough credit'),
        actions: [
          TextButton(
            child: const Text('Okey'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    }
  } else {
    return AlertDialog(
      title: const Text('Failed'),
      content: const Text('Not enough credit'),
      actions: [
        TextButton(
          child: const Text('Okey'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
