abstract final class AppRoutes {
  static const list = '/';
  static const artistDetail = 'artist/:$artistIdParam';
  static const artistIdParam = 'id';

  static String artist(String id) => '/artist/$id';
}
