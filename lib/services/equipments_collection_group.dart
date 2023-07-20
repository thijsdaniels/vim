import 'package:vim/models/exercise/equipment.dart';
import 'package:vim/services/collection_group.dart';

class EquipmentsCollectionGroup extends CollectionGroup<Equipment> {
  static EquipmentsCollectionGroup instance = EquipmentsCollectionGroup();

  EquipmentsCollectionGroup() : super(path: 'equipments');

  @override
  Equipment fromFirestore(snapshot, options) {
    return Equipment.fromFirestore(snapshot, options);
  }
}
