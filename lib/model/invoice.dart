
class Invoice {
  String invoiceId, qrText, qrImage, qPayShortUrl;
  List<Deeplink> deeplinks;
  Invoice({
    this.invoiceId,
    this.qrText,
    this.qrImage,
    this.qPayShortUrl,
    this.deeplinks
  });
  factory Invoice.fromJson(Map<String, dynamic> json){
    var list = json['urls'] as List;
    List<Deeplink> urls = list.map((e) => Deeplink.fromJson(e)).toList();
    return Invoice(
      invoiceId: json['invoice_id'],
      qrText: json['qr_text'],
      qrImage: json['qr_image'],
      qPayShortUrl: json['qPay_shortUrl'],
      deeplinks: urls
    );
  }
}
class Deeplink {
  String name;
  String description;
  String logo;
  String link;
  Deeplink({
    this.name,
    this.description,
    this.logo,
    this.link
  });
  factory Deeplink.fromJson(Map<String, dynamic> json){
    return Deeplink(
      name: json['name'],
      description: json['description'],
      logo: json['logo'],
      link: json['link']
    );
  }
}