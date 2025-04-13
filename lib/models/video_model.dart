class VideoModel {
  final String id;
  final String? videoId; // This field is sometimes present, sometimes not
  final String video;
  final String name;
  final String image;
  final double duration;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  VideoModel({
    required this.id,
    this.videoId,
    required this.video,
    required this.name,
    required this.image,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['_id'] as String,
      videoId: json['videoId'] as String?, // Use 'as String?' for nullable
      video: json['video'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      duration:
          (json['duration'] as num).toDouble(), // Handle both int and double
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'videoId': videoId, // Include even if null
      'video': video,
      'name': name,
      'image': image,
      'duration': duration,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}

// Example usage (in a separate dart file or section):
// import 'dart:convert';
// import 'your_video_model_file.dart';

// void main() {
//   const jsonData = '''
//  [
//     {
//             "_id": "67bd6711945b05f52fedb1e1",
//             "video": "https://res.cloudinary.com/dkq3cbxgz/video/upload/c_scale,h_720,q_auto,w_1280/v1741057057/videos/push-up-1741057054737.mp4",
//             "name": "Workout video",
//             "image": "/images/badge-1740465937256.png",
//             "duration": 24,
//             "createdAt": "2025-02-25T06:45:37.787Z",
//             "updatedAt": "2025-03-04T02:57:41.094Z",
//             "__v": 0
//         },
//         {
//             "_id": "67bfe9f5848c7c6ae77b9cc5",
//             "video": "https://res.cloudinary.com/dkq3cbxgz/video/upload/c_scale,h_720,q_auto,w_1280/v1741057057/videos/push-up-1741057054737.mp4",
//             "name": "video in 720p",
//             "image": "/images/x-icon-in-footer-1740630516821.png",
//             "duration": 226.6,
//             "createdAt": "2025-02-27T04:28:37.469Z",
//             "updatedAt": "2025-02-27T04:28:37.469Z",
//             "__v": 0
//         },
//         {
//             "_id": "67bfee70848c7c6ae77b9ccb",
//             "video": "https://res.cloudinary.com/dkq3cbxgz/video/upload/c_scale,h_720,q_auto,w_1280/v1741057057/videos/push-up-1741057054737.mp4",
//             "name": "720p second",
//             "image": "/images/code-genarator-(1)-1740631664150.png",
//             "duration": 226.6,
//             "createdAt": "2025-02-27T04:47:44.416Z",
//             "updatedAt": "2025-02-27T04:47:44.416Z",
//             "__v": 0
//         },
//         {
//             "_id": "67c27bfe064c5c249d88cca1",
//             "video": "https://res.cloudinary.com/dkq3cbxgz/video/upload/c_scale,h_720,q_auto,w_1280/v1741057057/videos/push-up-1741057054737.mp4",
//             "name": "workout video",
//             "image": "/images/aha-soft-free-large-boss-admin.512-1740798973813.png",
//             "duration": 24,
//             "createdAt": "2025-03-01T03:16:14.375Z",
//             "updatedAt": "2025-03-01T03:16:14.375Z",
//             "__v": 0
//         },
//         {
//             "_id": "67c28ac569bd943a9a60ed3a",
//             "video": "https://res.cloudinary.com/dkq3cbxgz/video/upload/c_scale,h_720,q_auto,w_1280/v1741057057/videos/push-up-1741057054737.mp4",
//             "name": "workout video",
//             "image": "/images/aha-soft-free-large-boss-admin.512-1740802740865.png",
//             "duration": 24,
//             "createdAt": "2025-03-01T04:19:17.945Z",
//             "updatedAt": "2025-03-01T04:19:17.945Z",
//             "__v": 0
//         },
//         {
//             "_id": "67c290ec6780819cb4ce8212",
//             "video": "https://res.cloudinary.com/dgqnr6nsy/video/upload/c_scale,h_720,q_auto,w_1280/v1741065306/videos/push-up-1741065304087.mp4",
//             "name": "workout video",
//             "image": "/images/aha-soft-free-large-boss-admin.512-1740804317569.png",
//             "duration": 14.335,
//             "createdAt": "2025-03-01T04:45:32.761Z",
//             "updatedAt": "2025-03-04T05:15:09.469Z",
//             "__v": 0,
//             "videoId": "videos/push-up-1741065304087"
//         },
//         {
//             "_id": "67c68c258d2ffcac3b2b71c7",
//             "videoId": "videos/push-up-1741065248007",
//             "video": "https://res.cloudinary.com/dgqnr6nsy/video/upload/c_scale,h_720,q_auto,w_1280/v1741065250/videos/push-up-1741065248007.mp4",
//             "name": "workout video2",
//             "image": "/images/images-1741065248020.jpg",
//             "duration": 14.335,
//             "createdAt": "2025-03-04T05:14:13.314Z",
//             "updatedAt": "2025-03-04T05:14:13.314Z",
//             "__v": 0
//         }
//  ]
// ''';
//
//  final List<dynamic> decodedList = jsonDecode(jsonData);
//  final List<VideoModel> videos = decodedList.map((jsonItem) => VideoModel.fromJson(jsonItem)).toList();
//   //Access the data
//    for (final video in videos) {
//       print('Video Name: ${video.name}, Duration: ${video.duration}');
//       print('Video ID: ${video.videoId}'); // Access the potentially null videoId
//     }

//  // Convert back to JSON (example)
//   final jsonOutput = jsonEncode(videos.map((e) => e.toJson()).toList());
//   print(jsonOutput);
// }
