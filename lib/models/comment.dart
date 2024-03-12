class Comment {
  int id = 0;
  int museumId = 0;
  String namaPengunggah = "";
  String tanggalUnggah = "";
  String komentar = "";

  // constructor
  Comment(
      {required this.id,
      required this.museumId,
      required this.namaPengunggah,
      required this.tanggalUnggah,
      required this.komentar});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    museumId = json['museumId'];
    namaPengunggah = json['namaPengunggah'];
    tanggalUnggah = json['tanggalUnggah'];
    komentar = json['komentar'];
  }

  // setter id
  void setId(int id) {
    this.id = id;
  }

  // getter id
  int getId() {
    return id;
  }

  // getter museumId
  int getMuseumId() {
    return museumId;
  }

  // setter museumId
  void setMuseumId(int museumId) {
    this.museumId = museumId;
  }

  // setter namaPengunggah
  void setNamaPengunggah(String namaPengunggah) {
    this.namaPengunggah = namaPengunggah;
  }

  // getter namaPengunggah
  String getNamaPengunggah() {
    return namaPengunggah;
  }

  // setter tanggalUnggah
  void setTanggalUnggah(String tanggalUnggah) {
    this.tanggalUnggah = tanggalUnggah;
  }

  // getter tanggalUnggah
  String getTanggalUnggah() {
    return tanggalUnggah;
  }

  // setter komentar
  void setKomentar(String komentar) {
    this.komentar = komentar;
  }

  // getter komentar
  String getKomentar() {
    return komentar;
  }
}

Comment comment1 = Comment(
  id: 1,
  museumId: 1,
  namaPengunggah: "Wendy Santoso",
  tanggalUnggah: "2022-09-24",
  komentar:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent id odio a mauris ultrices varius quis in diam. Quisque sit amet augue elit. Nulla convallis eget nisl in varius.",
);
Comment comment2 = Comment(
  id: 2,
  museumId: 1,
  namaPengunggah: "Clarissa Angelia",
  tanggalUnggah: "2022-09-27",
  komentar:
      "Nullam vitae lacus ligula. Vivamus ultrices ultricies libero sed faucibus. Integer elementum porttitor libero, sed placerat enim efficitur semper. Cras imperdiet metus sed nisi egestas malesuada. ",
);
Comment comment3 = Comment(
  id: 3,
  museumId: 2,
  namaPengunggah: "Jennifer Oentoro",
  tanggalUnggah: "2022-09-30",
  komentar:
      "Praesent venenatis sit amet nibh nec gravida. Ut ultrices consequat odio sed congue. Pellentesque in dictum elit. Vivamus vel volutpat eros. Nam quis fringilla arcu. Proin vel dignissim odio, molestie condimentum quam.",
);
Comment comment4 = Comment(
  id: 4,
  museumId: 2,
  namaPengunggah: "Eric Tedja",
  tanggalUnggah: "2022-10-05",
  komentar:
      "Pellentesque quis volutpat nisi, at ultrices dolor. Aenean eleifend, augue dapibus faucibus feugiat, urna mauris tincidunt est, eu iaculis dolor sem non nisl. Phasellus in dui finibus, congue enim vitae, tempor dui. Nulla facilisi. Donec molestie non lacus sit amet tempor.",
);
Comment comment5 = Comment(
  id: 5,
  museumId: 3,
  namaPengunggah: "Jeremy Dion P.",
  tanggalUnggah: "2022-10-10",
  komentar:
      "Nullam ac pulvinar arcu, sed interdum est. Pellentesque quis scelerisque velit. Phasellus dapibus dui at tempor dapibus.",
);
Comment comment6 = Comment(
  id: 6,
  museumId: 3,
  namaPengunggah: "Juan Christopher R. T.",
  tanggalUnggah: "2022-10-18",
  komentar:
      "Fusce vitae tellus ac ante condimentum porta. Proin ex quam, porta rutrum dapibus quis, blandit eu nibh. In hac habitasse platea dictumst. Nullam congue dignissim vehicula.",
);

List<Comment> listComment = [
  comment1,
  comment2,
  comment3,
  comment4,
  comment5,
  comment6
];
