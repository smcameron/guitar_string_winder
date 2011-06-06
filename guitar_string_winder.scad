
/* For best printing results, export these to .stl files one at a time. */
print_pin = 1;
print_handle = 1;
print_crank = 1;

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
			union() {
				cube(size = [ crank_length,
					crank_width, crank_height ],
					center = true);
				translate(v = [20 + crank_width / 2, 0, -crank_height / 2])
					cylinder(h = crank_height, r1 = handle_radius2,
						r2 = handle_radius2, center = false);
			}
			translate(v = [20 + crank_width / 2, 0, -10])
				cylinder(h = 35, r1 = handle_radius,
					r2 = handle_radius, center = false);
		}
	}
}

module pin(x, y, z)
{
	translate( v = [x, y, z]) {
		union() {
			cylinder(h = handle_length / 5,
				r1 = handle_radius,
				r2 = handle_radius, center = false);
			cylinder(h = handle_length / 20,
				r1 = handle_radius2, 
				r2 = handle_radius2, center = false);
		}
	}
}

module handle(x, y, z)
{
	translate( v = [x, y, z]) {
		difference() {
			cylinder(h = handle_length, r1 = handle_radius2,
				r2 = handle_radius2, center = false);
			translate( v = [ 0, 0, 5 ])
				cylinder(h = handle_length - 5,
					r1 = handle_radius,
					r2 = handle_radius, center = false);
		}
	}
}


module string_winder(x, y, z)
{
	translate( v = [x, y, z]) {
		union() {
			if (print_crank != 0) {
				winder_crank( crank_length / 2, 0, - winder_depth / 2 + 0.5);
				winder_head();
			}
		}
		if (print_handle != 0)
			handle(crank_length + 15, 0, -9);
		if (print_pin != 0)
			pin(-20, 0, -9);
	}
}

string_winder(0, 0, 9);



