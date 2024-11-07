// Original script produced by karlh5926@gmail.com (aileron.me)
// Modified by https://github.com/andruhon

font = "Liberation Sans:style=Bold"; //["Liberation Sans", "Liberation Sans:style=Bold", "Liberation Sans:style=Italic", "Liberation Mono", "Liberation Serif"]

// Font exceptions (Does not affect side text)
special_font_size = [["Home", 2], ["PgUp",2.5], ["PgDn",2.5], ["Space", 3.3], ["Enter", 3.3], ["Alt", 3.3], ["Ctrl", 3.3], [".", 5], [",", 5]];

// Generate labels of the corresponding color.
// Generate cap body if "".
gen_label_model = "";

label_text_size = [3, 4, 3, 4, 4, 3, 3];
label_color = ["blue", "orange","RoyalBlue","RoyalBlue", "red", "DarkViolet", "DarkViolet"];
label_height = .3;
label_bound_box = 5;
label_text_finess = 10;

// Hidden vars
positions = [[-1.2,-1.2,0], [1.2,-1.2,0], [-1.2,1.2,0], [1.2,1.2,0], [0,0,0], [0,1.45,0.45]];
haligns = ["left", "right", "left", "right", "center", "center", "center"];
valigns = ["top", "top", "bottom", "bottom", "center", "center", "center"];

// Andr: I'm printing in my local library and don't have access to printer settings,
// So I have modified slots a little bit to make them tighter.
// Original dimensions were [4.2,1.5,40]
slots = [[4.1,1.4,40], [1.4,4.1,40]];
stem_width = 6.6;
stem_thick = 5;

// Labels. Each element is an array of 5 strings corresponding to:
// top left, top right, bottom left, bottom right, center, side top
labels = [
    ["",    "", "", "", "Q", "Esc"],
    ["F7",  "", "", "", "W", "Vol -"],
    ["F8",  "", "", "", "E", "Mute"],
    ["F9",  "", "", "", "R", "Vol +"],
    ["F12", "", "", "", "T", ""],
    
    ["PgUp","", "", "", "Y", "PtScr"],
    ["Home","7", "", "", "U", ""],
    ["",    "8", "", "", "I", ""],
    ["End", "9", "", "", "O", ""],
    ["",    "", "", "", "P", ""],

    ["",    "", "", "", "A", ""],
    ["F4",  "", "", "", "S", ""],
    ["F5",  "", "", "", "D", ""],
    ["F6",  "", "", "", "F", ""],
    ["F10", "", "", "", "G", ""],
    
    ["PgDn","", "", "", "H", ""],
    ["",    "4", "", "", "J", ""],
    ["",    "5", "", "", "K", ""],
    ["",    "6", "", "", "L", ""],
    ["",    "0", "", "", ";:", ""],    
    
    ["",    "", "", "", "Z", "Shift"],
    ["F1",  "\\", "", "|", "X", "Ctrl"],
    ["F2",  ",", "", "<", "C", "Alt"],
    ["F3",  ".", "", ">", "V", "gui"],
    ["F11", "", "", "ms3", "B", "Del"],
    
    ["Del", "", "", "ms1", "N", "Enter"],
    ["Tab", "1", "", "!", "M", "gui"],
    ["Ins", "2", "", "@", ",<", "Alt"],
    ["App", "3", "", "#", ".>", "Ctrl"],
    ["",    "", "", "mss", "/?", "Shift"],
    
    ["", "", "", "", "", ""], // Spare blank key
    ["", "", "", "", "", ""], // Spare blank key
    ["", "", "", "", "Alt", ""],
    ["", "", "", "", "Space", ""],
    ["", "", "", "", "", "Lower"],
    
    ["", "", "", "", "", "Raise"],
    ["", "", "", "", "Enter", ""],
    ["", "", "", "", "Ctrl", ""],
    ["", "", "", "", "", ""], // Spare blank key
    ["", "", "", "", "", ""] // Spare blank key
];
keys_per_row = 10;
function offset_by_idx(i) = [20*(i%keys_per_row), 20*floor(i/keys_per_row), 0];

module make_single_label(labels_one_key, select_color="") {
    for ( pos = [0 : 4] ) {
        make_single_label_inner(pos, labels_one_key, select_color);
    }
    if(labels_one_key[5] == "gui") {
        make_gui_icon_on_side(select_color);
    } else {
        make_single_label_side_inner(5, labels_one_key, select_color);
    }
}

module make_single_label_inner(pos, labels_one_key, select_color="") {
    if (labels_one_key[pos] != "") {
        if (select_color=="" || select_color==label_color[pos]) {
            echo(labels_one_key[pos]);
            echo(get_font_size(labels_one_key[pos], pos));
            color(label_color[pos])
            translate([0, 0, -.01])
            translate(positions[pos]*label_bound_box)
            linear_extrude(height = label_height)
            rotate(a=180, v=[1, 0, 0])
            text(labels_one_key[pos], 
                size = get_font_size(labels_one_key[pos], pos),
                font = font,
                halign = haligns[pos],
                valign = valigns[pos],
                $fn = label_text_finess);
        }
    }
}

function get_font_size(s, pos) = is_num(search([s], special_font_size, num_returns_per_match=1)[0])? special_font_size[search([s], special_font_size, num_returns_per_match=1)[0]][1] : label_text_size[pos];

module make_gui_icon_on_side(select_color="") {
        if (select_color=="" || select_color==label_color[6]) {
            color(label_color[6])
            translate([0, 0, -.01])
            translate([0.185,1.6,0.7]*label_bound_box)
            rotate([-100, 0, 0])
            linear_extrude(1)
            text("\u2666\u2666", 
                direction = "ttb",
                size = 3,
                font = font,
                halign = "center",
                valign = "center",
                $fn = label_text_finess);
            
            color(label_color[6])
            translate([0, 0, -.01])
            translate([0,1.6,0.7]*label_bound_box)
            rotate([-100, 0, 0])
            linear_extrude(1)
            text("\u2666\u2666", 
                size = 3,
                font = font,
                halign = "center",
                valign = "center",
                $fn = label_text_finess);
        }
}

module make_single_label_side_inner(pos, labels_one_key, select_color="") {
    if (labels_one_key[pos] != "") {
        if (select_color=="" || select_color==label_color[pos]) {
            color(label_color[pos])
            translate([0, 0, -.01])
            translate(positions[pos]*label_bound_box)
            rotate([-110, 0, 0])
            linear_extrude(1)
            text(labels_one_key[pos],
                size = label_text_size[pos],
                font = font,
                halign = haligns[pos],
                valign = valigns[pos],
                $fn = label_text_finess);
        }
    }
}


module make_labels(text_array, select_color="") {
    for ( i = [0 : len(text_array)]) {
        translate(offset_by_idx(i))
        make_single_label(text_array[i], select_color);
    }
}

roundness_top = 4; // [1 : 32]
circle_blend_top = 1;

roundness_bot = 12;

size_bot = 18;
size_top = 15;

function rsquircle(t, p) = 
    1 / pow(pow(cos(t), 2*p) + pow(sin(t), 2*p), 0.5/p);
        
function squircle(roundness, size, square_blend=0.6) = 
    [for (t = [0 : 2 : 360])
        if (t % 10 == 0 || (t+50)%45<10)
            [size * (1 - square_blend +
                rsquircle(t, roundness)*square_blend) * cos(t),
            size * (1 - square_blend +
                rsquircle(t, roundness)*square_blend) * sin(t) ]
    ];

keycap_height = 7.5;
module squircle_keycap_shell(height) {
    difference () {
        hull() {
            linear_extrude(0.01) polygon(squircle(roundness_top, size_top/2, 0.6));
            translate([0,0,height]) linear_extrude(0.01) polygon(squircle(roundness_bot, size_bot/2, 1));
        }
        cavity();
    }
}


////////////////////
// cavity and stem
////////////////////
module cavity() {
    translate([0,0,keycap_height - 6 + .02])
    linear_extrude(height=6, scale=15/12)
    square(12, center=true);
}

module stem() {
    up_shift = 0.5;
    difference() {
        // stem body
        
        translate([0,0,up_shift])
        linear_extrude(keycap_height - up_shift)
        square([stem_width, stem_thick], center=true);
        
        // slots (usually cross-shaped)
        cube(slots[0], center=true);
        cube(slots[1], center=true);
        
        // bevels
        for (i = [0 : 3]) {
            translate([
                positions[i][0]*stem_width/1.98,
                positions[i][1]*stem_thick/1.98,
                0])
            rotate([0,0,45])
            cube([.6,.6,40], center=true);
        }
    }
}

// Hack to make sure OpenSCAD doesn't auto center our object when exporting, which causes misalignment.
module alignment_cube() {
    translate([-10, -10, 0]) cube(0.1); // top left
    translate([
        20*keys_per_row,
        20*ceil(len(labels)/keys_per_row), 0])
        cube(0.1); // bottom right
}

////////////// ==== MAIN ==== ///////////////
/////////////////////////////////////////////
alignment_cube();
if (gen_label_model) {
    make_labels(labels, gen_label_model);
} else {
    union(center=false) {
        cube(0.01, center=true); // hack to make sure openscad 
        for ( i = [0 : len(labels)-1] ){
            translate(offset_by_idx(i))
            difference() {
                color("white") squircle_keycap_shell(keycap_height);
                make_single_label(labels[i]);
            }
        }
        for ( i = [0 : len(labels)-1] ){
            translate(offset_by_idx(i))
            stem();
        }
    }
}

echo(version=version());
echo("Author: karlh5926@gmail.com");
echo("Website: aileron.me");
echo("Youtube: youtube.com/@AmbiguousAdventurer");
echo("Happy 3D printing!        -- 2023/06/16");
/////////////////////////////////////////////
