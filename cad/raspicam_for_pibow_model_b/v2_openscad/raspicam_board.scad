// Raspicam for Pibow
// A raspicam support for the Pibow case (Pimoroni).

// Copyright (c) 2014 Jérémie DECOCK <jd.jdhp@gmail.com>

use <../../LIB/raspicam_front_and_back/raspicam_front.scad>
use <../../LIB/rounded_corner_board.scad>

// BOARD ////////////////////////////////////

board_width = 70;
board_depth = 40;
board_height = 3;
board_corner_radius = 3;

hinge_radius_in = 2;
hinge_radius_out = 5;
hinge_slot_length = 15;

module raspicam_board() {
    difference() {
        union() {
            difference() {
                2_rounded_corners_board(board_width=board_width, board_depth=board_depth, board_height=board_height, board_corner_radius=board_corner_radius);

                // Raspicam screw holes and camera slot
                translate([board_width/2 - 15, 0, 0]){
                    #raspicam_front(board_height=board_height);
                }
            }
            translate([-board_width/2, 0, hinge_radius_out - board_height/2]) {
                rotate(a=[90,0,0]) {
                    hinge(hinge_radius_in, hinge_radius_out, board_depth);
                }
            }
        }
        #translate([-board_width/2, 0, hinge_radius_out - board_height/2]) {
            cube([hinge_radius_out * 2 + 4, hinge_slot_length, hinge_radius_out * 2 + 2], center=true);
        }
    }
}

module hinge(radius_in, radius_out, length) {
    difference() {
        cylinder(r=radius_out, h=length, center=true, $fn=50);
        #cylinder(r=radius_in, h=length+1, center=true, $fn=50);
    }
}

/////////////////////////////////////////////

translate([0, 0, board_height/2]) {
    raspicam_board();
}

