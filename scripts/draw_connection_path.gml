///draw_connection_path(x1,y1,link,colour,side)
var x1,y1,x2,y2,link,colour,side;
    x1 = argument0;
    y1 = argument1;
    link = argument2;
        x2 = link.x+link.width/2;
        y2 = link.y;
    colour = argument3;
    side = argument4;
    
var diffx,diffy,offset;
    diffx = abs(x1-x2);
    diffy = abs(y1-y2);
    offset = 32;//max(diffx,diffy)/10;

var path;
    path = path_add();
        path_set_kind(path,1);
        path_set_closed(path,false);

    path_add_point(path,x1,y1,0);
    if(side)
        path_add_point(path,x1+offset,y1,0);
    else
        path_add_point(path,x1,y1+offset,0);
    
    path_add_point(path,x1+(x2-x1)/2,y1+(y2+link.height/2-y1)/2,0);
    
    //horizontal
    /*if(diffy < offset*2)
    {
        //right
        if(x2 > x1)
        {
            path_add_point(path,x2-offset,y2+link.height/2,0);
            path_add_point(path,x2,y2+link.height/2,0);
        }
        //left
        else
        {
            path_add_point(path,x2+link.width+offset,y2+link.height/2,0);
            path_add_point(path,x2+link.width,y2+link.height/2,0);
        }
    }
    //vertical
    //else*/
    {
        //top
        if(y2 > y1)
        {
            path_add_point(path,x2,y2-offset,0);
            path_add_point(path,x2,y2-16,0);
            draw_arrow_colour(x2,y2-16,x2,y2,16,colour);
        }
        //bottom
        else
        {
            path_add_point(path,x2,y2+link.height+24+offset,0);
            path_add_point(path,x2,y2+link.height+24,0);
            draw_arrow_colour(x2,y2+link.height+24+16,x2,y2+link.height+24,16,colour);
        }
    }
    

var pc = draw_get_colour();
draw_set_colour(colour);
    draw_path(path,x1,y1,true);
draw_set_colour(pc);

path_delete(path);
