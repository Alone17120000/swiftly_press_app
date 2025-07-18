import 'package:json_annotation/json_annotation.dart';

part 'blog_media_model.g.dart'; // Dòng này báo cho build_runner biết nó cần tạo file .g.dart cho lớp này

@JsonSerializable(fieldRename: FieldRename.snake) // Tự động chuyển đổi tên trường từ snake_case
class BlogMediaModel {
  final int id;
  final BlogMediaType mediaType;
  final BlogMediaDetails mediaDetails;

  BlogMediaModel({
    required this.id,
    required this.mediaType,
    required this.mediaDetails,
  });

  // Factory constructor để tạo instance từ JSON
  factory BlogMediaModel.fromJson(Map<String, dynamic> json) => _$BlogMediaModelFromJson(json);

  // Phương thức để chuyển đổi sang JSON
  Map<String, dynamic> toJson() => _$BlogMediaModelToJson(this);

  // Các getters tương tự như trong iOS
  String? get thumbnail {
    final sizes = mediaDetails.sizes;
    return sizes.thumbnail?.source ?? sizes.medium?.source ?? sizes.large?.source;
  }

  String? get medium {
    final sizes = mediaDetails.sizes;
    return sizes.medium?.source ?? sizes.large?.source;
  }

  String? get large {
    final sizes = mediaDetails.sizes;
    return sizes.large?.source ?? sizes.medium?.source ?? sizes.thumbnail?.source;
  }

  // >>> ĐÂY LÀ PHẦN ĐÃ SỬA LỖI <<<
  // Đã di chuyển 'preview' vào bên trong lớp BlogMediaModel như một static member.
  // Preview/Demo model (tương tự như trong iOS)
  static BlogMediaModel preview = BlogMediaModel(
    id: 1,
    mediaType: BlogMediaType.text, // Có thể là .image nếu có hình ảnh thật
    mediaDetails: BlogMediaDetails(
      sizes: BlogMediaSizes(
        medium: BlogMediaSize(source: "https://ketoplatter.com/wp-content/uploads/2023/08/christmas-dinner-1926937_1280-300x200.jpg"),
        large: BlogMediaSize(source: "https://ketoplatter.com/wp-content/uploads/2023/08/christmas-dinner-1926937_1280-1024x682.jpg"),
        thumbnail: BlogMediaSize(source: "https://ketoplatter.com/wp-content/uploads/2023/08/christmas-dinner-1926937_1280-150x150.jpg"),
      ),
    ),
  );
// >>> KẾT THÚC PHẦN ĐÃ SỬA <<<
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BlogMediaDetails {
  final BlogMediaSizes sizes;

  BlogMediaDetails({required this.sizes});

  factory BlogMediaDetails.fromJson(Map<String, dynamic> json) => _$BlogMediaDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$BlogMediaDetailsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BlogMediaSizes {
  final BlogMediaSize? medium;
  final BlogMediaSize? large;
  final BlogMediaSize? thumbnail;

  BlogMediaSizes({this.medium, this.large, this.thumbnail});

  factory BlogMediaSizes.fromJson(Map<String, dynamic> json) => _$BlogMediaSizesFromJson(json);
  Map<String, dynamic> toJson() => _$BlogMediaSizesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class BlogMediaSize {
  @JsonKey(name: 'source_url') // Map trường 'source_url' từ JSON sang 'source'
  final String source;

  BlogMediaSize({required this.source});

  factory BlogMediaSize.fromJson(Map<String, dynamic> json) => _$BlogMediaSizeFromJson(json);
  Map<String, dynamic> toJson() => _$BlogMediaSizeToJson(this);
}

// Enum cho các loại media, tương tự như trong iOS
enum BlogMediaType {
  image,
  video,
  text,
  application,
  audio,
}