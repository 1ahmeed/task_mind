class HomeModel {
  HomeModel({
      this.status, 
      this.msg, 
      this.data,});

  HomeModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? msg;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.slider, 
      this.categories, 
      this.products, 
      this.selectedProducts, 
      this.newProducts,});

  Data.fromJson(dynamic json) {
    if (json['slider'] != null) {
      slider = [];
      json['slider'].forEach((v) {
        slider?.add(Slider.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    if (json['selected_products'] != null) {
      selectedProducts = [];
      json['selected_products'].forEach((v) {
        selectedProducts?.add(SelectedProducts.fromJson(v));
      });
    }
    if (json['new_products'] != null) {
      newProducts = [];
      json['new_products'].forEach((v) {
        newProducts?.add(NewProducts.fromJson(v));
      });
    }
  }
  List<Slider>? slider;
  List<Categories>? categories;
  List<Products>? products;
  List<SelectedProducts>? selectedProducts;
  List<NewProducts>? newProducts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (slider != null) {
      map['slider'] = slider?.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    if (selectedProducts != null) {
      map['selected_products'] = selectedProducts?.map((v) => v.toJson()).toList();
    }
    if (newProducts != null) {
      map['new_products'] = newProducts?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class NewProducts {
  NewProducts({
      this.id, 
      this.name, 
      this.shortDesc, 
      this.mainImage, 
      this.listPrice, 
      this.salePrice, 
      this.discount, 
      this.rating,});

  NewProducts.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    shortDesc = json['short_desc'];
    mainImage = json['main_image'];
    listPrice = json['list_price'];
    salePrice = json['sale_price'];
    discount = json['discount'];
    rating = json['rating'];
  }
  String? id;
  String? name;
  String? shortDesc;
  String? mainImage;
  String? listPrice;
  String? salePrice;
  String? discount;
  double? rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['short_desc'] = shortDesc;
    map['main_image'] = mainImage;
    map['list_price'] = listPrice;
    map['sale_price'] = salePrice;
    map['discount'] = discount;
    map['rating'] = rating;
    return map;
  }

}

class SelectedProducts {
  SelectedProducts({
      this.id, 
      this.name, 
      this.shortDesc, 
      this.mainImage, 
      this.listPrice, 
      this.salePrice, 
      this.discount, 
      this.rating,});

  SelectedProducts.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    shortDesc = json['short_desc'];
    mainImage = json['main_image'];
    listPrice = json['list_price'];
    salePrice = json['sale_price'];
    discount = json['discount'];
    rating = json['rating'];
  }
  String? id;
  String? name;
  String? shortDesc;
  String? mainImage;
  String? listPrice;
  String? salePrice;
  String? discount;
  dynamic rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['short_desc'] = shortDesc;
    map['main_image'] = mainImage;
    map['list_price'] = listPrice;
    map['sale_price'] = salePrice;
    map['discount'] = discount;
    map['rating'] = rating;
    return map;
  }

}

class Products {
  Products({
      this.id, 
      this.name, 
      this.shortDesc, 
      this.mainImage, 
      this.listPrice, 
      this.salePrice, 
      this.discount, 
      this.rating,});

  Products.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    shortDesc = json['short_desc'];
    mainImage = json['main_image'];
    listPrice = json['list_price'];
    salePrice = json['sale_price'];
    discount = json['discount'];
    rating = json['rating'];
  }
  String? id;
  String? name;
  String? shortDesc;
  String? mainImage;
  String? listPrice;
  String? salePrice;
  String? discount;
  dynamic rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['short_desc'] = shortDesc;
    map['main_image'] = mainImage;
    map['list_price'] = listPrice;
    map['sale_price'] = salePrice;
    map['discount'] = discount;
    map['rating'] = rating;
    return map;
  }

}

class Categories {
  Categories({
      this.id, 
      this.catName, 
      this.icon,});

  Categories.fromJson(dynamic json) {
    id = json['id'];
    catName = json['cat_name'];
    icon = json['icon'];
  }
  String? id;
  String? catName;
  String? icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['cat_name'] = catName;
    map['icon'] = icon;
    return map;
  }

}

class Slider {
  Slider({
      this.id, 
      this.productId, 
      this.image,});

  Slider.fromJson(dynamic json) {
    id = json['id'];
    productId = json['product_id'];
    image = json['image'];
  }
  String? id;
  String? productId;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_id'] = productId;
    map['image'] = image;
    return map;
  }

}