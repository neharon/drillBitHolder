// Parametric stackable drill bits holder for  and
//It is licensed under the Creative Commons - GNU GPL license.
// © 2014-2015 by Petr Mironkin neharon@ya.ru
// If you like this holder you can donate, please use
// https://www.paypal.me/mirok



module drill_bit_holder_mount()
{
union()
	difference(){
        union(){

//base platte
            color(base_color)
                cube([drill_bit_width,drill_bit_length,drill_bit_height]);

        }
        union(){
            color(base_color)
                union(){
// din rail mounts X
                    for(j=[0,1])
                        translate([0,j*drill_bit_length,0])
                            mirror([0,j,0])
                                for(i=[0,1])
                                    translate([-drill_bit_tolerance,
                                                din_rail_ledge,
                                                i*drill_bit_height-(i*2-1)*din_rail_tolerance])
                                        rotate([0,i*90,-90])
                                            prism(drill_bit_width+2*drill_bit_tolerance,din_rail_ledge ,din_rail_ledge );
// din rail mounts Y
                    for(j=[0,1])
                        translate([j*drill_bit_width,0,0])
                            mirror([j,0,0])
                                for(i=[0,1])
                                     translate([din_rail_ledge,
                                                drill_bit_length+drill_bit_tolerance,
                                                i*drill_bit_height-(i*2-1)*din_rail_tolerance])
                                            rotate([0,i*90,180])
                                                prism(drill_bit_length+2*drill_bit_tolerance,din_rail_ledge ,din_rail_ledge );
// din rail mounts ZX
                    for(j=[0,1])
                        for ( i = [0 : drill_bit_width_din_rail_count] )
                            translate([din_rail_mount_inner_width*j+din_rail_step*i+din_rail_mounts_ZX_magical_param*j,
                                       j*(drill_bit_length),
                                       j*drill_bit_height+2*(j-0.5)*drill_bit_tolerance])
                                rotate([j*180,0,0])
                                    dinRailMountVert();

// din rail mounts ZY
                    for(j=[0,1])
                        for ( i = [0 : drill_bit_length_din_rail_count] )
                            translate([j*drill_bit_width,
                                       din_rail_mount_inner_width*j+din_rail_step*i-din_rail_mounts_ZY_magical_param*j,
                                       drill_bit_height+drill_bit_tolerance])
                                rotate([180,0,90+180*j])
                                    dinRailMountVert();
//screw holes
                    for (i=[1,-1])
                        for (j=[1,-1])
                            translate([drill_bit_width/2-i*(drill_bit_width/2-drill_bit_wall-din_rail_ledge-drill_bit_screw_hole_diameter/2),
                                       drill_bit_length/2-j*(drill_bit_length/2-drill_bit_wall-din_rail_ledge-drill_bit_screw_hole_diameter/2),
                                       0]) 
                            cylinder(h = drill_bit_height+drill_bit_tolerance,r=drill_bit_screw_hole_diameter/2+drill_bit_tolerance);
                }
// holes 
                for(i=[0:drill_bit_square_holes_X_count-1])
                    for(j=[0:drill_bit_square_holes_Y_count-1])
                        translate([drill_bit_wall+din_rail_ledge+drill_bit_screw_hole_diameter+drill_bit_square_hole_X/2+(drill_bit_square_hole_X+drill_bit_wall)*i,
                                   drill_bit_wall+din_rail_ledge+drill_bit_screw_hole_diameter+drill_bit_square_hole_Y/2+(drill_bit_square_hole_Y+drill_bit_wall)*j,
                                   drill_bit_holes_depth/2+drill_bit_bottom_wall*(drill_bit_bottom_wall_thickness)-drill_bit_tolerance])
                            hole(i,j);
                
//number text
                color(number_color)
                    union(){
//X
                        translate(nuber_textX_offset)
                            for(i=[0:drill_bit_square_holes_X_count-1])
                                for(k=[0:1])
                                    translate([drill_bit_wall+din_rail_ledge+drill_bit_screw_hole_diameter+drill_bit_square_hole_X/2+(drill_bit_square_hole_X+drill_bit_wall)*i,
                                               drill_bit_wall+din_rail_ledge+k*(drill_bit_screw_hole_diameter+(drill_bit_square_hole_Y+drill_bit_wall)*drill_bit_square_holes_Y_count),
                                               drill_bit_height-text_height+drill_bit_tolerance])
                                        rotate([0,0,-90])
                                            linear_extrude(height = text_height) 
                                                text(text=str(1+i+text_x_first_number-1),font=text_font,size=text_size, valign ="center", halign ="center");
                
//Y
                        translate(nuber_textY_offset)
                            for(l=[0:1])
                                for(m=[0:drill_bit_square_holes_Y_count-1])
                                    translate([drill_bit_wall/2+din_rail_ledge+drill_bit_screw_hole_diameter/2+((drill_bit_square_hole_X+drill_bit_wall)*drill_bit_square_holes_X_count+drill_bit_screw_hole_diameter)*l,
                                               drill_bit_wall+din_rail_ledge+drill_bit_screw_hole_diameter+drill_bit_square_hole_Y/2+(drill_bit_square_hole_Y+drill_bit_wall)*m,
                                               drill_bit_height-text_height+drill_bit_tolerance])
                                        rotate([0,0,-90])
                                            linear_extrude(height = text_height) 
                                                text(text=str(drill_bit_square_holes_Y_count-m-1),font=text_font,size=text_size, valign ="center", halign ="center");
                    }
//fantom cleare
                    cube([din_rail_ledge,din_rail_ledge,drill_bit_height+drill_bit_tolerance]);
        }
    }
//Signs text
    translate(signs_text_offset)
        color(signs_color)
            for(t=[0:len(signs)-1])
                translate([drill_bit_wall+din_rail_ledge+drill_bit_screw_hole_diameter+drill_bit_square_hole_X/2+(drill_bit_square_hole_X+drill_bit_wall)*(signs[t] [0] [0]),
                           drill_bit_wall+din_rail_ledge+drill_bit_screw_hole_diameter+drill_bit_square_hole_Y/2+(drill_bit_square_hole_Y+drill_bit_wall)*(drill_bit_square_holes_Y_count - 1 - (signs[t] [0] [1])),
                           drill_bit_bottom_wall_thickness-drill_bit_tolerance])
                    rotate(signs_text_rotation)
                        linear_extrude(height = text_height) 
                            text(text=signs[t] [1],font=signs_text_font,size=signs_text_size,valign ="center", halign ="center");
}

module dinRailMountVert(){
tolCount=4;
translate([din_rail_ledge,din_rail_ledge+drill_bit_tolerance,-tolCount/2*drill_bit_tolerance])
	rotate([90,0,0])		
  union(){
    translate([din_rail_mount_inner_width,0,0])
        prism(drill_bit_height+tolCount*drill_bit_tolerance,din_rail_ledge+tolCount*drill_bit_tolerance  ,din_rail_ledge+tolCount*drill_bit_tolerance  );
    cube([din_rail_mount_inner_width+tolCount*drill_bit_tolerance,drill_bit_height+tolCount*drill_bit_tolerance  ,din_rail_ledge+tolCount*drill_bit_tolerance ]);
    mirror([1,0,0])
        prism(drill_bit_height+tolCount*drill_bit_tolerance,din_rail_ledge+tolCount*drill_bit_tolerance ,din_rail_ledge+tolCount*drill_bit_tolerance );
  }
}

//I don't now who is prism module Autor, but lot of thanks! Mirok.
//Draw a prism based on a
//right angled triangle
//l - length of prism
//w - width of triangle
//h - height of triangle
module prism(l, w, h) {
translate([0, l, 0]) rotate( a= [90, 0, 0])
linear_extrude(height = l) polygon(points = [
[0, 0],
[w, 0],
[0, h]
], paths=[[0,1,2,0]]);
}