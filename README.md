# Stability AI Text-to-Image Client

A lightweight Flutter application that interfaces directly with the Stability AI REST API to generate images from text prompts. The client processes text inputs, manages API request lifecycles, and dynamically renders generated images directly from memory.

---

## Technical Overview & Tech Stack

This project is structured as a minimalist single-purpose client optimized for quick integration of Stability AI:

*   **Frontend Framework:** [Flutter](https://flutter.dev) (Material Design).
*   **API Integration:** Direct HTTP integration via the `http` package, targeting the Stability AI `stable-diffusion-512-v2-1` model.
*   **State Management:** State-driven loading indicators and asynchronous navigation lifecycle handling.
*   **Image Rendering:** Memory-buffered image generation using `Uint8List` to avoid intermediate file writing operations.

---

## Key Features

- **Text Prompt Interface:** Simple input controller equipped with contextual state feedback (loading indicators).
- **Stability AI Integration:** Built-in payload mapping matching Stability AI’s REST specification.
- **In-Memory Rendering:** Securely handles response payload bytes directly to memory using `Image.memory` without disk write overhead.
- **Error Handling:** Graceful failure dialogs indicating typical API failure patterns, including credit depletion.

---

## Configuration & API Key Setup

The integration relies on Stability AI’s standard authorization header.

### API Key Injection

To integrate your credentials, navigate to your API implementation file (typically `lib/api/api.dart`) and locate the headers setup in the `textToImage` function:

```dart
final response = await http.post(
  urlA,
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer YOUR_STABILITY_AI_API_KEY', // Insert your API key here
    'Accept': 'image/png',
  },
  // ...
);
```

---

## API Request Configuration

The application implements a customized baseline payload configuration targeted at high-detail 3D assets generation:

```json
{
  "cfg_scale": 15,
  "clip_guidance_preset": "FAST_BLUE",
  "height": 510,
  "width": 510,
  "samples": 1,
  "steps": 160,
  "seed": 0,
  "style_preset": "3d-model",
  "text_prompts": [
    {
      "text": "your_prompt_here",
      "weight": 1
    }
  ]
}
```

---

## Installation & Local Development

### Prerequisites
*   Flutter SDK (Stable Channel)
*   A valid [Stability AI Developer Account](https://platform.stability.ai/) and API Key.

### Steps
1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/stability-diffusion-flutter.git
    cd stability-diffusion-flutter
    ```

2.  **Get dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Add your Stability AI key:**
    Modify the authorization header as indicated in the configuration section above.

4.  **Run the application:**
    ```bash
    flutter run
    ```

---

## Dependencies

*   `flutter/material.dart`
*   `flutter/services.dart`
*   `http` (For handling JSON payload transfers to/from Stability AI)

---

## Badges

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Platform-Flutter-blue.svg)](https://flutter.dev)

---

## Feedback & Contributions

For technical issues, please submit a detailed issue tracking ticket or connect with the maintainer.
