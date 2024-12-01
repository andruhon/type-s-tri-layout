// The total space each button takes on the grid including button width and spacing
offset_step = 19;

// How much we should move text up to get it placed on the surface of the button
button_height_offset=4.61;

button_width_offset=17/2;

button_length_offset=17/2;

// Text extrusion depth 
text_depth = 0.21;

// Svg scale. All provided SVGs should have the same size
svg_scale = 0.25;

// Build only one button, set to -1, -1 to build all, set row and line to build only one
only = [-1, -1];

button_stl = "button-polyhedron3.stl";

preview = false;

// There are currently three styles sharp, presoft and postsoft
// You can tinker with styles in newcap.scad or use your own stl files

// Buttons may be imported as SVG. Top SVG's dimentions 115x125, side SVG 115x50
// add_button(0, 0, "sharp", svg_base="svg/u.svg", svg_adjust="svg/u-side.svg");

// Bittpms may be imported with text
// add_button(0, 1, "postsoft", middle="Q", side="Esc");

// import(str("button-", "sharp", ".stl"));

// Union each part we expect to have separate colour
buttons = [
    ["z", "", "", "shift"],
    ["x", "f1", "backslash", "ctrl"],
    ["c", "f2", "comma", "alt"],
    ["v", "f3", "dot", "super"]
];

color("white") union() {
    for ( i = [0 : len(buttons)-1] ) {
        add_button(i, 0);
    }
}
color("black") union() {
    for ( i = [0 : len(buttons)-1] ) {
        if (buttons[i][0] != "") {
            add_face_base(i, 0, str("svg/",buttons[i][0],".svg"));
        }
    }
}
color("blue") union() {
    for ( i = [0 : len(buttons)-1] ) {
        if (buttons[i][1] != "") {
            add_face_lower(i, 0, str("svg/",buttons[i][1],".svg"));
        }
    }
}
color("magenta") union() {
    for ( i = [0 : len(buttons)-1] ) {
        if (buttons[i][2] != "") {
            add_face_raise(i, 0, str("svg/",buttons[i][2],".svg"));
        }
    }
}
color("black") union() {
    for ( i = [0 : len(buttons)-1] ) {
        if (buttons[i][3] != "") {
            add_face_adjust(i, 0, str("svg/",buttons[i][3],".svg"));
        }
    }
}


/*color("white") union() {
    add_button(0, 0);
    add_button(1, 0);
    add_button(2, 0);
}
color("magenta") union() {
    // Raise for Z is shift everywhere except base
    add_face_raise(1, 0, "svg/backslash.svg");
    add_face_raise(2, 0, "svg/comma.svg");
}
color("black") union() {
    add_face_base(0, 0, "svg/z.svg");
    add_face_base(1, 0, "svg/x.svg");
    add_face_base(2, 0, "svg/c.svg");
}
color("blue") union() {
    // Raise for Z is shift everywhere except base
    add_face_lower(1, 0, "svg/f1.svg");
    add_face_lower(2, 0, "svg/f2.svg");
}
color("black") union() {
    add_face_adjust(0, 0, "svg/shift.svg");
    add_face_adjust(1, 0, "svg/ctrl.svg");
    add_face_adjust(2, 0, "svg/alt.svg");
}*/

module add_button(
    row, line,
    home_row=false,
    middle="", middle_size=5,
    side="", side_size=3,
    // Svg covers entire cap top and overrides other top options
    svg_base="",
    // Svg covers entire side and overrides side text
    svg_adjust=""
) {
    if (only == [-1, -1] || only == [row, line]) {
        translate([row * offset_step, -line * offset_step, 0]) {        
            // rotate([-15, 0, 0]) 
            /*difference() {*/
                import(button_stl);
                // It seems like it is unnecessary to do diff in this case.
                /*faces(
                    svg_base=svg_base,
                    svg_adjust=svg_adjust
                );
            }*/
            if (home_row) {
                translate([-0.25,-5,button_height_offset]) sphere(1, $fn=50);
            }
            if (preview) {
                import(button_stl);
            }
        }
    }
}

module add_face_base(row, line, svg) {
    if (only == [-1, -1] || only == [row, line]) {
        translate([row * offset_step, -line * offset_step, 0]) add_face_base_inner(svg);
    }
}

module add_face_adjust(row, line, svg) {
    if (only == [-1, -1] || only == [row, line]) {
        translate([row * offset_step, -line * offset_step, 0]) add_face_adjust_inner(svg);
    }
}

module add_face_raise(row, line, svg) {
    if (only == [-1, -1] || only == [row, line]) {
        translate([row * offset_step, -line * offset_step, 0]) add_face_raise_inner(svg);
    }
}

module add_face_lower(row, line, svg) {
    if (only == [-1, -1] || only == [row, line]) {
        translate([row * offset_step, -line * offset_step, 0]) add_face_lower_inner(svg);
    }
}

module add_face_base_inner(svg) {
    translate([0, 0, -text_depth]) {
        translate([0,0,button_height_offset]) linear_extrude(height=text_depth) {
            scale(svg_scale) import(svg, center=true);
        }
    };
}

module add_face_raise_inner(svg) {
    translate([0, 0, -text_depth]) {
        translate([0,0,button_height_offset]) linear_extrude(height=text_depth) {
            scale(svg_scale) import(svg, center=true);
        }
    };
}

module add_face_lower_inner(svg) {
    translate([0, 0, -text_depth]) {
        translate([0,0,button_height_offset]) linear_extrude(height=text_depth) {
            scale(svg_scale) import(svg, center=true);
        }
    };
}

module add_face_adjust_inner(svg) {
    translate([0, -button_width_offset+text_depth-0.01, 1.9]) rotate([90]) linear_extrude(height=text_depth) {
            scale(svg_scale) import(svg, center=true);
    };
}

module faces(
    // Svg covers entire cap top and overrides other top options
    svg_base,
    // Svg covers entire side and overrides side text
    svg_adjust
) {
    if (svg_base != "") {
        // SVG covers entire cap top and overrides other top options
        add_face_base_inner(svg_base);
    }
    if (svg_adjust != "") {
        add_face_adjust_inner(svg_adjust);
    }
}