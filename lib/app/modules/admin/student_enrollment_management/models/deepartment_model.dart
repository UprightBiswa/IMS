import 'dart:convert';

DepartmentResponse departmentResponseFromJson(String str) => DepartmentResponse.fromJson(json.decode(str));
String departmentResponseToJson(DepartmentResponse data) => json.encode(data.toJson());

class DepartmentResponse {
    List<Department>? items;
    int? page;
    int? pages;
    int? perPage;
    int? total;

    DepartmentResponse({
        this.items,
        this.page,
        this.pages,
        this.perPage,
        this.total,
    });

    factory DepartmentResponse.fromJson(Map<String, dynamic> json) => DepartmentResponse(
        items: json["items"] == null ? [] : List<Department>.from(json["items"]!.map((x) => Department.fromJson(x))),
        page: json["page"],
        pages: json["pages"],
        perPage: json["per_page"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "page": page,
        "pages": pages,
        "per_page": perPage,
        "total": total,
    };
}

class Department {
    String? code;
    int? collegeId;
    String? createdAt;
    String? description;
    String? headOfDepartment;
    int? id;
    bool? isActive;
    String? name;
    String? updatedAt;

    Department({
        this.code,
        this.collegeId,
        this.createdAt,
        this.description,
        this.headOfDepartment,
        this.id,
        this.isActive,
        this.name,
        this.updatedAt,
    });

    factory Department.fromJson(Map<String, dynamic> json) => Department(
        code: json["code"],
        collegeId: json["college_id"],
        createdAt: json["created_at"],
        description: json["description"],
        headOfDepartment: json["head_of_department"],
        id: json["id"],
        isActive: json["is_active"],
        name: json["name"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "college_id": collegeId,
        "created_at": createdAt,
        "description": description,
        "head_of_department": headOfDepartment,
        "id": id,
        "is_active": isActive,
        "name": name,
        "updated_at": updatedAt,
    };
}