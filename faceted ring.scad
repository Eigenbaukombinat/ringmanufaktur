// your finger measurement
inner_diameter = 18;
inner_radius = inner_diameter / 2;

// how much bigger should the outside be?
//
// useful values: +10% .. +20% 
//
// (inversely proportionate to the facets: facets = 6 --> 20%, facets = 24 --> 10%)
radius = inner_radius * 1.25;

// the total number of similar rows that the ring should consist of
//
// useful values: 1 ... 5
number_of_rows = 1;

// the height of each layer
//
// useful values: 1 ... 5
height = 2;

// how many points thingies around the ring do you want?
//
// useful values: 6 .. 12 .. 24
facets = 11;

// height of the middle layer... 
// nearly zero results in a single diamond shape
// a value closer to one third of the height gives a nice segmented look
//
// useful values: 0.01 ... 0.2*height ... 0.8*height
middle_height = 0.01;//*height;
//middle_height = 0.3*height;

// make the pointy thingies a little larger for a more 3d-look
//
// useful values: 0 .. 0.25 .. 0.5
//
plus_radius = 0;
//plus_radius = 0.15;
//plus_radius = 0.25;
//plus_radius = 0.50;


// subtract the inner hole from the final result
difference()
{
    // iterate through the rows
    for(i = [0:number_of_rows-1])
    {
        // move the just created part to it's final position
        translate([0,0,i*height])
        
        // calculate the hull over the three parts of each layer
        hull()
        {
            // first layer
            translate([0, 0, 0])
            linear_extrude(height=height/3)
            circle(r = radius-plus_radius, $fn = facets);

            // second rotated THIN layer
            translate([0, 0, 0.5 * height - middle_height/2]) 
            linear_extrude(height=middle_height)
            rotate([0,0,360/facets/2])
            circle(r = radius+plus_radius, $fn = facets);
           
            // third layer
            translate([0,0, 2/3 * height]) 
            linear_extrude(height=height/3)
            circle(r = radius-plus_radius, $fn = facets);
         }
    }

    // inner circle to be deleted
    $fn = 100;
    linear_extrude(height=100, center=true)
    circle(r = inner_radius);
   
}

