///get_label(scene,bubble)
var scene,b;
scene = argument0;
b = argument1;

var retval = b.label;

if(b.object_index == obj_bubble)
{
    var txt = string_replace_all(b.title.text," ","_");
    
    var achars;
        achars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_123456789";
    
    retval = "";
    for(var i=1;i<=string_length(txt);i++)
    {
        var c = string_char_at(txt,i);
        if(string_pos(c,achars)) retval += c;
    }
    
    var duplicate = false;
    for(var i=0;i<ds_list_size(scene.bubbles) && !duplicate;i++)
    {
        if(scene.bubbles[|i].object_index == obj_bubble)
        {
            if(scene.bubbles[|i] != b)
            {
                if(scene.bubbles[|i].object_index == obj_bubble)
                {
                    duplicate = (scene.bubbles[|i].tbox.text == b.tbox.text);
                }
                else if(scene.bubbles[|i].object_index == obj_action)
                {
                    duplicate = (string_replace(scene.bubbles[|i].tbox.text,"*label ","") == b.title.text);
                }
            }
        }
    }
    if(duplicate)
        retval += "_"+string(b.UID);
}
else if(b.object_index == obj_action)
{
    if(string_pos("*label ",b.tbox.text))
    {
        var txt = string_replace(b.tbox.text,"*label ","");
            //txt = string_replace_all(b.tbox.text," ","_");
    
        var achars;
            achars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz_123456789";
        
        retval = "";
        for(var i=1;i<=string_length(txt);i++)
        {
            var c = string_char_at(txt,i);
            if(string_pos(c,achars)) retval += c;
        }
        
        var duplicate = false;
        for(var i=0;i<ds_list_size(scene.bubbles) && !duplicate;i++)
        {
            if(scene.bubbles[|i] != b)
            {
                if(scene.bubbles[|i].object_index == obj_bubble)
                {
                    duplicate = (scene.bubbles[|i].title.text == string_replace(scene.bubbles[|i].tbox.text,"*label ",""));
                }
                else if(scene.bubbles[|i].object_index == obj_action)
                {
                    duplicate = (scene.bubbles[|i].tbox.text == b.tbox.text);
                }
            }
        }
        if(duplicate)
            retval += "_"+string(b.UID);
    }
}

b.label = retval;

return retval;
