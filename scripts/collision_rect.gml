///collision_rect(x1,y1,width1,height1,x2,y2,width2,height2,accuracy)
var x1,y1,w1,h1, x2,y2,w2,h2, a;
x1 = argument0;
y1 = argument1;
w1 = argument2;
h1 = argument3;

x2 = argument4;
y2 = argument5;
w2 = argument6;
h2 = argument7;

a = argument8;

var xx,yy;
for(xx=0;xx<w2;xx+=a)
{
    for(yy=0;yy<h2;yy+=a)
    {
        if(in_rect(x2+min(xx,w2),y2+min(yy,h2),x1,y1,w1,w2)) return true;
    }
}

return false;