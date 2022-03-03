//$fn = 100;

width = 60; // X
length = 40; // Y
height = 10; // X

corner_radius = 5;
wall_thickness = 3;
post_diameter = 10;
hole_diameter = 3;

lid_thickness = 2;
lid_lip = 2;
lid_tolerance = 0.5;

// Define the posts
module posts(x,y,z,h,r){
    translate([x,y,z]){cylinder(r=r, h=h);}
    translate([-x,y,z]){cylinder(r=r, h=h);}
    translate([-x,-y,z]){cylinder(r=r, h=h);}
    translate([x,-y,z]){cylinder(r=r, h=h);}
}

difference(){
    union(){
        difference(){
            // Generate the Enclosure
            hull(){
                posts(
                    x=(width / 2 - corner_radius),
                    y=(length / 2 - corner_radius),
                    z=0,
                    h=height,
                    r=corner_radius
                );
            }

            // Hollow out the enclosure
            hull(){
                posts(
                    x=(width / 2 - corner_radius - wall_thickness),
                    y=(length / 2 - corner_radius - wall_thickness),
                    z=wall_thickness,
                    h=height,
                    r=corner_radius
                );
            }

            // Generate the Lip
            hull(){
                posts(
                    x=(width / 2 - corner_radius - lid_lip),
                    y=(length / 2 - corner_radius - lid_lip),
                    z=(height - lid_thickness),
                    h=lid_thickness + 1,
                    r=corner_radius
                );
            }
        }

        difference(){
            // Support Posts
            posts(
                x = (width/2 - wall_thickness/2 - post_diameter/2),
                y = (length/2 - wall_thickness/2 - post_diameter/2),
                z = wall_thickness - .5,
                h = height - wall_thickness - lid_thickness + 0.5,
                r = post_diameter/2
            );

            // Holes in Posts
            posts(
                x = (width/2 - wall_thickness/2 - post_diameter/2),
                y = (length/2 - wall_thickness/2 - post_diameter/2),
                z = wall_thickness,
                h = height - wall_thickness - lid_thickness + 0.5,
                r = hole_diameter/2
            );
        }
    }
}

//Generate the Lid
difference(){
    hull(){
        posts(
            x = (width/2 - corner_radius - wall_thickness/2 - lid_tolerance),
            y = (length/2 - corner_radius - wall_thickness/2 - lid_tolerance),
            z = height - lid_thickness + 7,
            h = lid_thickness,
            r = corner_radius
        );
    }
    posts(
        x = (width/2 - wall_thickness/2 - post_diameter/2),
        y = (length/2 - wall_thickness/2 - post_diameter/2),
        z = height - lid_thickness + 7,
        h = height - wall_thickness - lid_thickness + .5,
        r = hole_diameter / 2 + .5
    );
}
