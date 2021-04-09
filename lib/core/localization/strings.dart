class ApplicationStrings {
  static ApplicationStrings? _instance;
  static ApplicationStrings? get instance {
    if (_instance != null) {
      return _instance;
    }
    _instance = ApplicationStrings._init();
    return _instance;
  }

  ApplicationStrings._init();

  /// This class for the localization operations which can be done in the future.

  final String homepage = 'HomePage';
  final String categoryName = 'Category Name';
  final String productDetail = 'Product Detail';
  final String favourites = 'Favourites';
  final String youhaveNoFavourite = 'You have no favourite meal yet';
  final String hasAdded = 'Meal has been added to your favourites';
  final String hasDeleted = 'Meal has been deleted from your favourites';
  final String name = 'Name: ';
  final String category = 'Category: ';
  final String description = 'Description: ';
}
