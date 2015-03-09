///sort_by_UID(ascending,scene)
var lst = ds_list_create();
var i,oid, ascending,iscene, blist;
ascending = argument0;
iscene = argument1;

if(iscene == noone) lst = allbubbles; else lst = iscene.bubbles;



for(i=1;i<ds_list_size(lst);i++)
{
 oid = lst[| i];
 
 if(ascending)
 {
  if(oid.UID<ds_list_find_value(lst,i-1).UID)
  {
   ds_list_delete(lst,i);
   ds_list_insert(lst,i-1,oid);
   i=1;
  }
 }
 else
 {
  if(oid.UID>ds_list_find_value(lst,i-1).UID)
  {
   ds_list_delete(lst,i);
   ds_list_insert(lst,i-1,oid);
   i=1;
  }
 }
}

for(i=0;i<ds_list_size(lst);i++)
{
    show_debug_message(object_get_name(lst[| i].object_index));
    if(lst[| i].start)
    {
        ds_list_delete(lst,i);
        ds_list_insert(lst,0,lst[| i]);
    }
}

return lst;