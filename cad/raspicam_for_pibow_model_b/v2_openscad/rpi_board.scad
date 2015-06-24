// 2 wheel robot for Raspberry Pi (model B).

// Copyright (c) 2014 Jérémie DECOCK <jd.jdhp@gmail.com>

use <../../LIB/pibow_base/pibow_model_b_coupe_base.scad>
use <../../LIB/rounded_corner_board.scad>

/////////////////////////////////////////////

pibow_b_width = 98;

board_width = 150;
board_depth = 65;
board_height = 3;

module rpi_board() {
    hinge_height_1 = 11;
    hinge_depth_1 = 13;
    hinge_radius_in = 2;
    hinge_radius_out = 5.5;

    board_corner_radius = 2;

    offset_x1 = (board_width - pibow_b_width)/2;
    offset_x2 = (board_width - hinge_radius_out*2)/2;

    offset_z1 = (board_height + hinge_height_1)/2;
    offset_z2 = board_height/2 + hinge_height_1;

    difference() {
        4_rounded_corners_board(board_width=board_width, board_depth=board_depth, board_height=board_height, board_corner_radius=board_corner_radius);

        // RPi screw holes
        translate([-offset_x1, 0, 0]) {
            #pibow_b_base(board_height+1);
        }
    }

    // Raspicam hinge
    translate([offset_x2, 0, 0]) {
        difference() {
            union() {
                translate([0, 0, offset_z1]) cube([hinge_radius_out*2, hinge_depth_1, hinge_height_1], center=true);
                translate([0, 0, offset_z2]) rotate(a=[90,0,0]) cylinder(r=hinge_radius_out, h=hinge_depth_1, center=true, $fn=50);
            }
            translate([0, 0, offset_z2]) rotate(a=[90,0,0]) #cylinder(r=hinge_radius_in, h=hinge_depth_1+1, center=true, $fn=50);
        }
    }
}

translate([0, 0, board_height/2]) {
    rpi_board();
}
