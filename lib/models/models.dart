// import 'package:charity/screens/widget/news_cover.dart';

// class PooyeshesModel {
//   String pooyeshImageUrl;
//   String pooyeshTitle;
//   int pooyeshId;
//   String description;
//   int amount;
//   String start;
//   String end;
//   int type_pay;
//   PooyeshesModel(
//     this.pooyeshId,
//     this.pooyeshTitle,
//     this.pooyeshImageUrl,
//     this.description,
//     this.amount,
//     this.start,
//     this.end,
//     this.type_pay,
//   );
//   factory PooyeshesModel.fromeJsonMap(Map<String, dynamic> jsonObject) {
//     return PooyeshesModel(
//       jsonObject['id'],
//       jsonObject['title'],
//       jsonObject['image'],
//       jsonObject['description'],
//       jsonObject['amount'],
//       jsonObject['start'] ?? 'null',
//       jsonObject['end'] ?? 'null',
//       jsonObject['type_pay'] ?? 'null',
//     );
//   }
// }

// class ProjectModel {
//   int projectId;
//   String projectSlug;
//   String projectTitle;
//   String projectDescription;
//   String projectImageUrl;
//   int projectPishraft;
//   String projectTag;

//   ProjectModel(
//     this.projectId,
//     this.projectSlug,
//     this.projectTitle,
//     this.projectDescription,
//     this.projectImageUrl,
//     this.projectPishraft,
//     this.projectTag,
//   );
//   factory ProjectModel.fromeJsonMap(Map<String, dynamic> jsonObject) {
//     return ProjectModel(
//       jsonObject['id'],
//       jsonObject['slug'],
//       jsonObject['title'],
//       jsonObject['description'],
//       jsonObject['image_head'],
//       jsonObject['pishraft'] ?? 0,
//       jsonObject['tags'] ?? 'null',
//     );
//   }
// }
