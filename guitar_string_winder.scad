
winder_width=21;
winder_height=8;
winder_depth=15;

handle_radius=4;
handle_radius2=6;
handle_length=75;
crank_length=(150 / 3);
crank_height=4;
crank_width=(winder_height + 3);

module winder_head()
{
	difference() {
		cube(size = [winder_width + 3, winder_height + 3, 
			winder_depth + 3], center=true);
		translate(v = [0, 0, 4])  {
			cube(size = [winder_width, winder_height, 
				winder_depth], center=true);
		}
	}
}

module winder_crank(x, y, z)
{
	translate(v = [x, y, z]) {
		difference() {
			cube(size = [ crank_length,
				crank_width, crank_height ],
				center = true);
			translate(v = [20, 0, -10])
			cylinder(h = 35, r1 = handle_radius,
				r2 = handle_radius, center = false);
		}
	}
}

module handle(x, y, z)
{
	translate( v = [x, y, z]) {
		union() {
			cylinder(h = handle_length, r1 = handle_radius,
				r2 = handle_radius, center = false);
			cylinder(h = handle_length - 5, r1 = handle_radius2,
				r2 = handle_radius2, center = false);
		}
	}
}


module string_winder(x, y, z)
{
	translate( v = [x, y, z]) {
		union() {
			winder_crank( crank_length / 2, 0, - winder_depth / 2 + 0.5);
			winder_head();
			handle(crank_length + 10, 0, 1.0 - 10);
		}
	}
}

string_winder(0, 0, 9);



