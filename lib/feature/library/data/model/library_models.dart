class CategoryModel {
  final int id;
  final String title;
  final String? description;
  final List<CategoryModel>? subCategories;
  final int? itemsCount;
  final String? categoryItemsUrl;

  CategoryModel({
    required this.id,
    required this.title,
    this.description,
    this.subCategories,
    this.itemsCount,
    this.categoryItemsUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      subCategories: (json['sub_categories'] as List?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemsCount: json['items_count'] as int?,
      categoryItemsUrl: json['category_items'] as String?,
    );
  }
}

class ArticleModel {
  final int id;
  final String title;
  final String? description;
  final String? fullDescription;
  final String? apiUrl;
  final List<AttachmentModel>? attachments;
  final List<PreparedByModel>? preparedBy;

  ArticleModel({
    required this.id,
    required this.title,
    this.description,
    this.fullDescription,
    this.apiUrl,
    this.attachments,
    this.preparedBy,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      fullDescription: json['full_description'] as String?,
      apiUrl: json['api_url'] as String?,
      attachments: (json['attachments'] as List?)
          ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      preparedBy: (json['prepared_by'] as List?)
          ?.map((e) => PreparedByModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class AttachmentModel {
  final int? order;
  final String? size;
  final String? extensionType;
  final String? description;
  final String? url;

  AttachmentModel({
    this.order,
    this.size,
    this.extensionType,
    this.description,
    this.url,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) {
    return AttachmentModel(
      order: json['order'] as int?,
      size: json['size'] as String?,
      extensionType: json['extension_type'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
    );
  }
}

class PreparedByModel {
  final int id;
  final String title;
  final String? type;
  final String? kind;
  final String? description;

  PreparedByModel({
    required this.id,
    required this.title,
    this.type,
    this.kind,
    this.description,
  });

  factory PreparedByModel.fromJson(Map<String, dynamic> json) {
    return PreparedByModel(
      id: json['id'] as int,
      title: json['title'] as String,
      type: json['type'] as String?,
      kind: json['kind'] as String?,
      description: json['description'] as String?,
    );
  }
}
