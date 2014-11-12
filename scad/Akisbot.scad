wall_thickness = 8;

joint_radius = 24;

body_depth = 90;
body_width = 250;
body_height = 231;
body_angle = 78.5;

head_depth = 60;
head_width = 226;
head_height = 150;
head_angle = 85;

length_of_body_top = body_width - ( 2 * ( tan(90 - body_angle) * body_height ) );

top_right = round(( (body_width - length_of_body_top) / 2 ) + length_of_body_top);
top_left = round( ( body_width - length_of_body_top ) / 2 );

length_of_head_top = head_width - ( 2 * ( tan(90 - head_angle) * head_height ) );

head_top_right = round(( (head_width - length_of_head_top) / 2 ) + length_of_head_top);
head_top_left = round( ( head_width - length_of_head_top ) / 2 );


top_joint_x_offset = ( joint_radius + wall_thickness ) * sin(90 - body_angle);
top_joint_y_offset = ( joint_radius + wall_thickness ) * cos(90 - body_angle);

peg_height_ratio = 1 / 8;
peg_radius = wall_thickness / 4;

inner_eye_radius = 22;
outer_eye_radius = 32;

inner_eye_depth = 4;
outer_eye_depth = 6;

eye_offset_x = head_width * 1 / 6;
eye_offset_y = head_height * 2 / 3;

module antenna() {
	color("gray") union() {
		translate([18,0,0])
			difference() {
				sphere(r=28);
				translate([-13,-50,-50]) cube([100,100,100]);
			};

		translate([-8,0,0]) rotate([0,270,0]) linear_extrude(22) circle(r=2);

		translate([-30,0,0]) sphere(r=8);
	}
};

module body_side() {

	color( "green" ) difference() {
		union() {
			// Base
			linear_extrude(wall_thickness) polygon([[0,0],[body_width,0], [top_right, body_height], [top_left, body_height]], [[0,1,2,3]]);
		
			// Bottom wall
			translate([0,0,wall_thickness]) linear_extrude((body_depth/2)-wall_thickness) polygon([[0,0],[body_width,0],[body_width,wall_thickness],[0,wall_thickness] ],[[0,1,2,3]]);
		
			// Top wall
			translate([0,0,wall_thickness]) linear_extrude((body_depth/2)-wall_thickness) polygon([[top_left,body_height],[top_right, body_height],[top_right,body_height-wall_thickness],[top_left,body_height-wall_thickness] ],[[0,1,2,3]]);
		
			// Left wall
			translate([0,0,wall_thickness]) linear_extrude((body_depth/2)-wall_thickness) polygon([[0,0],[top_left,body_height],[top_left+wall_thickness,body_height],[wall_thickness,0]],[[0,1,2,3]]);
		
			// Right wall
			translate([0,0,wall_thickness]) linear_extrude((body_depth/2)-wall_thickness) polygon([[body_width,0],[top_right,body_height],[top_right-wall_thickness,body_height],[body_width-wall_thickness,0]],[[0,1,2,3]]);
		
			// Bottom joint
			translate([body_width/2,joint_radius*2/3,0]) linear_extrude((body_depth/2)) circle(r=joint_radius+wall_thickness);

			// Top joint
			translate([body_width/2,body_height - (joint_radius*2/3),0]) linear_extrude((body_depth/2)) circle(r=joint_radius+wall_thickness);

			// Left joint
			translate([top_left+top_joint_x_offset,body_height - top_joint_y_offset,0]) linear_extrude((body_depth/2)) circle(r=joint_radius+wall_thickness);

			// Right joint
			translate([top_right-top_joint_x_offset,body_height - top_joint_y_offset,0]) linear_extrude((body_depth/2)) circle(r=joint_radius+wall_thickness);
		};

		// Bottom joint interior
		translate([body_width/2,(joint_radius / 3 * 2),(body_depth/2)]) sphere(r=joint_radius);

		// Top joint interior
		translate([body_width/2,body_height - (joint_radius*2/3),(body_depth/2)]) sphere(r=joint_radius);

		// Left joint interior
		translate([top_left+top_joint_x_offset,body_height - top_joint_y_offset,(body_depth/2)]) sphere(r=joint_radius);

		// Right joint interior
		translate([top_right-top_joint_x_offset,body_height - top_joint_y_offset,(body_depth/2)]) sphere(r=joint_radius);

		linear_extrude((body_depth/2)) polygon([[0,0],[body_width,0],[body_width,-100],[0,-100]],[[0,1,2,3]]);
		linear_extrude((body_depth/2)) polygon([[top_left,body_height],[top_right,body_height],[top_right,body_height+100],[top_left,body_height+100]],[[0,1,2,3]]);
		linear_extrude((body_depth/2)) polygon([[0,0],[top_left,body_height],[top_left-100,body_height],[-100,0]],[[0,1,2,3]]);
		linear_extrude((body_depth/2)) polygon([[body_width,0],[top_right,body_height],[top_right+100,body_height],[body_width+100,0]],[[0,1,2,3]]);
	}
};

module back() {
	difference() {
		body_side();

		// Corner peg holes
		translate([wall_thickness/3*2,wall_thickness/2, (body_depth/2)-(body_depth / 2 * peg_height_ratio*1.25)]) linear_extrude(body_depth / 2 * peg_height_ratio * 1.25) circle(r=peg_radius*1.25);
		translate([body_width-(wall_thickness/3*2),wall_thickness/2, (body_depth/2)-(body_depth / 2 * peg_height_ratio*1.25)]) linear_extrude(body_depth / 2 * peg_height_ratio*1.25) circle(r=peg_radius*1.25);
		translate([top_left+(wall_thickness/3*2),body_height-(wall_thickness/2), (body_depth/2)-(body_depth / 2 * peg_height_ratio*1.25)]) linear_extrude(body_depth / 2 * peg_height_ratio*1.25) circle(r=peg_radius*1.25);
		translate([top_right-(wall_thickness/3*2),body_height-(wall_thickness/2), (body_depth/2)-(body_depth / 2 * peg_height_ratio*1.25)]) linear_extrude(body_depth / 2 * peg_height_ratio*1.25) circle(r=peg_radius*1.25);
		
	};
};

module base() {
	axle_thickness = 20;
	wheel_width = 125;
	wheel_depth = 80;

	union() {
		color( "green" ) rotate([0,180,0]) translate( [0,0,-40]) union() {
			linear_extrude(60) rotate([0,90,0]) circle(r=joint_radius * 3 / 4);

			difference() {
				sphere(r=joint_radius);
				translate( [0,0,-joint_radius*3/2]) cube([joint_radius*2,joint_radius*2,joint_radius*2], true);
			}
		};

		translate( [0,0,-20]) treads();

		translate( [0,0,-20]) color( "green" ) rotate([0,-90,90]) rotate([90,0,90]) translate([0,0,-axle_thickness/2]) translate([0,0,-10])linear_extrude(40) square([202,wheel_depth], true);
	}
};

module button() {
	cube([24,14,6]);
};

module eye() {
	difference() {
		color( "white" ) linear_extrude(inner_eye_depth) circle(r=inner_eye_radius*.95);
		color( "black" ) translate([-inner_eye_depth,0,-2]) linear_extrude(20) square(10);
	}
};

module forearm() {
	color( "green" ) translate([0,0,-9]) union() {
		translate([0,0,12]) outer_arm_joint();

		translate([0,0,6]) rotate([180,0,0]) outer_arm_joint();

		translate([0,0,9]) rotate([90,0,0]) difference() {
			linear_extrude(40) circle(r=9);
			translate([0,9,0]) rotate([90,0,0]) linear_extrude(18) circle(r=15);
		}

		translate([0,-40,9]) rotate([90,0,0]) linear_extrude(25) circle(r=5);

		translate([0,-85,0]) linear_extrude(joint_radius) rotate([180,0,0])
		difference() {
			difference() {
				circle(r=25);
				circle(r=15);
			}
			translate([-4,0,0]) square([8,50]);
		}
	}
};

module outer_arm_joint() {
	color( "green" ) difference() {
		linear_extrude(6) circle(r=15);
		linear_extrude(2) circle(r=4);
	}
};

module front() {
	difference() {
		color( "green" ) body_side();
		color( "black" ) translate([132,176,0]) cube([4,30,2]);
		color( "black" ) translate([140,176,0]) cube([4,30,2]);
		color( "black" ) translate([148,176,0]) cube([4,30,2]);
		color( "black" ) translate([156,176,0]) cube([4,30,2]);
		color( "black" ) translate([164,176,0]) cube([4,30,2]);
		color( "black" ) translate([172,176,0]) cube([4,30,2]);
		color( "black" ) translate([180,176,0]) cube([4,30,2]);
		color( "black" ) translate([188,176,0]) cube([4,30,2]);
	};

	

	// Corner peg holes
	translate([wall_thickness/3*2,wall_thickness/2, body_depth / 2]) linear_extrude(body_depth / 2 * peg_height_ratio) circle(r=peg_radius);
	translate([body_width-(wall_thickness/3*2),wall_thickness/2, body_depth / 2]) linear_extrude(body_depth / 2 * peg_height_ratio) circle(r=peg_radius);
	translate([top_left+(wall_thickness/3*2),body_height-(wall_thickness/2), body_depth / 2]) linear_extrude(body_depth / 2 * peg_height_ratio) circle(r=peg_radius);
	translate([top_right-(wall_thickness/3*2),body_height-(wall_thickness/2), body_depth / 2]) linear_extrude(body_depth / 2 * peg_height_ratio) circle(r=peg_radius);
};

module head_side() {
	length_of_top = head_width - ( 2 * ( tan(90 - head_angle) * head_height ) );
	top_right = round(( (head_width - length_of_top) / 2 ) + length_of_top);
	top_left = round( ( head_width - length_of_top ) / 2 );

	top_joint_x_offset = ( joint_radius + wall_thickness ) * sin(90 - head_angle);
	top_joint_y_offset = ( joint_radius + wall_thickness ) * cos(90 - head_angle);

	color( "green" ) difference() {
		union() {
			// Base
			linear_extrude(wall_thickness) polygon([[0,0],[head_width,0], [top_right, head_height], [top_left, head_height]], [[0,1,2,3]]);
		
			// Bottom wall
			translate([0,0,wall_thickness]) linear_extrude((head_depth/2)-wall_thickness) polygon([[0,0],[head_width,0],[head_width,wall_thickness],[0,wall_thickness] ],[[0,1,2,3]]);
		
			// Top wall
			translate([0,0,wall_thickness]) linear_extrude((head_depth/2)-wall_thickness) polygon([[top_left,head_height],[top_right, head_height],[top_right,head_height-wall_thickness],[top_left,head_height-wall_thickness] ],[[0,1,2,3]]);
		
			// Left wall
			translate([0,0,wall_thickness]) linear_extrude((head_depth/2)-wall_thickness) polygon([[0,0],[top_left,head_height],[top_left+wall_thickness,head_height],[wall_thickness,0]],[[0,1,2,3]]);
		
			// Right wall
			translate([0,0,wall_thickness]) linear_extrude((head_depth/2)-wall_thickness) polygon([[head_width,0],[top_right,head_height],[top_right-wall_thickness,head_height],[head_width-wall_thickness,0]],[[0,1,2,3]]);
		
			// Bottom joint
			translate([head_width/2,joint_radius*2/3,0]) linear_extrude((head_depth/2)) circle(r=joint_radius+wall_thickness);
		};

		// Bottom joint interior
		translate([head_width/2,(joint_radius / 3 * 2),(head_depth/2)]) sphere(r=joint_radius);

		linear_extrude((head_depth/2)) polygon([[0,0],[head_width,0],[head_width,-100],[0,-100]],[[0,1,2,3]]);
		linear_extrude((head_depth/2)) polygon([[top_left,head_height],[top_right,head_height],[top_right,head_height+100],[top_left,head_height+100]],[[0,1,2,3]]);
		linear_extrude((head_depth/2)) polygon([[0,0],[top_left,head_height],[top_left-100,head_height],[-100,0]],[[0,1,2,3]]);
		linear_extrude((head_depth/2)) polygon([[head_width,0],[top_right,head_height],[top_right+100,head_height],[head_width+100,0]],[[0,1,2,3]]);
	}
};

module head_back() {
	union() {
		head_side();

		// Corner pegs
		translate([wall_thickness/3*2,wall_thickness/2, head_depth / 2]) linear_extrude(head_depth / 2 * peg_height_ratio) circle(r=peg_radius);
		translate([head_width-(wall_thickness/3*2),wall_thickness/2, head_depth / 2]) linear_extrude(head_depth / 2 * peg_height_ratio) circle(r=peg_radius);
		translate([head_top_left+(wall_thickness/3*2),head_height-(wall_thickness/2), head_depth / 2]) linear_extrude(head_depth / 2 * peg_height_ratio) circle(r=peg_radius);
		translate([head_top_right-(wall_thickness/3*2),head_height-(wall_thickness/2), head_depth / 2]) linear_extrude(head_depth / 2 * peg_height_ratio) circle(r=peg_radius);
	};		
};

module head_front() {
	difference() {
		union() {
			difference() {
				color( "green" ) head_side();
	
				// Smile
				color( "gray" ) linear_extrude(wall_thickness / 2) polygon( [
						[0, .41 * head_height],
						[.12 * head_width, .35 * head_height],
						[.16 * head_width, .2 * head_height],
						[.33 * head_width, .15 * head_height],
						[head_width / 2, .14 * head_height],
						[( 1 - .16 ) * head_width, .2 * head_height],
						[( 1 - .12 ) * head_width, .35 * head_height],
						[head_width, .41 * head_height],
		
						[0, (.41 * head_height)+(wall_thickness / 2)],
						[.12 * head_width, (.35 * head_height)+(wall_thickness / 2)],
						[.16 * head_width, (.2 * head_height)+(wall_thickness / 2)],
						[.33 * head_width, (.15 * head_height)+(wall_thickness / 2)],
						[head_width / 2, (.14 * head_height)+(wall_thickness / 2)],
						[( 1 - .16 ) * head_width, (.2 * head_height)+(wall_thickness / 2)],
						[( 1 - .12 ) * head_width, (.35 * head_height)+(wall_thickness / 2)],
						[head_width, (.41 * head_height)+(wall_thickness / 2)]
					],
					[
						[0,1,2,3,4,5,6,7,15,14,13,12,11,10,9,8]
					]
				);
			};
	
			// Eye rings
			color( "green" ) translate([0, eye_offset_y, outer_eye_depth * -1]) union() {
				translate([(head_width / 2) + eye_offset_x, 0, 0]) linear_extrude(outer_eye_depth) difference() {
					circle(r=outer_eye_radius);
					circle(r=inner_eye_radius);
				};
	
				translate([(head_width / 2) - eye_offset_x, 0, 0]) linear_extrude(outer_eye_depth) difference() {
					circle(r=outer_eye_radius);
					circle(r=inner_eye_radius);
				};
			};
	
			color( "white" ) translate([0,0,-wall_thickness / 4]) linear_extrude(wall_thickness / 4) union() {
				// Todo These percentages for x offset should be calculated using trig based on the had angle.
				translate([head_width * 0.05, .32*head_height, 0]) circle(r=.0125 * head_width);
				translate([head_width * 0.06, .47*head_height, 0]) circle(r=.0125 * head_width);
		
				translate([head_width * 0.95, .32*head_height, 0]) circle(r=.0125 * head_width);
				translate([head_width * 0.94, .47*head_height, 0]) circle(r=.0125 * head_width);	
			};
		};

		// Corner peg holes
		translate([0, 0, (head_depth / 2) - (head_depth / 2 * peg_height_ratio * 1.25)]) linear_extrude(head_depth / 2 * peg_height_ratio * 1.25) union() {
			translate([wall_thickness / 3 * 2, wall_thickness / 2, 0]) circle(r=peg_radius*1.25);
			translate([head_width - (wall_thickness / 3 * 2), wall_thickness / 2, 0]) circle(r=peg_radius * 1.25);
			translate([head_top_left + (wall_thickness / 3 * 2), head_height - (wall_thickness / 2), 0]) circle(r=peg_radius * 1.25);
			translate([head_top_right - (wall_thickness / 3 * 2), head_height - (wall_thickness / 2), 0]) circle(r=peg_radius * 1.25);
		};
	};
};

module meter() {
	union() {
		color( "white" ) linear_extrude(3) difference() {
			circle(r=60);
			translate([-100,-23,0]) square(200);
		}

		color( "white" ) linear_extrude(5) difference() {
			circle(r=65);
			translate([-100,-23,0]) square(200);
			circle(r=60);
		}

		color( "black" ) translate([0,-32,1]) linear_extrude(5) rotate([0,0,135]) union() {
			circle(r=5);
			polygon([[-5,0], [0,25], [5,0]], [[0,1,2]]);
		}
	}
};

module nameplate() {
	union() {
		color( "darkgreen" ) linear_extrude(2) square([60,13]);

		color( "white" ) union() {
			// A
			translate([9,3,2]) linear_extrude(1) square([1,7]);
			translate([13,3,2]) linear_extrude(1) square([1,7]);
	
			translate([10,9,2]) linear_extrude(1) square([3,1]);
			translate([10,6,2]) linear_extrude(1) square([3,1]);
	
			// K
			translate([16,3,2]) linear_extrude(1) square([1,7]);
	
			translate([0,0,2]) linear_extrude(1) polygon([[17,5],[19,3], [20,3], [20,4.5], [17.5,6.5], [20,8.5],[20,10],[19,10],[17,8]], [[0,1,2,3,4,5,6,7,8]]);
	
			// I
			translate([22,3,2]) linear_extrude(1) square([1,7]);
	
			// S
			translate([25,6,2]) linear_extrude(1) square([1,3]);
			translate([29,4,2]) linear_extrude(1) square([1,3]);
	
			translate([25,9,2]) linear_extrude(1) square([5,1]);
			translate([26,6,2]) linear_extrude(1) square([3,1]);
			translate([25,3,2]) linear_extrude(1) square([5,1]);
	
			// B
			translate([32,3,2]) linear_extrude(1) square([1,7]);
			translate([36,3,2]) linear_extrude(1) square([1,7]);
	
			translate([33,9,2]) linear_extrude(1) square([3,1]);
			translate([33,6,2]) linear_extrude(1) square([3,1]);
			translate([33,3,2]) linear_extrude(1) square([3,1]);
	
			// O
			translate([39,3,2]) linear_extrude(1) square([1,7]);
			translate([43,3,2]) linear_extrude(1) square([1,7]);
	
			translate([40,9,2]) linear_extrude(1) square([3,1]);
			translate([40,3,2]) linear_extrude(1) square([3,1]);
	
			// T
			translate([48,3,2]) linear_extrude(1) square([1,7]);
			translate([46,9,2]) linear_extrude(1) square([5,1]);
		}
	}
};

module neck() {
	neck_length = 25;
	neck_girth = 16;

	translate([-neck_length,0,0]) union() {
		translate([-neck_length/2,0,0]) rotate([0,90,0]) linear_extrude(neck_length) circle(r=neck_girth / 2);

		difference() {
			translate([neck_length,0,0]) sphere(r=joint_radius*.95);
			translate([neck_length+(joint_radius*5/3),0,0]) cube([joint_radius*2, joint_radius*2, joint_radius*2],true);
		};

		mirror([1,0,0]) difference() {
			translate([neck_length,0,0]) sphere(r=joint_radius*.95);
			translate([neck_length+(joint_radius*5/3),0,0]) cube([joint_radius*2, joint_radius*2, joint_radius*2],true);
		};
	};
};

inner_arm_joint_radius = 15;
inner_arm_joint_height = 18;
inner_arm_joint_bump_radius = 3.5;
inner_arm_joint_bump_height = 2;

upper_arm_length = 70;
upper_arm_girth = 16;

module inner_arm_joint() {
	translate([0,0,-inner_arm_joint_height/3/2]) union() {
		linear_extrude(inner_arm_joint_height/3) circle(r=inner_arm_joint_radius);
		translate([0,0,inner_arm_joint_height/3])
			linear_extrude(inner_arm_joint_bump_height) circle(r=inner_arm_joint_bump_radius);
		translate([0,0,-inner_arm_joint_bump_height])
			linear_extrude(inner_arm_joint_bump_height) circle(r=inner_arm_joint_bump_radius);
	}
};

module upper_arm() {
	color( "green" ) union() {
		difference() {
			sphere(r=joint_radius);
			translate([(joint_radius*5/3),0,0]) cube([joint_radius*2, joint_radius*2, joint_radius*2],true);
		};
	
		difference() {
			rotate([0,90,0]) translate([0,0,-(upper_arm_length+joint_radius)]) linear_extrude(upper_arm_length+joint_radius)  circle(r=upper_arm_girth/2);
			translate([-(upper_arm_length+joint_radius),0,-inner_arm_joint_height/2]) linear_extrude(inner_arm_joint_height) circle(r=inner_arm_joint_radius);
		};
	
		translate([-(upper_arm_length+joint_radius),0,0]) inner_arm_joint();
	}
};

module treads() {
	color( "gray" ) translate([100,0,0]) scale(3) translate([-5,-36.5,-2.5]) rotate([90,0,90]) import("Tread Brace.stl");
	color( "gray" ) translate([-100,0,0]) scale(3) translate([0,-1.5,0]) rotate([0,0,180]) translate([-5,-36.5,-2.5]) rotate([90,0,90]) import("Tread Brace.stl");

	translate([-102,90,0]) wheel();
	translate([-102,-90,0]) wheel();
	translate([102,90,0]) rotate([0,0,180]) wheel();
	translate([102,-90,0]) rotate([0,0,180]) wheel();

	color( "black") translate([-102,0,0]) crawler();
	color( "black") translate([102,0,0]) crawler();
}

module wheel() {
	color( "gray" ) translate([-42,-6,-32])  rotate([0,0,-30]) scale(3) import( "Tread Wheel.stl" );
}

module crawler() {
	translate([27.5,180,182]) rotate( [90, 0,90]) scale(3) import( "Treads.stl" );
}