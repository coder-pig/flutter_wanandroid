import 'package:json_annotation/json_annotation.dart';

part 'index_banner_info.g.dart';


@JsonSerializable()
class IndexBannerInfo extends Object {

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'imagePath')
  String imagePath;

  @JsonKey(name: 'isVisible')
  int isVisible;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'url')
  String url;

  IndexBannerInfo(this.desc,this.id,this.imagePath,this.isVisible,this.order,this.title,this.type,this.url,);

  factory IndexBannerInfo.fromJson(Map<String, dynamic> srcJson) => _$IndexBannerInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IndexBannerInfoToJson(this);

}


