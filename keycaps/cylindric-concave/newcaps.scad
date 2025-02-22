// The total space each button takes on the grid including button width and spacing
offset_step = 19;

// How much we should move text up to get it placed on the surface of the button
button_height_offset=7.7;

// Render text to be printed with different color, leave grooves to paint otherwise
fill_text=true;

// Svg scale. All provided SVGs should have the same size
svg_scale = 0.28;

// Build only one button, set to -1, -1 to build all, set row and line to build only one
only = [-1, -1];

// There are currently three styles sharp, presoft and postsoft
// You can tinker with styles in newcap.scad or use your own stl files

// Buttons may be imported as SVG. Top SVG's dimentions 115x125, side SVG 115x50
// add_button(0, 0, "sharp", svg_top="svg/u.svg", svg_side="svg/u-side.svg");

// Bittpms may be imported with text
// add_button(0, 1, "postsoft", middle="Q", side="Esc");

// import(str("button-", "sharp", ".stl"));
add_button(1, 0, "presoft", svg_top="svg/s.svg", svg_side="svg/s-side.svg");
add_button(2, 0, "presoft", svg_top="svg/d.svg", svg_side="svg/d-side.svg");
add_button(3, 0, "presoft", svg_top="svg/f.svg", svg_side="svg/f-side.svg", home_row=true);
add_button(4, 0, "presoft", svg_top="svg/g.svg", svg_side="svg/g-side.svg");
add_button(6, 0, "presoft", svg_top="svg/h.svg", svg_side="svg/h-side.svg");
add_button(7, 0, "presoft", svg_top="svg/j.svg", svg_side="svg/j-side.svg", home_row=true);
add_button(8, 0, "presoft", svg_top="svg/k.svg", svg_side="svg/k-side.svg");
add_button(9, 0, "presoft", svg_top="svg/l.svg", svg_side="svg/l-side.svg");
add_button(10, 0, "presoft", svg_top="svg/semi.svg", svg_side="svg/semi-side.svg");


module add_button(
    row, line,
    type,
    home_row=false,
    middle="", middle_size=5,
    side="", side_size=3,
    // Svg covers entire cap top and overrides other top options
    svg_top="",
    // Svg covers entire side and overrides side text
    svg_side=""
) {
    if (only == [-1, -1] || only == [row, line]) {
        translate([row * offset_step, -line * offset_step, 0]) {        
            difference() {
                import(str("button-", type, ".3mf"), convexity=7);
                faces(
                    type=type,
                    middle=middle, middle_size=middle_size,
                    svg_top=svg_top
                );
                faces_side(
                    type=type,
                    side=side, side_size=side_size,
                    svg_side=svg_side
                );
            }
            if (fill_text) {
                translate([0, 0, -0.2]) color("Red") faces(
                    type=type,
                    middle=middle, middle_size=middle_size,
                    svg_top=svg_top,
                    text_depth=0.8
                );
                color("Red") difference() {
                    faces_side(
                        type=type,
                        side=side, side_size=side_size,
                        svg_side=svg_side,
                        text_depth=2
                    );
                    translate([-5,-11.7,0]) cube([10,5,9]);
                }                
            }
            if (home_row) {
                translate([-0.25,-5,button_height_offset]) sphere(1, $fn=50);
                /*hull() {           
                    translate([-0.75,-5,button_height_offset]) sphere(1, $fn=50);
                    translate([+0.75,-5,button_height_offset]) sphere(1, $fn=50);
                }*/
            }
        }
    }
}

module faces(
    type,
    middle, middle_size,
    // Svg covers entire cap top and overrides other top options
    svg_top,
    text_depth=2
) {
    if (svg_top != "") {
        // SVG covers entire cap top and overrides other top options
            translate([0,0,button_height_offset]) linear_extrude(height=text_depth) {
                scale(svg_scale) import(svg_top, center=true);
            }
    } else {
        // Currently text only supports middle position
        if (middle != "") {
            translate([0,0,button_height_offset]) linear_extrude(height=text_depth) {
                text(
                        middle,
                        size=middle_size,
                        halign="center",
                        valign="center"
                );
            }
        }
    }
}
module faces_side(
    type,
    side, side_size,
    // Svg covers entire side and overrides side text
    svg_side,
    text_depth=2
) {
    if (svg_side != "") {
        translate([0, 0.1, 0]) {
            rotate([73]) translate([0,3.5,button_height_offset]) linear_extrude(height=text_depth) {
                scale(svg_scale) import(svg_side, center=true);
            };
        }
    } else {
        translate([0, 0.1, 0]) {
            rotate([73]) translate([0,3.5,button_height_offset]) linear_extrude(height=text_depth) {
                    text(
                            side,
                            size=side_size,
                            halign="center",
                            valign="center"
                    );
            };
        }
    }
}