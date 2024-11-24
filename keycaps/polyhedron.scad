points = [
// x     y     z
 [ 0,    0,    0], // ccb 0 center center bottom
 [ 0,    8.5,  0], // cfb 1 center far bottom
 [ 8,    8.5,  0], // farRightEdgeFarBottom 2 right far bottom
 [ 8,    0,    0], // rcb 3 right center bottom
 [ 8.5,  8,    0], // farRightEdgeNearBottom 4
 [ 8.5,  0,    0], // rrcb 5 r-right center bottom
 [ 0,    0,    1], // ccm 6 center center middle
 [ 0,    7,    1], // cfm 7 center far middle
 [ 6,    8.5,  0], // concaveFarBottom 8
 [ 6,    7,    1], // concaveFarMiddle 9
 [ 8,    7.5,  2], // farRightEdgeNearTop 10
 [ 7.5,  8,    2], // farRightEdgeFarTop 11
 [ 6,    0,    1], // concaveNearMiddle 12
 [ 7.5,  0,    2],  // nearRightEdgeLeftTop
 [ 8,    0,    2], // nearRightEdgeRightTop
];

cfb = 1;
farRightEdgeFarBottom = 2;
rcb = 3;
farRightEdgeNearBottom = 4;
rrcb = 5;
ccm = 6;
cfm = 7;
concaveFarBottom = 8;
concaveFarMiddle = 9;
farRightEdgeNearTop = 10;
farRightEdgeFarTop = 11;
concaveNearMiddle = 12;
nearRightEdgeLeftTop = 13;
nearRightEdgeRightTop = 14;

faces = [
 // FIXME top and bottom are upsides down here
 [0, cfb, farRightEdgeFarBottom, rcb],
 [rcb, farRightEdgeFarBottom, farRightEdgeNearBottom, rrcb],
 [0, cfb, cfm, ccm],
 [cfb, concaveFarBottom, concaveFarMiddle, cfm],
 [cfb, concaveFarBottom, concaveFarMiddle, cfm],
 [farRightEdgeNearBottom, farRightEdgeNearTop, farRightEdgeFarTop, farRightEdgeFarBottom],
 [farRightEdgeFarBottom, farRightEdgeFarTop, concaveFarMiddle, concaveFarBottom],
 [concaveNearMiddle, concaveFarMiddle, cfm, ccm],
 [concaveFarMiddle, farRightEdgeFarTop, nearRightEdgeLeftTop, concaveNearMiddle],
 [nearRightEdgeLeftTop, farRightEdgeFarTop, farRightEdgeNearTop, nearRightEdgeRightTop],
 [nearRightEdgeRightTop, farRightEdgeNearTop, farRightEdgeNearBottom, rrcb],
 [0, ccm, concaveNearMiddle, rrcb],
 [concaveNearMiddle, nearRightEdgeLeftTop, nearRightEdgeRightTop, rrcb],
];

module buttonQuarter() {
    polyhedron( points, faces);
}

// difference() {
    union() {
        buttonQuarter();
        rotate([0, 0, 180]) buttonQuarter();
        mirror([1, 0, 0]) buttonQuarter();
        mirror([0, 1, 0]) buttonQuarter();
        // cube([17, 17, 1], center=true);
    }
    // translate([3, 3, 0]) cylinder(r=2, h=5, center=true);
// }
