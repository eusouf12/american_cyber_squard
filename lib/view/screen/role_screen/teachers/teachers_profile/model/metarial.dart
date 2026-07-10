class MaterialResponse {
  final bool? success;
  final String? message;
  final MaterialData? data;

  MaterialResponse({
    this.success,
    this.message,
    this.data,
  });

  factory MaterialResponse.fromJson(Map<String, dynamic> json) {
    return MaterialResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? MaterialData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "data": data?.toJson(),
    };
  }
}

class MaterialData {
  final MaterialMeta? meta;
  final List<MaterialItem>? data;

  MaterialData({
    this.meta,
    this.data,
  });

  factory MaterialData.fromJson(Map<String, dynamic> json) {
    return MaterialData(
      meta: json['meta'] != null ? MaterialMeta.fromJson(json['meta']) : null,
      data: json['data'] != null
          ? List<MaterialItem>.from(
              json['data'].map((x) => MaterialItem.fromJson(x)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "meta": meta?.toJson(),
      "data": data?.map((e) => e.toJson()).toList(),
    };
  }
}

class MaterialMeta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  MaterialMeta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory MaterialMeta.fromJson(Map<String, dynamic> json) {
    return MaterialMeta(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPage: json['totalPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "page": page,
      "limit": limit,
      "total": total,
      "totalPage": totalPage,
    };
  }
}

class MaterialItem {
  final String? id;
  final String? assignmentTitle;
  final String? materialType;
  final String? description;
  final String? externalLink;
  final List<String>? materialFiles;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ClassDistribution? classDistributions;

  MaterialItem({
    this.id,
    this.assignmentTitle,
    this.materialType,
    this.description,
    this.externalLink,
    this.materialFiles,
    this.createdAt,
    this.updatedAt,
    this.classDistributions,
  });

  factory MaterialItem.fromJson(Map<String, dynamic> json) {
    return MaterialItem(
      id: json['id'],
      assignmentTitle: json['assignmentTitle'] ?? json['assignmenttitle'],
      materialType: json['materialType'],
      description: json['description'],
      externalLink: json['external_link'],
      materialFiles: json['materialFiles'] != null
          ? List<String>.from(json['materialFiles'])
          : [],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      classDistributions: json['classDistributions'] != null
          ? ClassDistribution.fromJson(json['classDistributions'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "assignmentTitle": assignmentTitle,
      "materialType": materialType,
      "description": description,
      "external_link": externalLink,
      "materialFiles": materialFiles,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "classDistributions": classDistributions?.toJson(),
    };
  }
}

class ClassDistribution {
  final String? id;
  final String? classLevel;

  ClassDistribution({
    this.id,
    this.classLevel,
  });

  factory ClassDistribution.fromJson(Map<String, dynamic> json) {
    return ClassDistribution(
      id: json['id'],
      classLevel: json['classLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "classLevel": classLevel,
    };
  }
}
