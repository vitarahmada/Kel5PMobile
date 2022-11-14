class TransaksiModel {
  int? id, type, total;
  String? ket, kategori, createdAt, updatedAt;

  TransaksiModel(
      {this.id,
      this.type,
      this.total,
      this.ket,
      this.kategori,
      this.createdAt,
      this.updatedAt});

  factory TransaksiModel.fromJson(Map<String, dynamic> json) {
    return TransaksiModel(
        id: json['id'],
        type: json['type'],
        total: json['total'],
        ket: json['ket'],
        kategori: json['kategori'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}