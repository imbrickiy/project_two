class Data {
  Data({required this.result});

  final Result? result;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );
  }

  Map<String, dynamic> toJson() => {"result": result?.toJson()};
}

class Result {
  Result({required this.tags, required this.genre, required this.stations});

  final List<Genre> tags;
  final List<Genre> genre;
  final List<Station> stations;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      tags: json["tags"] == null
          ? []
          : List<Genre>.from(json["tags"]!.map((x) => Genre.fromJson(x))),
      genre: json["genre"] == null
          ? []
          : List<Genre>.from(json["genre"]!.map((x) => Genre.fromJson(x))),
      stations: json["stations"] == null
          ? []
          : List<Station>.from(
              json["stations"]!.map((x) => Station.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "tags": tags.map((x) => x.toJson()).toList(),
    "genre": genre.map((x) => x.toJson()).toList(),
    "stations": stations.map((x) => x.toJson()).toList(),
  };
}

class Genre {
  Genre({
    required this.id,
    required this.name,
    required this.detailPicture,
    required this.picture,
    required this.svg,
    required this.pdf,
  });

  final int? id;
  final String? name;
  final String? detailPicture;
  final String? picture;
  final String? svg;
  final String? pdf;

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json["id"],
      name: json["name"],
      detailPicture: json["detail_picture"],
      picture: json["picture"],
      svg: json["svg"],
      pdf: json["pdf"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "detail_picture": detailPicture,
    "picture": picture,
    "svg": svg,
    "pdf": pdf,
  };
}

class Station {
  Station({
    required this.id,
    required this.prefix,
    required this.title,
    required this.tooltip,
    required this.sort,
    required this.bgColor,
    required this.bgImage,
    required this.bgImageMobile,
    required this.svgOutline,
    required this.svgFill,
    required this.pdfOutline,
    required this.pdfFill,
    required this.shortTitle,
    required this.iconGray,
    required this.iconFillColored,
    required this.iconFillWhite,
    required this.stationNew,
    required this.newDate,
    required this.stream64,
    required this.stream128,
    required this.stream320,
    required this.streamHls,
    required this.genre,
    required this.detailPageUrl,
    required this.shareUrl,
    required this.mark,
    required this.updated,
  });

  final int? id;
  final String? prefix;
  final String? title;
  final String? tooltip;
  final int? sort;
  final dynamic bgColor;
  final String? bgImage;
  final String? bgImageMobile;
  final String? svgOutline;
  final String? svgFill;
  final String? pdfOutline;
  final String? pdfFill;
  final String? shortTitle;
  final String? iconGray;
  final String? iconFillColored;
  final String? iconFillWhite;
  final bool? stationNew;
  final String? newDate;
  final String? stream64;
  final String? stream128;
  final String? stream320;
  final String? streamHls;
  final List<Genre> genre;
  final String? detailPageUrl;
  final String? shareUrl;
  final String? mark;
  final String? updated;

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json["id"],
      prefix: json["prefix"],
      title: json["title"],
      tooltip: json["tooltip"],
      sort: json["sort"],
      bgColor: json["bg_color"],
      bgImage: json["bg_image"],
      bgImageMobile: json["bg_image_mobile"],
      svgOutline: json["svg_outline"],
      svgFill: json["svg_fill"],
      pdfOutline: json["pdf_outline"],
      pdfFill: json["pdf_fill"],
      shortTitle: json["short_title"],
      iconGray: json["icon_gray"],
      iconFillColored: json["icon_fill_colored"],
      iconFillWhite: json["icon_fill_white"],
      stationNew: json["new"],
      newDate: json["new_date"],
      stream64: json["stream_64"],
      stream128: json["stream_128"],
      stream320: json["stream_320"],
      streamHls: json["stream_hls"],
      genre: json["genre"] == null
          ? []
          : List<Genre>.from(json["genre"]!.map((x) => Genre.fromJson(x))),
      detailPageUrl: json["detail_page_url"],
      shareUrl: json["shareUrl"],
      mark: json["mark"],
      updated: json["updated"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "prefix": prefix,
    "title": title,
    "tooltip": tooltip,
    "sort": sort,
    "bg_color": bgColor,
    "bg_image": bgImage,
    "bg_image_mobile": bgImageMobile,
    "svg_outline": svgOutline,
    "svg_fill": svgFill,
    "pdf_outline": pdfOutline,
    "pdf_fill": pdfFill,
    "short_title": shortTitle,
    "icon_gray": iconGray,
    "icon_fill_colored": iconFillColored,
    "icon_fill_white": iconFillWhite,
    "new": stationNew,
    "new_date": newDate,
    "stream_64": stream64,
    "stream_128": stream128,
    "stream_320": stream320,
    "stream_hls": streamHls,
    "genre": genre.map((x) => x.toJson()).toList(),
    "detail_page_url": detailPageUrl,
    "shareUrl": shareUrl,
    "mark": mark,
    "updated": updated,
  };
}
