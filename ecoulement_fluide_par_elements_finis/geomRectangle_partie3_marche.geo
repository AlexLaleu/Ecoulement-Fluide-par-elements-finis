Mesh.MshFileVersion = 2.2;

h = 0.1; //pas du maillage

Point(1) = {2, 0, 0, h};
Point(2) = {8, 0, 0, h};
Point(3) = {8, 2, 0, h};
Point(4) = {0, 2, 0, h};
Point(5) = {0, 1, 0, h};
Point(6) = {2, 1, 0, h};

// definition des segments
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 5};
Line(5) = {5, 6};
Line(6) = {6, 1};

// definition des contours fermes
Line Loop(1) = {1,2,3,4,5,6};

// definition des surfaces a partir contours fermes
Plane Surface(1) = {1};

// definition des elements physiques pour avoir des références différentes pour conditions aux limites différentes
Physical Point(1) = {1,2,3,4,5,6};
Physical Line(1) = {1,6,5};
Physical Line(2) = {4};
Physical Line(3) = {3};
Physical Line(4) = {2};
Physical Surface(1) = {1};
