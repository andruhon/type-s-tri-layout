height = 9.2;
top_side = 12.5;
bottom_side = 17.5;
corner_diameter = 2;
stem_diameter=5.5;
inner_hollow_scale = 0.82;

// I'm printing in my local library and don't have access to printer settings,
// So I have modified slots a little bit to make them tighter.
// Original dimensions were [4.2,1.5,40]
slot_length = 4.1;
slot_width = 1.32;
slots = [[slot_length,slot_width, inner_hollow_scale*height], [slot_width,slot_length, inner_hollow_scale*height]];

check_cubes(all=false, top=false, bottom=false, wall=false);

// sharp, postsoft, presoft
style = "presoft";


corner_offset = corner_diameter * sqrt(2);

cone_top_diameter = circumscribed_circle(top_side) - corner_offset;
cone_bottom_diameter = circumscribed_circle(bottom_side) - corner_offset;

// cap
difference() {
    keycap();
    translate([0, 0, -0.1]) scale(inner_hollow_scale) keycap();
}

// stem
difference() {
    cylinder(inner_hollow_scale*height, d=stem_diameter, $fn=20);
    translate([0,0, inner_hollow_scale*height/2-0.1]) cube(slots[0], center=true);
    translate([0,0, inner_hollow_scale*height/2-0.1]) cube(slots[1], center=true);
}
// struts
translate([0, 4.6, 6.8]) cube([slot_width, 3.8, slot_width], center=true);
translate([0, -4.6, 6.8]) cube([slot_width, 3.8, slot_width], center=true);
translate([4.6, 0, 6.8]) cube([3.8, slot_width, slot_width], center=true);
translate([-4.6, 0, 6.8]) cube([3.8, slot_width, slot_width], center=true);



module keycap() {
    // sharp
    if (style=="sharp") {
        difference() {
                rotate([0, 0, 45]) cylinder(height,d2=circumscribed_circle(top_side), d1=circumscribed_circle(bottom_side), $fn=4);
                translate([0, 0, 2.9*height]) rotate([90, 90, 0]) cylinder(bottom_side,r=2*height, $fn=300, center=true);
        }
    }

    // post soft
    if (style=="postsoft") {
        minkowski() {
            difference() {
                compensation = sqrt(2) * corner_diameter;
                translate([0, 0, corner_diameter/2]) rotate([0, 0, 45]) cylinder(
                    height - corner_diameter,
                    d2=circumscribed_circle(top_side) - compensation,
                    d1=circumscribed_circle(bottom_side) - compensation,
                    $fn=4
                );
                translate([0, 0, 2.805*height]) rotate([90, 90, 0]) cylinder(bottom_side,r=2*height, $fn=300, center=true);
            }    
            sphere(d=corner_diameter, $fn=50);
        }
    }

    // pre soft
    if (style=="presoft") {
        difference() {
            minkowski() {
                rotate([0, 0, 45]) cylinder(height,d1=cone_bottom_diameter,d2=cone_top_diameter,$fn=4);
                cylinder(0.01,d=corner_diameter,$fn=50);                
            };
            translate([0, 0, 2.9*height]) rotate([90, 90, 0]) cylinder(bottom_side,r=2*height, $fn=300, center=true);
        } 
    }
}

module check_cubes(all=false, bottom=false, top=false, wall=false) {
    // Dimensions check cubes
    if (all || bottom) {
        color("Red") { translate([-bottom_side/2, 0, 0]) cube([bottom_side, bottom_side, height]); }
    }
    if (all || top) {
        color("Green") { translate([-top_side/2, -top_side/2, 0]) cube([top_side, top_side, height]); }
    }
    if (all || wall) {
        color("Orange") { translate([bottom_side/2, -bottom_side/2, 0]) cube([1.7, 1.7, 1.7]); }
    }
}

function circumscribed_circle(side) = side * sqrt(2);