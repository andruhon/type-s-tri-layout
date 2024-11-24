// The total space each button takes on the grid including button width and spacing
offset_step = 19;

// How much we should move text up to get it placed on the surface of the button
button_height_offset=7.7;

// Text extrusion depth 
text_depth = 3;

// There's a bug with previewing some difs. Set it to false before rendering.
preview_buttons=false;

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
add_button(0, 0, "polyhedron", svg_top="svg/z.svg", svg_side="svg/shift.svg");
add_button(1, 0, "polyhedron", svg_top="svg/x.svg", svg_side="svg/ctrl.svg");
add_button(2, 0, "polyhedron", svg_top="svg/c.svg", svg_side="svg/alt.svg");
add_button(0, 1, "polyhedron", svg_top="svg/comma.svg", svg_side="svg/alt.svg");
add_button(1, 1, "polyhedron", svg_top="svg/dot.svg", svg_side="svg/ctrl.svg");
add_button(2, 1, "polyhedron", svg_top="svg/slash.svg", svg_side="svg/shift.svg");
/*add_button(1, 0, "postsoft", "===");
add_button(2, 0, "presoft", "B");
add_button(0, 1, "sharp", "A");
add_button(1, 0, "postsoft");
add_button(2, 1, "presoft", ":", home_row=true);*/

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
            // rotate([-15, 0, 0]) 
            difference() {
                import(str("button-", type, ".stl"));
                
                if (!preview_buttons) {
                    faces(
                        type=type,
                        middle=middle, middle_size=middle_size,
                        side=side, side_size=side_size,
                        svg_top=svg_top,
                        svg_side=svg_side
                    );
                }
            }
            if (preview_buttons) {
                color("Red") faces(
                    type=type,
                    middle=middle, middle_size=middle_size,
                    side=side, side_size=side_size,
                    svg_top=svg_top,
                    svg_side=svg_side
                );
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
    side, side_size,
    // Svg covers entire cap top and overrides other top options
    svg_top,
    // Svg covers entire side and overrides side text
    svg_side
) {
    if (svg_top != "") {
        // SVG covers entire cap top and overrides other top options
        translate([0, 0, -text_depth]) {
            difference() {
                translate([0,0,button_height_offset]) linear_extrude(height=2) {
                    scale(svg_scale) import(svg_top, center=true);
                }
                if (!preview_buttons) {
                    import(str("button-", type, ".stl"));
                }
            }
        }
    } else {
        // Currently text only supports middle position
        if (middle != "") {
            translate([0, 0, -text_depth]) {
                difference() {
                    translate([0,0,button_height_offset]) linear_extrude(height=2) {
                        text(
                                middle,
                                size=middle_size,
                                halign="center",
                                valign="center"
                        );
                    }
                    if (!preview_buttons) {
                        import(str("button-", type, ".stl"));
                    }
                }
            }
        }
    }
    if (svg_side != "") {
        translate([0, text_depth+0.1, 0]) {
            difference() {       
                rotate([90]) translate([0,2.5,10]) linear_extrude(height=2) {
                    scale(svg_scale) import(svg_side, center=true);
                };
                if (!preview_buttons) {
                    import(str("button-", type, ".stl"));
                }
            }
        }
    } else {
        translate([0, text_depth+0.1, 0]) {
            difference() {       
                rotate([90]) translate([0,2.5,10]) linear_extrude(height=2) {
                        text(
                                side,
                                size=side_size,
                                halign="center",
                                valign="center"
                        );
                };
                if (!preview_buttons) {
                    import(str("button-", type, ".stl"));
                }
            }
        }
    }
}