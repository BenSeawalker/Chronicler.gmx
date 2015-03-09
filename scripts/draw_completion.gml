///draw_completion(x,y,search_text,down,highlight_index)

var xx,yy,txt,down,hl;
    xx = argument0;
    yy = argument1;
    txt = argument2;
    down = argument3;
    hl = argument4;
    
var h;
    h = string_height("W");
    
//populate list
var lst = ds_list_create();
    ds_list_copy(lst,actionlist);
    with(obj_variable) if(type == vartype_global) ds_list_add(lst,name.text);
    with(obj_variable) if(type == vartype_temp) ds_list_add(lst,name.text);

//weed out uneeded
//if(txt != "")
//{
    for(var i=0;i<ds_list_size(lst);i++)
    {
        if(string_pos(txt,lst[|i]) != 1 || txt == lst[|i])
        {
            ds_list_delete(lst,i);
            i--;
        }
    }
//}

if(ds_list_size(lst))
{
    hl = min(hl,ds_list_size(lst)-1);
    var width,height;
        width = 0;
        height = min(h*10,h*ds_list_size(lst));
        for(var i=max(0,hl-((height/h)/2));i<ds_list_size(lst);i++)
        {
            width = max(width,string_width(lst[|i])+8);
        }
    
        
    //draw background
    if(down)
    {
        draw_rectangle_colour(xx,yy,xx+width,yy+height,c_menu,c_menu,c_menu,c_menu,false);
            draw_rectangle_colour(xx,yy,xx+width,yy+height,c_menu,c_menu,c_menu,c_menu,true);
    }
    else
    {
        draw_rectangle_colour(xx,yy,xx+width,yy-height,c_menu,c_menu,c_menu,c_menu,false);
            draw_rectangle_colour(xx,yy,xx+width,yy-height,c_menu,c_menu,c_menu,c_menu,true);
    }
    
    
    for(var i=max(0,hl-((height/h)/2));i<ds_list_size(lst);i++)
    {
        var pos = (i-max(0,hl-((height/h)/2)))
        if(pos*h >= height) break;
        
        if(down)
        {
            if(i == hl)
            {
                draw_set_alpha(0.1);
                    draw_rectangle_colour(xx+2,yy+2+pos*h,xx+width-2,yy+2+pos*h+h,c_aqua,c_aqua,c_aqua,c_aqua,false);
                draw_set_alpha(1);
            }
            draw_rectangle_colour(xx+2,yy+2+pos*h,xx+width-2,yy+2+pos*h+h,c_black,c_black,c_black,c_black,true);
            
            draw_text_colour(xx+4,yy+4+pos*h,lst[|i],c_text,c_text,c_text,c_text,1);
        }
        else
        {
            if(i == hl)
            {
                draw_set_alpha(0.1);
                    draw_rectangle_colour(xx+2,yy-2-pos*h,xx+width-2,yy-2-pos*h-h,c_aqua,c_aqua,c_aqua,c_aqua,false);
                draw_set_alpha(1);
            }
            draw_rectangle_colour(xx+2,yy-4-pos*h,xx+width-2,yy-4-pos*h-h,c_black,c_black,c_black,c_black,true);
            
            draw_text_colour(xx+4,yy-2-pos*h,lst[|i],c_text,c_text,c_text,c_text,1);
        }
    }
    
    ///*
    //if(keyboard_check_pressed(vk_up) && hl > 0)
    //    hl--;
    if(keyboard_check_pressed(vk_down) && hl == ds_list_size(lst)-1)
        keyboard_clear(vk_down);
    //*/
    
    var ret = "";
    if(keyboard_check_pressed(vk_tab)) ret = lst[|hl];
    
    ds_list_destroy(lst);
    return ret;
}

return "";


