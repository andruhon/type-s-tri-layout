// !!! Enable "Thrown Together" view, to see inner sides in purple colour

points = [
    // Concave
    [-6,   7,    1], // concaveFarLeft=0
    [ 6,   7,    1], // concaveFarRight=1
    [-6,  -7,    1], // concaveNearLeft=2
    [ 6,  -7,    1], // concaveNearRight=3
    
    // Bottom
    [-8.5,   8,    0], // bottomFarLeftNear=4
    [-8,     8.5,  0], // bottomFarLeftFar=5
    [ 8,     8.5,  0], // bottomFarRightFar=6
    [ 8.5,   8,    0], // bottomFarRightNear=7
    [ 8.5,  -8,    0], // bottomNearRightFar=8
    [ 8,    -8.5,  0], // bottomNearRightNear=9
    [-8,    -8.5,  0], // bottomNearLeftNear=10
    [-8.5,  -8,    0], // bottomNearLeftFar=11
    
    // Left Side
    [-8, 5,  1.5], // sideFarLeftTop=12
    [-8, -5, 1.5], // sideNearLeftTop=13
    
    // Right Side
    [8,  5, 1.5], // sideFarRightTop=14
    [8, -5, 1.5], // sideNearRightTop=15
    
    // Left Top Edge
    [-7.5, 5,  1.5], // leftTopEdgeFar=16
    [-7.5, -5, 1.5], // leftTopEdgeNear=17
    
    // Right Top Edge
    [7.5, 5,  1.5], // rightTopEdgeFar=18
    [7.5, -5, 1.5], // rightTopEdgeNear=19
];

concaveFarLeft = 0;
concaveFarRight = 1;
concaveNearLeft = 2;
concaveNearRight = 3;

bottomFarLeftNear=4;
bottomFarLeftFar=5;
bottomFarRightFar=6;
bottomFarRightNear=7;
bottomNearRightFar=8;
bottomNearRightNear=9;
bottomNearLeftNear=10;
bottomNearLeftFar=11;

sideFarLeftTop=12;
sideNearLeftTop=13;
    
sideFarRightTop=14;
sideNearRightTop=15;

leftTopEdgeFar=16;
leftTopEdgeNear=17;

rightTopEdgeFar=18;
rightTopEdgeNear=19;

faces = [
    [concaveFarLeft, concaveFarRight, concaveNearRight, concaveNearLeft], // Concave plate
    [bottomFarRightNear, bottomFarRightFar, bottomFarLeftFar, bottomFarLeftNear, bottomNearLeftFar, bottomNearLeftNear, bottomNearRightNear, bottomNearRightFar], // Bottom plate 
    [bottomFarRightFar, concaveFarRight, concaveFarLeft, bottomFarLeftFar], // Rear plate 
    [sideNearRightTop, sideFarRightTop, bottomFarRightNear, bottomNearRightFar], // Right plate 
    [sideFarLeftTop, sideNearLeftTop, bottomNearLeftFar, bottomFarLeftNear], // Left plate
    [bottomNearLeftNear, concaveNearLeft, concaveNearRight, bottomNearRightNear], // Front plate
    [sideFarLeftTop, leftTopEdgeFar, leftTopEdgeNear, sideNearLeftTop], // Left Top Edge
    [rightTopEdgeFar, sideFarRightTop, sideNearRightTop, rightTopEdgeNear], // Right Top Edge
    [rightTopEdgeNear, sideNearRightTop, bottomNearRightNear], // Right Near Edge 1
    [sideNearRightTop, bottomNearRightFar, bottomNearRightNear], // Right Near Edge 2
    [concaveNearRight, rightTopEdgeNear, bottomNearRightNear], // Right Near Edge 3
    [concaveFarRight, rightTopEdgeFar, rightTopEdgeNear, concaveNearRight], // Right concave to edge
    [bottomFarRightNear, sideFarRightTop, bottomFarRightFar], //Right Far Edge 1
    [sideFarRightTop, rightTopEdgeFar, bottomFarRightFar], //Right Far Edge 2
    [concaveFarRight, bottomFarRightFar, rightTopEdgeFar], // Right Far Edge 3
    [concaveNearLeft, leftTopEdgeNear, leftTopEdgeFar, concaveFarLeft], // left concave to edge
    [bottomNearLeftNear, sideNearLeftTop, leftTopEdgeNear], // Left Near Edge 1
    [sideNearLeftTop, bottomNearLeftNear, bottomNearLeftFar], // Left far edge 2
    [leftTopEdgeNear, concaveNearLeft, bottomNearLeftNear], // Left far edge 3
    [bottomFarLeftFar, concaveFarLeft, leftTopEdgeFar], // Left Far Edge 1
    [leftTopEdgeFar, sideFarLeftTop, bottomFarLeftFar], // Left Far Edge 2
    [bottomFarLeftFar, sideFarLeftTop, bottomFarLeftNear] // Left Far Edge 3
    
];

difference() {
    polyhedron( points, faces);
    // cylinder(d=5, h=5, center=true);
}
