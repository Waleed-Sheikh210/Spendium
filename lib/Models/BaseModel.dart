// class BaseModel {
//   int code;
//   String message;
//   dynamic data;
//   Pagination? pagination;
//
//   BaseModel(
//       {required this.code, required this.message, this.data, this.pagination});
//
//   factory BaseModel.fromJson(Map<String, dynamic> json) {
//     return BaseModel(
//       code: json['code'],
//       message: json['message'],
//       data: json['data'],
//       pagination: json['pagination'] != null
//           ? Pagination.fromJson(json['pagination'])
//           : null,
//     );
//   }
//
//   @override
//   String toString() {
// //    return 'BaseModel{code: $code, message: $message}';//, data: $data}';
//     return 'BaseModel{code: $code, message: $message, data: $data, pagination: $pagination}';
//   }
// }
//
// class Pagination {
//   Meta? meta;
//
//   Pagination({this.meta});
//
//   Pagination.fromJson(Map<String, dynamic> json) {
//     meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     // final Map<String, dynamic> data = new Map<String, dynamic>();
//     // data['meta'] = this.meta;
//     // return data;
//     return this.meta!.toJson();
//   }
// }
//
// class Meta {
//   int? current_page;
//   int? total;
//   int? from;
//   int? to;
//   int? last_page;
//
//   Meta({this.current_page, this.total, this.from, this.to, this.last_page});
//
//   Meta.fromJson(Map<String, dynamic> json) {
//     current_page = json['current_page'];
//     total = json['total'];
//     from = json['from'];
//     to = json['to'];
//     last_page = json['last_page'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_page'] = this.current_page;
//     data['total'] = this.total;
//     data['from'] = this.from;
//     data['to'] = this.to;
//     data['last_page'] = this.last_page;
//     return data;
//   }
// }




class BaseModel {
  int? code;
  String? message;
  String? accessToken;
  dynamic? data;
  Pagination? pagination;

  BaseModel({this.code, this.accessToken, this.message, this.data, this.pagination});

  BaseModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    message = json['Message'];
    accessToken = json['accessToken'];
    data = json['Data'];
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    data['Message'] = this.message;
    data['accessToken'] = this.accessToken;
    data['Data'] = this.data;
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }

  @override
  String toString() {
//    return 'BaseModel{code: $code, message: $message}';//, data: $data}';
    return 'BaseModel{code: $code, accessToken: $accessToken, message: $message, data: $data, pagination: $pagination}';
  }
}


class Pagination {
  int? count;
  int? pageCount;
  int? perPage;
  int? currentPage;

  Pagination({this.count, this.pageCount, this.perPage, this.currentPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pageCount = json['pageCount'];
    perPage = json['perPage'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['pageCount'] = this.pageCount;
    data['perPage'] = this.perPage;
    data['currentPage'] = this.currentPage;
    return data;
  }
}