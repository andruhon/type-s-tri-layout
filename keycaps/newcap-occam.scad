stem_height = 6.5;
top_side = 16;
cap_thickness = 2;
side_thickness = 1;
corner_radius = 2;
stem_diameter=5.5;

// I'm printing in my local library and don't have access to printer settings,
// So I have modified slots a little bit to make them tighter.
// Original dimensions were [4.2,1.5,40]
slot_length = 4.1;
slot_width = 1.4;
slots = [[slot_length,slot_width, stem_height], [slot_width,slot_length, stem_height]];

// TODO this should be a part of cap
/*translate([top_side/2-0.5, 0, stem_height-1.5]) cube([side_thickness, top_side-4, stem_height/2], center=true);*/

// cube([top_side, top_side, 15], center=true);
union() {
    minkowski() {
        translate([0, 0, stem_height])
            cube([top_side-corner_radius*2, top_side-corner_radius*2, 0.01], center=true);
        // sphere(r=corner_radius, $fn=20);
        cylinder(h=cap_thickness, r=corner_radius, $fn=20);
    }

    // stem height check
    // color("red") translate([8, 8, 0]) cylinder(h=stem_height, r=corner_radius, $fn=20);


    // stem
    difference() {
        cylinder(stem_height, d=stem_diameter, $fn=20);
        translate([0,0, stem_height/2-0.1]) cube(slots[0], center=true);
        translate([0,0, stem_height/2-0.1]) cube(slots[1], center=true);
    }
}
