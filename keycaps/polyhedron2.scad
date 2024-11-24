// !!! Enable "Thrown Together" view, to see inner sides in purple colour

concaveWidth = 12;
edgeHeight = 1.5;
fullWidth = 17;
halfWidth = fullWidth/2;
edgeLength = 10;
bevel = 0.5;
halfWidthLessBevel = halfWidth-bevel;
frontHeight = 5;
echo(halfWidth-bevel);

points = [
    // Concave
    [-concaveWidth/2,   7,    1], // concaveFarLeft=0
    [ concaveWidth/2,   7,    1], // concaveFarRight=1
    [-concaveWidth/2,  -7,    1], // concaveNearLeft=2
    [ concaveWidth/2,  -7,    1], // concaveNearRight=3
    
    // Bottom
    [-halfWidth,   halfWidthLessBevel,            0], // bottomFarLeftNear=4
    [-halfWidthLessBevel,             halfWidth,  0], // bottomFarLeftFar=5
    [ halfWidthLessBevel,             halfWidth,  0], // bottomFarRightFar=6
    [ halfWidth,   halfWidthLessBevel,            0], // bottomFarRightNear=7
    [ halfWidth,  -halfWidthLessBevel,            0], // bottomNearRightFar=8
    [ halfWidthLessBevel,            -halfWidth,  0], // bottomNearRightNear=9
    [-halfWidthLessBevel,            -halfWidth,  0], // bottomNearLeftNear=10
    [-halfWidth,  -halfWidthLessBevel,            0], // bottomNearLeftFar=11
    
    // Left Side
    [-halfWidthLessBevel, edgeLength/2,  edgeHeight], // sideFarLeftTop=12
    [-halfWidthLessBevel, -edgeLength/2, edgeHeight], // sideNearLeftTop=13
    
    // Right Side
    [halfWidthLessBevel,  edgeLength/2, edgeHeight], // sideFarRightTop=14
    [halfWidthLessBevel, -edgeLength/2, edgeHeight], // sideNearRightTop=15
    
    // Left Top Edge
    [-7.5, edgeLength/2,  edgeHeight], // leftTopEdgeFar=16
    [-7.5, -edgeLength/2, edgeHeight], // leftTopEdgeNear=17
    
    // Right Top Edge
    [7.5, edgeLength/2,  edgeHeight], // rightTopEdgeFar=18
    [7.5, -edgeLength/2, edgeHeight], // rightTopEdgeNear=19
    
    [ halfWidth,  -halfWidthLessBevel,            -frontHeight], // frontNearRightFar=20
    [ halfWidthLessBevel,            -halfWidth,  -frontHeight], // frontNearRightNear=21
    [-halfWidthLessBevel,            -halfWidth,  -frontHeight], // frontNearLeftNear=22
    [-halfWidth,  -halfWidthLessBevel,            -frontHeight], // frontNearLeftFar=23
    
    [-halfWidth,   halfWidthLessBevel,            -1], // backFarLeftNear=24
    [-halfWidthLessBevel,             halfWidth,  -1], // backFarLeftFar=25
    [ halfWidthLessBevel,             halfWidth,  -1], // backFarRightFar=26
    [ halfWidth,   halfWidthLessBevel,            -1], // backFarRightNear=27
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

frontNearRightFar=20;
frontNearRightNear=21;
frontNearLeftNear=22;
frontNearLeftFar=23;

backFarLeftNear=24;
backFarLeftFar=25;
backFarRightFar=26;
backFarRightNear=27;

faces = [
    [concaveFarLeft, concaveFarRight, concaveNearRight, concaveNearLeft], // Concave plate
    [backFarRightNear, backFarRightFar, backFarLeftFar, backFarLeftNear, frontNearLeftFar, frontNearLeftNear, frontNearRightNear, frontNearRightFar], // Bottom plate
    // [bottomFarRightFar, bottomFarLeftFar, frontNearLeftNear]
    [bottomFarRightFar, concaveFarRight, concaveFarLeft, bottomFarLeftFar], // Rear bevel plate 
    [sideNearRightTop, sideFarRightTop, bottomFarRightNear, bottomNearRightFar], // Right bevel plate 
    [sideFarLeftTop, sideNearLeftTop, bottomNearLeftFar, bottomFarLeftNear], // Left bevel plate
    [bottomNearLeftNear, concaveNearLeft, concaveNearRight, bottomNearRightNear], // Front bevel plate
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
    [bottomFarLeftFar, sideFarLeftTop, bottomFarLeftNear], // Left Far Edge 3
    [bottomNearLeftNear, bottomNearRightNear, frontNearRightNear, frontNearLeftNear], // Front
    [bottomNearRightNear, bottomNearRightFar, frontNearRightFar, frontNearRightNear], // Right Front edge
    [bottomNearLeftFar, bottomNearLeftNear, frontNearLeftNear, frontNearLeftFar], // Left Frot Edge
    [bottomNearRightFar, bottomFarRightNear, backFarRightNear, frontNearRightFar], // Right Side
    [bottomFarLeftNear, bottomNearLeftFar, frontNearLeftFar, backFarLeftNear], // Left Side
    [bottomFarRightNear, bottomFarRightFar, backFarRightFar, backFarRightNear], // Right Back Edge
    [bottomFarLeftFar, bottomFarLeftNear, backFarLeftNear, backFarLeftFar], // Left Back Edge
    [bottomFarRightFar, bottomFarLeftFar, backFarLeftFar, backFarRightFar], // Back
];

difference() {
    polyhedron( points, faces);
    // cylinder(d=5, h=5, center=true);
}
