class Question {
  String libelle;
  String image;
  String explication;
  bool reponse;
  String extension;

  Question(this.libelle, this.image, this.explication, this.reponse, {this.extension});

  String resolveImagePath() {
    String ext = this.extension ?? 'jpg';
    return 'assets/images/$image.$ext';
  }
}
