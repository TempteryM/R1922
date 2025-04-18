// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_article.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsArticleAdapter extends TypeAdapter<NewsArticle> {
  @override
  final int typeId = 19;

  @override
  NewsArticle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsArticle(
      title: fields[1] as String,
      urlButton: fields[0] as String,
      urlImage: fields[2] as String,
      dateNews: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NewsArticle obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.urlButton)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.urlImage)
      ..writeByte(3)
      ..write(obj.dateNews);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsArticleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
