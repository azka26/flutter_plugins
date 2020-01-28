import './model_base.dart';

abstract class FilterBase<T extends ModelBase> 
{
  ModelBase modelInstance;
  FilterBase(T instance) {
    this.modelInstance = instance;
  }
}
