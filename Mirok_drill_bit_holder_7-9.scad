// Parametric stackable DIN-rail mount drill bit holder
//It is licensed under the Creative Commons - GNU GPL license.
// © 2014-2015 by Petr Mironkin neharon@ya.ru
// If you like this holder you can donate, please use
// https://www.paypal.me/mirok

include <Mirok_drill_bit_holder.scad>;

//if you need more acuracy dovetail joint use a little less tolerance
tolerance= +0.08; 
din_rail_mounts_dovetail_tolerance_multiplier=10; //Increase this param for easy dovetail joining


//DIN rail params
din_rail_mount_width=35;
din_rail_mount_height=7;
din_rail_mount_inner_width=27;
din_rail_step=din_rail_mount_width+din_rail_mount_inner_width;
din_rail_ledge=(din_rail_mount_width-din_rail_mount_inner_width)/2;

//This params for dovetail joint two or more holders  
//Don't ask me why, just use
din_rail_mounts_ZX_magical_param=4;
din_rail_mounts_ZY_magical_param=23;


//drill bit holder params
drill_bit_bottom_wall=0; // 0 -  top plate; 1 -  bottom plate
//drill_bit_tolerance = tolerance;
drill_bit_length_din_rail_count=3;
drill_bit_width_din_rail_count=2;
drill_bit_height=11;
drill_bit_bottom_wall_thickness=2.3;
drill_bit_wall=6;
drill_bit_screw_hole_diameter=5;
drill_bit_square_holes_X_count=3;
drill_bit_square_holes_Y_count=10;
drill_bit_holes_color="silver";
drill_bit_holes_depth=drill_bit_height-drill_bit_bottom_wall*(drill_bit_bottom_wall_thickness)+2*tolerance;
drill_bit_length=(din_rail_step)*drill_bit_length_din_rail_count;
drill_bit_width=(din_rail_step)*drill_bit_width_din_rail_count;
drill_bit_square_hole_Y=(drill_bit_length - drill_bit_wall - 2*(din_rail_ledge+drill_bit_screw_hole_diameter))/drill_bit_square_holes_Y_count-drill_bit_wall;
drill_bit_square_hole_X=(drill_bit_width-drill_bit_wall-2*(din_rail_ledge+drill_bit_screw_hole_diameter))/drill_bit_square_holes_X_count-drill_bit_wall;


 //You can write custom hole module or comment/recomment my versions
module hole(indexX,indexY){
color(drill_bit_holes_color)
//***simply cube holes
    translate([0,0,0])
cube(size=[drill_bit_square_hole_X,	drill_bit_square_hole_Y,drill_bit_holes_depth],center = true);
//***cylyndrical holes
// cylinder(h = drill_bit_holes_depth, r = tolerance + min(drill_bit_square_hole_X,drill_bit_square_hole_Y)/2, center = true);
//***cylyndrical holes for each bit size
// cylinder(h = drill_bit_holes_depth, r = tolerance + (indexX + text_x_first_number + 1 - indexY/10)/2, center = true);

 }


//nuber text params
text_size = 8;
text_font= "Britannic Bold";//"Liberation Sans:style=Bold";
text_height = 0.5;
text_x_first_number = 7;
 text_x_signs = ["0",".25",".5",".75"];

// "signs" - signs use text_{x,y}_signs array; "number" - numerical signs, starting from text_x_first_number
text_x_mode = "number"; 
text_y_mode = "number";

nuber_textX_offset = [0,0,0]; //Change this for move numbers
nuber_textX_rotation = [0,0,0];
nuber_textX_offset = [0,0,0];
nuber_textY_offset = [0,0,0];



 
signs=signs_7_9;

//signs text param
signs_text_size = 5;
// signs on top of plate
signs_text_offset=[0,-drill_bit_square_hole_Y/2-drill_bit_wall/2,0];
// signs in holes
//signs_text_offset=[0,0,0];
signs_text_rotation=[0,0,0];
signs_text_font= "Bodoni MT:style=Bold";
signs_text_height = 0.3;


//color params
signs_color = "red";
base_color = "blue";
number_color = "white";


drill_bit_holder_mount();
/*translate([0,drill_bit_length-din_rail_ledge,0])
drill_bit_holder_mount();
translate([drill_bit_width-din_rail_ledge,drill_bit_length-din_rail_ledge,0])
drill_bit_holder_mount();
*/
