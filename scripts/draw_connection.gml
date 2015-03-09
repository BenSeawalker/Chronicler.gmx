///draw_connection(index,start_obj,linked_obj,colour)
var x1,x2,y1,y2, dx,dy, c,l, col, offset, ml, i;
i = argument0*8;
c = argument1;
l = argument2;
col = argument3;

offset = 24+i;
ml = (l.object_index==obj_bubble);//(l.object_index != obj_mlink);

x1 = c.x+c.width/2;
y1 = c.y+c.height;
x2 = l.x+l.width/2;
y2 = l.y+l.height/2;

dx = (x2-x1)/2;
dy = (y2-y1)/2;

//initial line
draw_line_colour(x1,y1,x1,y1+offset,col,col);

//horizontal
if(abs(dy)<offset+12+30*ml)
{
    //right
    if(dx>0)
    {
        draw_line_colour(x1,y1+offset,l.x-offset,y1+offset,col,col);
        draw_line_colour(l.x-offset,y1+offset,l.x-offset,y2+i,col,col);
        draw_arrow_colour(l.x-offset,y2+i,l.x,y2+i,16,col);
    }
    //left
    else
    {
        draw_line_colour(x1,y1+offset,l.x+l.width+offset,y1+offset,col,col);
        draw_line_colour(l.x+l.width+offset,y1+offset,l.x+l.width+offset,y2+i,col,col);
        draw_arrow_colour(l.x+l.width+offset,y2+i,l.x+l.width,y2+i,16,col);
    }
}
//vertical
// down
else if(dy>0)
{
    draw_line_colour(x1,y1+offset,x2+i,y1+offset,col,col);
    draw_arrow_colour(x2+i,y1+offset,x2+i,l.y-30*ml,16,col);
}
// up
else
{
    draw_line_colour(x1,y1+offset,x2+i,y1+offset,col,col);
    draw_arrow_colour(x2+i,y1+offset,x2+i,l.y+l.height+30,16,col);
}



/*
        var vd,vx,vy,vl, x1,y1,x2,y2;
            x1 = xx+c.width/2;
            y1 = y+height+c.height/2;
            x2 = l.x+l.width/2;
            y2 = l.y+l.height/2;
        // calculate angle & vector from value:
        vd = degtorad(point_direction(x2,y1,x1,y2));//pi * (v * 2 - 0.5)
        vx = cos(vd)
        vy = sin(vd)
        // normalize the vector, so it hits -1+1 at either side:
        vl = max(abs(vx), abs(vy))
        if (vl < 1) {
            vx /= vl
            vy /= vl
        }
        draw_arrow(x1,y1,x2+vx*l.width/2,y2+vy*l.height/2-20,16);
        */
