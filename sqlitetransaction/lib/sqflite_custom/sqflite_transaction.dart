import 'package:sqflite/sqflite.dart';

typedef TransactionActivity<T>(SQFLiteTransaction scope, Database db);
class SQFLiteTransaction {
  static int _state = 0; 
  static int _transState = 0;
  void complete() 
  {
    SQFLiteTransaction._transState--;
  }

  static void beginTrans({Database db, TransactionActivity transactionScope}) async 
  {
    if (SQFLiteTransaction._state < 0) 
    {
      SQFLiteTransaction._state = 0;
      SQFLiteTransaction._transState = 0;
    }
    
    if (SQFLiteTransaction._state == 0) 
    {
      db.execute("BEGIN TRANSACTION");
    }

    SQFLiteTransaction scope = new SQFLiteTransaction();
    SQFLiteTransaction._state++;
    SQFLiteTransaction._transState++;

    try 
    {
      await transactionScope(scope, db);
    }
    catch (e) 
    {
      SQFLiteTransaction._state = -1;
      db.execute("ROLLBACK TRANSACTION");
      throw e;
    }
    
    SQFLiteTransaction._state--;
    if (SQFLiteTransaction._state == 0) 
    {
      if (SQFLiteTransaction._transState == 0) 
      {
        db.execute("COMMIT TRANSACTION");
      } 
      else 
      {
        db.execute("ROLLBACK TRANSACTION");
      }

      SQFLiteTransaction._state = -1;
      SQFLiteTransaction._transState = -1;
    }
  }
}