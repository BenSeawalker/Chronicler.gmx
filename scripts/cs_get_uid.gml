///cs_get_uid(lines,uid)

var lns = argument0;
var u = argument1;
var mp = -1;

for(var ii=0;ii<ds_list_size(lns);ii++)
{
    var mp = lns[|ii];
    if(mp[?"uid"] == u)
        return mp;
}

return mp;
