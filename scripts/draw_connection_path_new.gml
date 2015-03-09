///draw_connection_path(x1,y1,l,colour,side)
var x1,y1,x2,y2,l,colour,side;
    x1 = argument0;
    y1 = argument1;
    l = argument2;
        x2 = l.x+l.width/2;
        y2 = l.y+l.height/2;
    colour = argument3;
    side = argument4;
    
var dx,dy,offset,ml;
    dx = (x2-x1)/2;//abs(x1-x2);
    dy = (y2-y1)/2;//abs(y1-y2);
    offset = 24;//max(dx,dy)/10;
    ml = (l.object_index==obj_bubble);
    
var path;
    path = path_add();
        path_set_kind(path,0);
        path_set_closed(path,false);

    path_add_point(path,x1,y1,0);
    if(side)
    {
        path_add_point(path,x1+offset,y1,0);
    }
    else
    {
        path_add_point(path,x1,y1+offset,0);
        
        
        //horizontal
        if(abs(dy)<offset+12+30*ml)
        {
            //right
            if(dx>0)
            {
                path_add_point(path,l.x-offset,y1+offset,0);
                path_add_point(path,l.x-offset,y2,0);
                path_add_point(path,l.x,y2,0);
                draw_arrow_colour(l.x-offset,y2,l.x,y2,16,colour);
                //draw_line_colour(x1,y1+offset,l.x-offset,y1+offset,col,col);
                //draw_line_colour(l.x-offset,y1+offset,l.x-offset,y2+i,col,col);
                //draw_arrow_colour(l.x-offset,y2+i,l.x,y2+i,16,col);
            }
            //left
            else
            {
                path_add_point(path,l.x+l.width+offset,y1+offset,0);
                path_add_point(path,l.x+l.width+offset,y2,0);
                path_add_point(path,l.x+l.width,y2,0);
                draw_arrow_colour(l.x+l.width+offset,y2,l.x+l.width,y2,16,colour);
                //draw_line_colour(x1,y1+offset,l.x+l.width+offset,y1+offset,col,col);
                //draw_line_colour(l.x+l.width+offset,y1+offset,l.x+l.width+offset,y2+i,col,col);
                //draw_arrow_colour(l.x+l.width+offset,y2+i,l.x+l.width,y2+i,16,col);
            }
        }
        //vertical
        // down
        else if(dy>0)
        {
            path_add_point(path,x2,y1+offset,0);
            path_add_point(path,x2,l.y-30*ml,0);
            draw_arrow_colour(x2,l.y-30*ml-offset,x2,l.y-30*ml,16,colour);
            //draw_line_colour(x1,y1+offset,x2+i,y1+offset,col,col);
            //draw_arrow_colour(x2+i,y1+offset,x2+i,l.y-30*ml,16,col);
        }
        // up
        else
        {
            path_add_point(path,x2,y1+offset,0);
            path_add_point(path,x2,l.y+l.height+30,0);
            draw_arrow_colour(x2,l.y+l.height+30+16,x2,l.y+l.height+30,16,colour);
            //draw_line_colour(x1,y1+offset,x2+i,y1+offset,col,col);
            //draw_arrow_colour(x2+i,y1+offset,x2+i,l.y+l.height+30,16,col);
        }
    }
    

var pc = draw_get_colour();
draw_set_colour(colour);
    draw_path(path,x1,y1,true);
draw_set_colour(pc);

path_delete(path);
