class AnnouncementResponse {
  final bool? success;
  final String? message;
  final AnnouncementData? data;

  AnnouncementResponse({
    this.success,
    this.message,
    this.data,
  });

  factory AnnouncementResponse.fromJson(Map<String, dynamic> json) {
    return AnnouncementResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? AnnouncementData.fromJson(json['data'])
          : null,
    );
  }
}

class AnnouncementData {
  final AnnouncementMeta? meta;
  final List<AnnouncementModel>? data;

  AnnouncementData({
    this.meta,
    this.data,
  });

  factory AnnouncementData.fromJson(Map<String, dynamic> json) {
    return AnnouncementData(
      meta: json['meta'] != null
          ? AnnouncementMeta.fromJson(json['meta'])
          : null,
      data: (json['data'] as List?)
          ?.map((e) => AnnouncementModel.fromJson(e))
          .toList(),
    );
  }
}

class AnnouncementMeta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  AnnouncementMeta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory AnnouncementMeta.fromJson(Map<String, dynamic> json) {
    return AnnouncementMeta(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPage: json['totalPage'],
    );
  }
}

class AnnouncementModel {
  final String? id;
  final String? title;
  final String? description;
  final List<String>? audience;
  final bool? isDelete;
  final String? createdAt;
  final String? updatedAt;

  AnnouncementModel({
    this.id,
    this.title,
    this.description,
    this.audience,
    this.isDelete,
    this.createdAt,
    this.updatedAt,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      audience:
          (json['audience'] as List?)?.map((e) => e.toString()).toList(),
      isDelete: json['isDelete'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}