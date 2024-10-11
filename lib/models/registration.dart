// To parse this JSON data, do
//
//     final registration = registrationFromJson(jsonString);

import 'dart:convert';

Registration registrationFromJson(String str) =>
    Registration.fromJson(json.decode(str));

String registrationToJson(Registration data) => json.encode(data.toJson());

class Registration {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final dynamic companyIndustry;
  final dynamic companyName;
  final String? office;
  final dynamic companyPhone;
  final dynamic companyEmail;
  final dynamic companyAddress;
  final dynamic workshopQuestion;
  final dynamic energyBudget;
  final dynamic hasEnergyManagement;
  final dynamic companyHindrance;
  final dynamic eventInfoSource;
  final dynamic attendanceLateness;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? hasAttended;
  final dynamic attendedAt;
  final dynamic lastBlasted;
  final String? additionalInfo;
  final bool? hasSecondScan;
  final dynamic secondScanAt;
  final String? imageUrl;
  final String? bpc;
  final String? membership;

  Registration({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.companyIndustry,
    this.companyName,
    this.office,
    this.companyPhone,
    this.companyEmail,
    this.companyAddress,
    this.workshopQuestion,
    this.energyBudget,
    this.hasEnergyManagement,
    this.companyHindrance,
    this.eventInfoSource,
    this.attendanceLateness,
    this.createdAt,
    this.updatedAt,
    this.hasAttended,
    this.attendedAt,
    this.lastBlasted,
    this.additionalInfo,
    this.hasSecondScan,
    this.secondScanAt,
    this.imageUrl,
    this.bpc,
    this.membership,
  });

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        companyIndustry: json["company_industry"],
        companyName: json["company_name"],
        office: json["office"],
        companyPhone: json["company_phone"],
        companyEmail: json["company_email"],
        companyAddress: json["company_address"],
        workshopQuestion: json["workshop_question"],
        energyBudget: json["energy_budget"],
        hasEnergyManagement: json["has_energy_management"],
        companyHindrance: json["company_hindrance"],
        eventInfoSource: json["event_info_source"],
        attendanceLateness: json["attendance_lateness"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        hasAttended: json["has_attended"] == 1 ? true : false,
        attendedAt: json["attended_at"],
        lastBlasted: json["last_blasted"],
        additionalInfo: json["additional_info"],
        hasSecondScan: json["has_second_scan"] == 1 ? true : false,
        secondScanAt: json["second_scan_at"],
        imageUrl: json["image_url"],
        bpc: json["bpc"],
        membership: json["membership"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "company_industry": companyIndustry,
        "company_name": companyName,
        "office": office,
        "company_phone": companyPhone,
        "company_email": companyEmail,
        "company_address": companyAddress,
        "workshop_question": workshopQuestion,
        "energy_budget": energyBudget,
        "has_energy_management": hasEnergyManagement,
        "company_hindrance": companyHindrance,
        "event_info_source": eventInfoSource,
        "attendance_lateness": attendanceLateness,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "has_attended": hasAttended,
        "attended_at": attendedAt,
        "last_blasted": lastBlasted,
        "additional_info": additionalInfo,
        "has_second_scan": hasSecondScan,
        "second_scan_at": secondScanAt,
        "image_url": imageUrl,
        "bpc": bpc,
        "membership": membership,
      };
}
