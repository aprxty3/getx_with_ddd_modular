import 'package:getx_with_ddd_modular/app/network/provider/api_provider.dart';
import 'package:getx_with_ddd_modular/app/network/provider/db_provider.dart';

class DataSourceRepository {
  APIProvider apiProvider;
  DBProvider dbProvider;

  DataSourceRepository({required this.apiProvider, required this.dbProvider});
}
