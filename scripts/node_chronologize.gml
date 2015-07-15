///node_chronologize(ds_list nodes, ds_list order, ds_list links, obj_node node, int position, obj_node previous);
/*
var nodes, order, links, node, position, previous;
    nodes = argument0;
    order = argument1;
    links = argument2;
    node = argument3;
    position = argument4;
    previous = argument5;

var index = ds_list_find_index(nodes, node);

//if the node exists in the list
if(index > -1)
{
    //if not the first bubble and the link hasn't already been tested...
    if((previous == -1) || (!ds_map_find_value(links[|index],previous)))
    {
        //if the current position in the tree is less than position
        //assign the later position to the node
        if(order[|index] < position) order[|index] = position;
        
        //mark this connection as tested
        ds_map_replace(links[|index],previous,true);
        
        with(node)
        {
            //loop through all the links the node is connected to
            for(var i=0;i<ds_list_size(output.links);i++)
            {
                //if the link is valid,
                //chronologize the next node with position + 1
                if(output.link[|i] != noone)
                    node_chronologize(nodes, order, links, output.link[|i], position+1, id);
            }
        }
    }
}
*/
