import '../../shared/models/field.dart';
import 'package:mobx/mobx.dart';
part 'form_error.store.g.dart';

class AddEditFormErrorState = _AddEditFormErrorState with _$AddEditFormErrorState;

abstract class _AddEditFormErrorState with Store {
  @observable
  GenericFormField name = GenericFormField();

  @observable
  GenericFormField phone = GenericFormField();

  @observable
  GenericFormField photo = GenericFormField();

  @computed
  bool get hasErrors {
    if (name.hasError == null ||
        phone.hasError == null ||
        photo.hasError == null ||
        name.hasError ||
        phone.hasError ||
        photo.hasError) {
      return true;
    }
    return false;
  }
}
