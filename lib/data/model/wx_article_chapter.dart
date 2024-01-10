import 'package:json_annotation/json_annotation.dart';

part 'wx_article_chapter.g.dart';


@JsonSerializable()
class WxArticleChapter {

  @JsonKey(name: 'articleList')
  List<dynamic> articleList;

  @JsonKey(name: 'author')
  String author;

  @JsonKey(name: 'children')
  List<dynamic> children;

  @JsonKey(name: 'courseId')
  int courseId;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'lisense')
  String lisense;

  @JsonKey(name: 'lisenseLink')
  String lisenseLink;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'parentChapterId')
  int parentChapterId;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'userControlSetTop')
  bool userControlSetTop;

  @JsonKey(name: 'visible')
  int visible;

  WxArticleChapter(this.articleList,this.author,this.children,this.courseId,this.cover,this.desc,this.id,this.lisense,this.lisenseLink,this.name,this.order,this.parentChapterId,this.type,this.userControlSetTop,this.visible,);

  factory WxArticleChapter.fromJson(Map<String, dynamic> srcJson) => _$WxArticleChapterFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WxArticleChapterToJson(this);

}


