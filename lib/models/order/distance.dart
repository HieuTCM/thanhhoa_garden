class Distance {
  late final distancePriceID;
  late double? pricePerKm;
  late final applyDate;
  late final status;

  Distance(
      {this.distancePriceID, this.pricePerKm, this.applyDate, this.status});

  Distance.fromJson(Map<String, dynamic> json) {
    distancePriceID = json["distancePriceID"];
    pricePerKm = json["pricePerKm"];
    applyDate = json["applyDate"];
    status = json["status"];
  }
}
