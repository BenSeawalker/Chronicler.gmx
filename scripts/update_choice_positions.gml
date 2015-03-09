with(argument0)
{
    var i,pw,cg;
    pw=5;
    cg = (ds_list_size(choices)>2);
    for(i=cg;i<ds_list_size(choices);i++)
    {
        if(i>cg) pw+=choices[| i-1].width;
        with(choices[| i])
        {
            x = other.x+pw;
            y = other.y+other.height;
        }
    }
}