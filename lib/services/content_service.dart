import '../models/media_item.dart';

class ContentService {
  Future<List<MediaItem>> getContents() async {
    final response = {
      "result": [
        {
          "type": "image",
          "url":
              "https://images.pexels.com/photos/32417863/pexels-photo-32417863.jpeg"
        },
        {
          "type": "video",
          "url":
              "https://samplelib.com/lib/preview/mp4/sample-20s.mp4"
        },
        {
          "type": "video",
          "url":
              "https://samplelib.com/lib/preview/mp4/sample-10s.mp4"
        },
        {
          "type": "image",
          "url":
              "https://images.pexels.com/photos/34213341/pexels-photo-34213341.jpeg"
        },
        {
          "type": "video",
          "url":
              "https://samplelib.com/lib/preview/mp4/sample-15s.mp4"
        }
      ]
    };

    return (response["result"] as List)
        .map((e) => MediaItem.fromJson(e))
        .toList();
  }
}