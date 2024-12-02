/**
 * Keyboard matrix.
 * Each second level array is a row of keycaps.
 * Each letter, should have appropriate file in svg/ fonter, e.g. "a" should have "a.svg".
 * Each SVG file should be 115x155 pixels.
 * Upper part (125px) is a button surface,
 * Lower part is a button side.
 * The SVG file should have layers or groups with following IDs:
 * raise, base, lower, adjust
 */
buttons = [
    ["a", "s", "d", "f", "g"],
    ["h", "j", "k", "l", "semicolon"]
];

home_row = ["", "f", "j"];


// Infill buttons with colour, or leave indents
infill_buttons = true;

/**
 * Process to create svg is the following (in Inkscape):
 *  - Copy one of existing svgz files, for example "a.svgz",
 *  - Hide groups "raise", "base", "lower" and "adjust"
 *  - Show text objects "raise-text", "base-text", "lower-text" and "adjust-text"
 *  - Edit texts and position objects to achieve desired appearance.
 *  - Duplicate text object (ctrl+d), hide original text object,
 *  - Flatten text duplicate (shift+f) - it should became a shape
 *    - If in some cases "flatten" didn't work, try doing "object to path"
 *  - Move this shape into appropriate group (for example to base)
 *  - Show the group into which you just have moved the object
 *  - Should you need to add custom shape, skip steps with duplicating and flattening text and add shape directly to the group.
 *  - Do all the layers for this button
 *  - Export button as Plain SVG. "a.svg" should appear next to "a.svgz"
 */


// The total space each button takes on the grid including button width and spacing
offset_step = 19;

// How much we should move text up to get it placed on the surface of the button
button_height_offset=4.61;

button_width_offset=17/2;

button_length_offset=17/2;

// Text extrusion depth 
text_depth = 0.31;

// Svg scale. All provided SVGs should have the same size
svg_scale = 0.25;

// Build only one button, set to -1, -1 to build all, set row and line to build only one
only = [-1, -1];

button_stl = "button-polyhedron3.stl";


color("white") union() {
    for ( i = [0 : len(buttons)-1] ) {
        for ( j = [0 : len(buttons[i])-1] ) {
            add_button(j, i, buttons[i][j]);
        }
    }
}
if (infill_buttons) {
    color("black") union() {
        for ( i = [0 : len(buttons)-1] ) {
            for ( j = [0 : len(buttons[i])-1] ) {
                if (buttons[i][j] != "") {
                    add_face_base(j, i, buttons[i][j]);
                }
            }
        }
    }
    color("blue") union() {
        for ( i = [0 : len(buttons)-1] ) {
            for ( j = [0 : len(buttons[i])-1] ) {
                if (buttons[i][j] != "") {
                    add_face_lower(j, i, buttons[i][j]);
                }
            }
        }
    }
    color("magenta") union() {
        for ( i = [0 : len(buttons)-1] ) {
            for ( j = [0 : len(buttons[i])-1] ) {
                if (buttons[i][j] != "") {
                    add_face_raise(j, i, buttons[i][j]);
                }
            }
        }
    }
    color("black") union() {
        for ( i = [0 : len(buttons)-1] ) {
            for ( j = [0 : len(buttons[i])-1] ) {
                if (buttons[i][j] != "") {
                    add_face_adjust(j, i, buttons[i][j]);
                }
            }
        }
    }
}

module add_button(
    row, line,
    letter 
) {
    if (only == [-1, -1] || only == [row, line]) {
        translate([row * offset_step, -line * offset_step, 0]) {
            if (search([letter], home_row, num_returns_per_match=1)[0]) {
                translate([0,-2.5,button_height_offset-0.6]) sphere(1, $fn=50);
            }
            if (infill_buttons) {
                import(button_stl);
            } else {
                difference() {
                    import(button_stl, convexity=4);
                    add_face_raise_inner(letter);
                    add_face_base_inner(letter);
                    add_face_lower_inner(letter);
                    add_face_adjust_inner(letter);
                }
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
            scale(svg_scale) import(str("svg/",svg,".svg"), center=true, id="base");
        }
    };
}

module add_face_raise_inner(svg) {
    translate([0, 0, -text_depth]) {
        translate([0,0,button_height_offset]) linear_extrude(height=text_depth) {
            scale(svg_scale) import(str("svg/",svg,".svg"), center=true, id="raise");
        }
    };
}

module add_face_lower_inner(svg) {
    translate([0, 0, -text_depth]) {
        translate([0,0,button_height_offset]) linear_extrude(height=text_depth) {
            scale(svg_scale) import(str("svg/",svg,".svg"), center=true, id="lower");
        }
    };
}

module add_face_adjust_inner(svg) {
    translate([0, -button_width_offset+text_depth-0.01, 1.9]) rotate([90]) linear_extrude(height=text_depth) {
            scale(svg_scale) import(str("svg/",svg,".svg"), center=true, id="adjust");
    };
}