// !!! Enable "Thrown Together" view, to see inner sides in purple colour

points = [
    // Concave
    [-6,   7,    1], // concaveFarLeft=0
    [ 6,   7,    1], // concaveFarRight=1
    [-6,  -7,    1], // concaveNearLeft=2
    [ 6,  -7,    1], // concaveNearRight=3
    [-6,   8.5,  0], // concaveFarLeftBottom=4
    [ 6,   8.5,  0], // concaveFarRightBottom=5
    [-6,  -8.5,  0], // concaveNearLeftBottom=6
    [ 6,  -8.5,  0], // concaveNearRightBottom=7
    
    // Bottom
    [-8.5,   8,    0], // bottomFarLeftNear=8
    [-8,     8.5,  0], // bottomFarLeftFar=9
    [ 8,     8.5,  0], // bottomFarRightFar=10
    [ 8.5,   8,    0], // bottomFarRightNear=11
    [ 8.5,  -8,    0], // bottomNearRightFar=12
    [ 8,    -8.5,  0], // bottomNearRightNear=13
    [-8,    -8.5,  0], // bottomNearLeftNear=14
    [-8.5,  -8,    0], // bottomNearLeftFar=15
    
    // Left Side
    [-8, 8,  2], // sideFarLeftTop=16
    [-8, -8, 2], // sideNearLeftTop=17
    
    // Right Side
    [8,  8, 2], // sideFarRightTop=18
    [8, -8, 2], // sideNearRightTop=19
    
    // Left Top Edge
    [-7.5, 8,  2], // leftTopEdgeFar=20
    [-7.5, -8, 2], // leftTopEdgeNear=21
    
    // Right Top Edge
    [7.5, 8,  2], // rightTopEdgeFar=22
    [7.5, -8, 2], // rightTopEdgeNear=23
];

concaveFarLeft = 0;
concaveFarRight = 1;
concaveNearLeft = 2;
concaveNearRight = 3;
concaveFarLeftBottom=4;
concaveFarRightBottom=5;
concaveNearLeftBottom=6;
concaveNearRightBottom=7;

bottomFarLeftNear=8;
bottomFarLeftFar=9;
bottomFarRightFar=10;
bottomFarRightNear=11;
bottomNearRightFar=12;
bottomNearRightNear=13;
bottomNearLeftNear=14;
bottomNearLeftFar=15;

sideFarLeftTop=16;
sideNearLeftTop=17;
    
sideFarRightTop=18;
sideNearRightTop=19;

leftTopEdgeFar=20;
leftTopEdgeNear=21;

rightTopEdgeFar=22;
rightTopEdgeNear=23;

faces = [
    [concaveFarLeft, concaveFarRight, concaveNearRight, concaveNearLeft], // Concave plate
    [bottomFarRightNear, bottomFarRightFar, bottomFarLeftFar, bottomFarLeftNear, bottomNearLeftFar, bottomNearLeftNear, bottomNearRightNear, bottomNearRightFar], // Bottom plate 
    [concaveFarRightBottom, concaveFarRight, concaveFarLeft, concaveFarLeftBottom], // Rear plate 
    [sideNearRightTop, sideFarRightTop, bottomFarRightNear, bottomNearRightFar], // Right plate 
    [sideFarLeftTop, sideNearLeftTop, bottomNearLeftFar, bottomFarLeftNear], // Left plate
    [concaveNearLeftBottom, concaveNearLeft, concaveNearRight, concaveNearRightBottom], // Front plate
    [sideFarLeftTop, leftTopEdgeFar, leftTopEdgeNear, sideNearLeftTop], // Left Top Edge
    [rightTopEdgeFar, sideFarRightTop, sideNearRightTop, rightTopEdgeNear], // Right Top Edge
    [rightTopEdgeNear, sideNearRightTop, bottomNearRightFar, bottomNearRightNear], // Right Near Edge
    [concaveNearRightBottom, concaveNearRight, rightTopEdgeNear, bottomNearRightNear],
    [concaveFarRight, rightTopEdgeFar, rightTopEdgeNear, concaveNearRight], // Right concave to edge
];

difference() {
    polyhedron( points, faces);
    // cylinder(d=5, h=5, center=true);
}
