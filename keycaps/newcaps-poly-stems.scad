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
addStem(0, 0);
addStem(1, 0);
addStem(2, 0);
addStem(0, 1);
addStem(1, 1);
addStem(2, 1);
/*add_button(1, 0, "postsoft", "===");
add_button(2, 0, "presoft", "B");
add_button(0, 1, "sharp", "A");
add_button(1, 0, "postsoft");
add_button(2, 1, "presoft", ":", home_row=true);*/

module addStem(
    row, line,
) {
    if (only == [-1, -1] || only == [row, line]) {
        rotate([180,0,0]) translate([row * offset_step, -line * offset_step, -8.5]) {        
            import("polyhedron-stem.stl");
        }
    }
}