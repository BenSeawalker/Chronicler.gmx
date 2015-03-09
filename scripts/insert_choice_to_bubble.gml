///insert_choice_to_bubble(owner,choice,index);
var owner,c,ind;
owner = argument0;
c = argument1;
ind = argument2;

ds_list_insert(owner.choices,ind,c);

//handle bubble size
owner.minwidth = max(180,30+owner.choices[| 0].minwidth*ds_list_size(owner.choices));
owner.targetwidth = max(owner.targetwidth,owner.minwidth);
