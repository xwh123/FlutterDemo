class BannerEntity {
	String count;
	String infocode;
	List<BannerGeocode> geocodes;
	String status;
	String info;

	BannerEntity({this.count, this.infocode, this.geocodes, this.status, this.info});

	BannerEntity.fromJson(Map<String, dynamic> json) {
		count = json['count'];
		infocode = json['infocode'];
		if (json['geocodes'] != null) {
			geocodes = new List<BannerGeocode>();(json['geocodes'] as List).forEach((v) { geocodes.add(new BannerGeocode.fromJson(v)); });
		}
		status = json['status'];
		info = json['info'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['count'] = this.count;
		data['infocode'] = this.infocode;
		if (this.geocodes != null) {
      data['geocodes'] =  this.geocodes.map((v) => v.toJson()).toList();
    }
		data['status'] = this.status;
		data['info'] = this.info;
		return data;
	}
}

class BannerGeocode {
	String country;
	String formattedAddress;
	String city;
	String level;
	String adcode;
	BannerGeocodesBuilding building;
	String number;
	String citycode;
	String province;
	String street;
	String district;
	String location;
	BannerGeocodesNeighborhood neighborhood;
	List<Null> township;

	BannerGeocode({this.country, this.formattedAddress, this.city, this.level, this.adcode, this.building, this.number, this.citycode, this.province, this.street, this.district, this.location, this.neighborhood, this.township});

	BannerGeocode.fromJson(Map<String, dynamic> json) {
		country = json['country'];
		formattedAddress = json['formatted_address'];
		city = json['city'];
		level = json['level'];
		adcode = json['adcode'];
		building = json['building'] != null ? new BannerGeocodesBuilding.fromJson(json['building']) : null;
		number = json['number'];
		citycode = json['citycode'];
		province = json['province'];
		street = json['street'];
		district = json['district'];
		location = json['location'];
		neighborhood = json['neighborhood'] != null ? new BannerGeocodesNeighborhood.fromJson(json['neighborhood']) : null;
		if (json['township'] != null) {
			township = new List<Null>();
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['country'] = this.country;
		data['formatted_address'] = this.formattedAddress;
		data['city'] = this.city;
		data['level'] = this.level;
		data['adcode'] = this.adcode;
		if (this.building != null) {
      data['building'] = this.building.toJson();
    }
		data['number'] = this.number;
		data['citycode'] = this.citycode;
		data['province'] = this.province;
		data['street'] = this.street;
		data['district'] = this.district;
		data['location'] = this.location;
		if (this.neighborhood != null) {
      data['neighborhood'] = this.neighborhood.toJson();
    }
		if (this.township != null) {
      data['township'] =  [];
    }
		return data;
	}
}

class BannerGeocodesBuilding {
	List<Null> name;
	List<Null> type;

	BannerGeocodesBuilding({this.name, this.type});

	BannerGeocodesBuilding.fromJson(Map<String, dynamic> json) {
		if (json['name'] != null) {
			name = new List<Null>();
		}
		if (json['type'] != null) {
			type = new List<Null>();
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.name != null) {
      data['name'] =  [];
    }
		if (this.type != null) {
      data['type'] =  [];
    }
		return data;
	}
}

class BannerGeocodesNeighborhood {
	List<Null> name;
	List<Null> type;

	BannerGeocodesNeighborhood({this.name, this.type});

	BannerGeocodesNeighborhood.fromJson(Map<String, dynamic> json) {
		if (json['name'] != null) {
			name = new List<Null>();
		}
		if (json['type'] != null) {
			type = new List<Null>();
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.name != null) {
      data['name'] =  [];
    }
		if (this.type != null) {
      data['type'] =  [];
    }
		return data;
	}
}
