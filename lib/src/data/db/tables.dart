part of 'db.dart';

@DataClassName('DbRestaurant')
class Restaurant extends Table {
  TextColumn get id => text().map(const UlidDbConverter())();

  TextColumn get name => text()();

  @override
  Set<Column>? get primaryKey => {id};
}

@DataClassName('DbRestaurantRoom')
class RestaurantRoom extends Table {
  TextColumn get id => text().map(const UlidDbConverter())();

  TextColumn get name => text()();

  TextColumn get restaurant => text().references(Restaurant, #id)();

  @override
  Set<Column>? get primaryKey => {id};
}

@DataClassName('DbRoomTable')
class RoomTable extends Table {
  TextColumn get id => text().map(const UlidDbConverter())();

  TextColumn get name => text()();

  TextColumn get room => text().references(RestaurantRoom, #id)();

  TextColumn get waiter => text().nullable().references(RestaurantStaff, #id)();

  @override
  Set<Column>? get primaryKey => {id};
}

@DataClassName('DbUser')
class User extends Table {
  TextColumn get id => text().map(const UlidDbConverter())();

  TextColumn get name => text()();

  @override
  Set<Column>? get primaryKey => {id};
}

@DataClassName('DbRestaurantStaff')
class RestaurantStaff extends Table {
  TextColumn get id => text().map(const UlidDbConverter())();

  TextColumn get restaurant => text().references(Restaurant, #id)();

  TextColumn get employee => text().references(User, #id)();

  @override
  Set<Column>? get primaryKey => {id};
}

@DataClassName('DbProductCategory')
class ProductCategory extends Table {
  TextColumn get id => text().map(const UlidDbConverter())();

  TextColumn get name => text()();

  @override
  Set<Column>? get primaryKey => {id};
}

@DataClassName('DbProduct')
class Product extends Table {
  TextColumn get id => text().map(const UlidDbConverter())();

  TextColumn get category => text().references(ProductCategory, #id)();

  TextColumn get name => text()();

  @override
  Set<Column>? get primaryKey => {id};
}

@DataClassName('DbRestaurantProduct')
class RestaurantProduct extends Table {
  TextColumn get id => text().map(const UlidDbConverter())();

  TextColumn get product => text().references(Product, #id)();

  TextColumn get restaurant => text().references(Restaurant, #id)();

  TextColumn get price => text().map(const MoneyDbConverter())();

  @override
  Set<Column>? get primaryKey => {id};
}

@DataClassName('DbOrder')
class Order extends Table {
  TextColumn get id => text().map(const UlidDbConverter())();

  TextColumn get roomTable => text().references(RoomTable, #id)();

  TextColumn get waiter => text().references(RestaurantStaff, #id)();

  TextColumn get status => textEnum<OrderStatus>()();

  TextColumn get totalPrice => text().map(const MoneyDbConverter())();

  TextColumn get comment => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column>? get primaryKey => {id};
}

@DataClassName('DbOrderProduct')
class OrderProduct extends Table {
  TextColumn get order => text().references(Order, #id)();

  TextColumn get product => text().references(RestaurantProduct, #id)();

  IntColumn get qty => integer()();

  @override
  Set<Column>? get primaryKey => {order, product};
}
