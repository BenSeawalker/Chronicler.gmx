///add_sidebar_to_group(group,sidebar);

var sg,sb;
sg = argument0;
sb = argument1;

ds_list_add(sg.sidebars,sb);

var mw = 0;
for(var i=0;i<ds_list_size(sg.sidebars);i++)
{
    sb = sg.sidebars[| i];
    if(sb.sminw > mw) mw = sb.sminw;
}

for(var i=0;i<ds_list_size(sg.sidebars);i++)
{
    sb = sg.sidebars[| i];
    sb.sminw = mw;
    sb.smaxw = mw+6;
}