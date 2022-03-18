List product_calistir() {
  List users_product = [];
  var product1 = Product(productname: "milk",shelfLife: 10);
  var product2 = Product(productname: "milk", shelfLife: 4);
  var product3 = Product(productname: "milk", shelfLife: 7);
  var product4 = Product(productname: "pea",shelfLife: 9);
  var product5 = Product(productname: "pea",shelfLife: 5);
  var product6 = Product(productname: "apple",shelfLife: 5);
  users_product = product1.listupdater(users_product) ;
  users_product = product2.listupdater(users_product) ;
  users_product = product3.listupdater(users_product) ;
  users_product = product4.listupdater(users_product) ;
  users_product = product5.listupdater(users_product) ;
  users_product = product6.listupdater(users_product) ;
  product2.listremover(users_product);
  users_product = product2.listupdater(users_product) ;
  return users_product;
}

class Product{
  Product({this.productname="",this.shelfLife=0});
  String productname;
  int shelfLife;
  int id = 0;
  DateTime expirationDate = DateTime.now();

  List listupdater(List updatedList){
    this.id = 1;
    int check = 0;
    DateTime exp = this.expirationDate;
    if (updatedList.length > 0) {
      while (check == 0){
        check = 1;
        for (int i = 0; i < updatedList.length; i = i+1 ){
          if (updatedList[i].productname == this.productname){
            if (updatedList[i].id == this.id){
              this.id ++;
              check = 0;
            }
          }
        }
      }
    }
    this.expirationDate = exp.add(Duration(days: this.shelfLife, hours: 0, minutes: 0));
    updatedList.add(this);
    return updatedList;
  }
  void listremover(List updatedList){
    updatedList.remove(this);
    // print('removed => ${this.productname}');
  }
}