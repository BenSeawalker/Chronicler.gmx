///add_sidebar_component(sidebar,title,colour,text_colour, action);

var sb,t,col,tcol,act;
sb = argument0;
t = argument1;
col = argument2;
tcol = argument3;
act = argument4; //script

var mw = 0;
with(instance_create(sb.x,sb.y,obj_sidebar_component))
{
    title = t;
    colour = col;
    text_colour = tcol;
    action = act;
    minwidth = string_width(t)+16;
    //width = minwidth;
    //targetwidth = width;
    
    ds_list_add(sb.components,id);
    
    sb.width = max(sb.width, minwidth+64);
    sb.maxh = 64-8;
    for(var i=0;i<ds_list_size(sb.components);i++)
    {
        sb.maxh += (sb.components[| i].height+8);
    }
    
    minwidth = max(minwidth,sb.width-64);
    maxwidth = minwidth+8;
}