/// Module: todolist
module todolist::todolist;


// === Imports ===
use std::string::String;

// === Errors ===
const E_ITEM_NOT_FOUND: u64 = 0;

// === Structs ===
/// ToDoList struct'ı
public struct ToDolist has key, store{
  id: UID,
  items: vector<String>,
}

// === Public Functions ===
///Yeni ToDolist Oluşturma
public fun new(ctx: &mut TxContext){
  let list=ToDolist{
    id:object::new(ctx),
    items:vector[],
  };
  transfer::public_share_object(list)
}
///ToDoListe'e yeni item ekleme
public fun add_item(list:&mut ToDolist, item:String){
  list.items.push_back(item);
}
///ToDoList'ten item çıkarma
public fun remove_item(list:&mut ToDolist, item:String){
  ////İlk yöntem: Payload Item yerine index verilebilir.--> remove_item(list:&mut ToDolist, index:u64)
  // list.items.remove(index);

  ////İkinci yöntem: Payload Item'ı direk string olarak verilebilir.
  /// while döngüsü ile index değişkeni vector'in uzunluğuna kadar aranıyor. 
  /// Item vector'de varsa index'e göre item vector'den siliniyor. Found değişkeni true yapılıyor. Döngüden çıkılıyor.
  /// Eğer item vector'de yoksa found false kalıyor ve döngüden çıkılıyor.Sonrasında item vector'de olmadığı için E_ITEM_NOT_FOUND hatası döndürülüyor.
  let mut index = 0;
  let mut found = false;
  while(index < list.items.length()){
    if(list.items[index]==item){
      list.items.remove(index);
      found = true;
      break
    }else {
      index = index + 1;
    }
  };
  assert!(found, E_ITEM_NOT_FOUND);
}
///ToDoList objesini silme
public fun delete_list(list: ToDolist){
  let ToDolist{id,items: _} = list;
  id.delete();
}


