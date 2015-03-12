//var path = get_open_filename("ChoiceScript|startup.txt","startup.txt");
var path = "C:\Users\Ben Seawalker\Downloads\choicescript-master\choicescript-master\web - Copy - Copy\mygame\scenes\startup_old.txt";
    path = "C:\Users\Ben Seawalker\Downloads\choicescript-master\choicescript-master\web\mygame\scenes\startup.txt";
if(path != "")
{
    obj_ctrl.alarm[1] = room_speed*60;
    clear_project();
    switch_GUI_mode(false);
    gamevars = "";
    with(obj_parent_bubble)instance_destroy();
    
    cs_proc_data(cs_to_data(path,true),0,0);
}
