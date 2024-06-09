import 'package:sqflite/sqflite.dart';

import 'migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute(
      '''
        CREATE TABLE todo (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          descricao VARCHAR(500) NOT NULL,
          data_hora DATETIME,
          finalizado INTEGER,
          user_id VARCHAR(100) NOT NULL
        )
      ''',
    );
  }

  @override
  void update(Batch batch) {}
}
