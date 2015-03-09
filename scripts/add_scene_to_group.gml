///add_scene_to_group(group,scene);
var sg = argument0;
var sb = argument1;


ds_list_add(sg.scenes,sb);

var mw = 0;
for(var i=0;i<ds_list_size(sg.scenes);i++)
{
    sb = sg.scenes[| i];
    if(sb.minwidth > mw) mw = sb.minwidth;
}

for(var i=0;i<ds_list_size(sg.scenes);i++)
{
    sb = sg.scenes[| i];
    sb.minwidth = mw;
    sb.maxwidth = mw+6;
}