
offset_step = 19;
offset_x = 0;
button_height_offset=7.5;

// There's a bug with previewing some difs. Set it to false before rendering.
preview_buttons=true;

add_button(0, 0, "sharp", "-----");
add_button(1, 0, "postsoft", "===");
add_button(2, 0, "presoft", "B");
add_button(0, 1, "sharp", "A");
add_button(1, 0, "postsoft");
add_button(2, 1, "presoft", ":", home_row=true);

module add_button(row, line, type, middle="", middle_size=5, home_row=false) {
    translate([row * offset_step, line * offset_step, 0]) {
        difference() {
            import(str("button-", type, ".stl"));
            
            if (middle != "") {
                if (!preview_buttons) {
                    translate([0, 0, -0.2]) {
                        difference() {
                            translate([0,0,button_height_offset]) linear_extrude(height=2) {                                text(
                                        middle,
                                        size=middle_size,
                                        halign="center",
                                        valign="center"
                                    );
                            }
                            import(str("button-", type, ".stl"));
                        }
                    }
                }
            }
        }
        if (preview_buttons) {
            translate([0,0,button_height_offset]) color("Red") linear_extrude(height=2) text(
                middle,
                size=middle_size,
                halign="center",
                valign="center"
            );
        }
        if (home_row) {
            hull() {           
                translate([-0.75,-5,button_height_offset]) sphere(0.9, $fn=50);
                translate([+0.75,-5,button_height_offset]) sphere(0.9, $fn=50);
            }
        }
    }
}