///textbox_draw_simple(id, x1, y1, x2, y2)
var tbox,x1,y1,x2,y2, sh;
tbox = argument0;
x1 = argument1;
y1 = argument2;
x2 = argument3;
y2 = argument4;

//draw_set_font(tbox.font);
var c = tbox.color_text;
sh = string_height("W");


var i=0;
while((i*sh < ((y2-y1)-sh)) && (i < tbox.lines))
{
    var txt = "";
    var ii = 1;
    if(string_width(tbox.line[i])>abs(x2-x1))
        while(string_width(txt+string_char_at(tbox.line[i],ii))<abs(x2-x1)) txt += string_char_at(tbox.line[i],ii++);
    else
        txt = tbox.line[i];
    draw_text_colour(x1,y1+(i*sh),txt,c,c,c,c,draw_get_alpha());
    i++;
}
