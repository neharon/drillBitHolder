include <Mirok_drill_bit_holder.scad>;
// Parametric stackable drill bits holder for  and
//It is licensed under the Creative Commons - GNU GPL license.
// © 2014 by Petr Mironkin neharon@ya.ru

//include <Libs.scad>;
drill_bit_holder_mount();
/*translate([0,drill_bit_length-din_rail_ledge,0])
drill_bit_holder_mount();
translate([drill_bit_width-din_rail_ledge,drill_bit_length-din_rail_ledge,0])
drill_bit_holder_mount();
*/


tolerance= +0.08; 

//DIN rail params
din_rail_mount_width=35;
din_rail_mount_height=7;
din_rail_mount_inner_width=27;
din_rail_tolerance = -0.3;
din_rail_step=din_rail_mount_width+din_rail_mount_inner_width;
din_rail_ledge=(din_rail_mount_width-din_rail_mount_inner_width)/2;

//Don't ask me why, just use
din_rail_mounts_ZX_magical_param=4;
din_rail_mounts_ZY_magical_param=23;


//drill bit holder params
drill_bit_bottom_wall=1; // 0 -  top plate; 1 -  bottom plate
drill_bit_tolerance = tolerance;
drill_bit_length_din_rail_count=3;
drill_bit_width_din_rail_count=2;
drill_bit_height=11;
drill_bit_bottom_wall_thickness=2.3;
drill_bit_wall=6;
drill_bit_screw_hole_diameter=5;
drill_bit_square_holes_X_count=4;
drill_bit_square_holes_Y_count=10;
drill_bit_holes_color="silver";
drill_bit_holes_depth=drill_bit_height-drill_bit_bottom_wall*(drill_bit_bottom_wall_thickness)+2*drill_bit_tolerance;
drill_bit_length=(din_rail_step)*drill_bit_length_din_rail_count;
drill_bit_width=(din_rail_step)*drill_bit_width_din_rail_count;
drill_bit_square_hole_Y=(drill_bit_length-drill_bit_wall-2*(din_rail_ledge+drill_bit_screw_hole_diameter))/drill_bit_square_holes_Y_count-drill_bit_wall;
drill_bit_square_hole_X=(drill_bit_width-drill_bit_wall-2*(din_rail_ledge+drill_bit_screw_hole_diameter))/drill_bit_square_holes_X_count-drill_bit_wall;
echo("drill_bit_square_hole_X=");
echo( drill_bit_square_hole_X);
echo("drill_bit_square_hole_Y=");
echo( drill_bit_square_hole_Y);
echo("drill_bit_holes_depth=");
echo( drill_bit_holes_depth);


 //You can write custom hole module or comment/recomment my versions
module hole(indexX,indexY){
color(drill_bit_holes_color)
//***simply cube holes
    translate([0,0,0])
//cube(size=[drill_bit_square_hole_X,	drill_bit_square_hole_Y,drill_bit_holes_depth],center = true);
//***cylyndrical holes
// cylinder(h = drill_bit_holes_depth, r = tolerance + min(drill_bit_square_hole_X,drill_bit_square_hole_Y)/2, center = true);
//***cylyndrical holes for each bit size
 cylinder(h = drill_bit_holes_depth, r = tolerance + (indexX + text_x_first_number + 1 - indexY/10)/2, center = true);

 }


//nuber text params
text_size = 7;
text_font= "Liberation Sans:style=Bold";
text_height = 0.5;
text_x_first_number = 10;
nuber_textX_offset = [0,1,0];
nuber_textY_offset = [0,0,0];


//signs text param
signs_text_size = 5;
// signs on top of plate
signs_text_offset=[0,-drill_bit_square_hole_Y/2-drill_bit_wall/2,drill_bit_holes_depth];
// signs in holes
//signs_text_offset=[0,0,0];
signs_text_rotation=[0,0,180];

//signs array members format: [[ROW_NUMBER,COL_NUMBER],"Text_of_sign"],
//7.0-9.9mm signs

signs=[ [[0,0],"М8x1"],
        [[0,2],"M8x.75"],
        [[0,5],"M8x.5"],
        [[0,8],"M9x1.25"],
        [[1,0],"M9x1"],
        [[1,2],"M9x.75"],
        [[1,5],"M10x1.5"],
        [[1,7],"M10x1.25"],
        [[2,0],"M10x1"],
        [[2,5],"M11x1.5"],
        [[0,7],"3/8\""],
        [[2,2],"7/16\""],
        [[2,8],"1/8G↑"],
     ];

//3.0-6.9mm signs
/*signs=[ [[0,3],"М4x.7"],
        [[0,5],"M4x.5"],
        [[0,8],"M4.5x.7"],
        [[1,2],"M5x.8"],
        [[1,5],"M5x.5"],
        [[2,0],"1/4\"M6x1"],
        [[2,2],"M6x.75"],
        [[2,5],"M6x.5"],
        [[3,0],"M7x1"],
        [[3,2],"M7x.75"],
        [[3,5],"M7x.5"],
        [[3,7],"M8x1.25"],
        [[0,6],"3/16\""],
        [[3,4],"5/16\""],
        [[3,8],"1/16G"],
     ];
*/     
//color params
signs_color = "red";
base_color = "blue";
number_color = "white";
