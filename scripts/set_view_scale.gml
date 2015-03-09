var s;
s = argument0;

var w,h;
w = view_wview[0];
h = view_hview[0];
view_wview[0] = view_wport[0]/s;
view_hview[0] = view_wview[0]/aspect_ratio;

if(view_wview[0]>w)
{
    view_xview[0] -= (view_wview[0]-w)/2;
    view_yview[0] -= (view_hview[0]-h)/2;
}
else
{
    view_xview[0] += (w-view_wview[0])/2;
    view_yview[0] += (h-view_hview[0])/2;
}


view_scale = view_wport[0]/view_wview[0];