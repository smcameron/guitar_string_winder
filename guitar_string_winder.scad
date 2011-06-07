
/*
 *    Guitar String Winder -- OpenSCAD source
 *    Copyright 2011, Stephen M. Cameron 
 *
 *    This program is free software; you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation; version 2 of the License.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
 *    NON INFRINGEMENT.  See the GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program; if not, write to the Free Software
 *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */

/* For best printing results, export these to .stl files one at a time. */
print_pin = 1;
print_handle = 1;
print_crank = 1;

winder_width=21;
winder_height=8;
winder_depth=15;

handle_radius=5;
handle_radius2=9;
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
			cylinder(h = handle_length / 2,
				r1 = handle_radius - 0.5 ,
				r2 = handle_radius - 0.5, center = false);
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
			handle(crank_length + 25, 0, -9);
		if (print_pin != 0)
			pin(-25, 0, -9);
	}
}

string_winder(0, 0, 9);



