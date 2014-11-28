$fa = 1;
$fs = 1;

/**
 * General
 */
wall_thickness = 8;
joint_radius = 24;
joint_ball_radius = 23.5;
peg_height_ratio = 1 / 8;
peg_radius = wall_thickness / 4;
peg_hole_radius = peg_radius * 1.25;
peg_corner_offset = wall_thickness / 3 * 2;

/**
 * Body
 */
body_depth = 90;
body_width = 250;
body_height = 231;
body_angle = 78.5;

length_of_body_top = body_width - ( 2 * ( tan(90 - body_angle) * body_height ) );

top_right = round(( (body_width - length_of_body_top) / 2 ) + length_of_body_top);
top_left = round( ( body_width - length_of_body_top ) / 2 );

vent_depth = wall_thickness * .25;
vent_height = body_height * .14;
vent_width = body_width *.22;
nameplate_width = vent_width;
nameplate_height = nameplate_width * .23;
nameplate_depth = wall_thickness * .125;
vent_count = 8;

vent_left = top_left + ( length_of_body_top * .08 );
vent_top = body_height * .9;

nameplate_top = vent_top - vent_height - (nameplate_height / 2 );
nameplate_left = vent_left;

meter_width = body_width * .5;
button_width = meter_width / 5;
button_height = button_width * .7;
button_depth = body_depth * 0.07;

/**
 * Head
 */
head_depth = 60;
head_width = 226;
head_height = 150;
head_angle = 85;

length_of_head_top = head_width - ( 2 * ( tan(90 - head_angle) * head_height ) );

head_top_right = round(( (head_width - length_of_head_top) / 2 ) + length_of_head_top);
head_top_left = round( ( head_width - length_of_head_top ) / 2 );

neck_length = 60;
neck_girth = 20;

antenna_length = head_width * 0.2;
antenna_girth = 7;
antenna_ball_radius = 8;
antenna_base_radius = head_depth * 0.4;

/**
 * Shoulders
 */
top_joint_x_offset = ( joint_radius + wall_thickness ) * sin(90 - body_angle);
top_joint_y_offset = ( joint_radius + wall_thickness ) * cos(90 - body_angle);

/**
 * Face
 */

inner_eye_radius = 22;
outer_eye_radius = 32;

inner_eye_depth = 4;
outer_eye_depth = 6;

eye_offset_x = head_width * 1 / 6;
eye_offset_y = head_height * 2 / 3;

pupil_width = inner_eye_radius * .45;

/**
 * Arms
 */

upper_arm_length = 70;
upper_arm_girth = 20;

outer_arm_joint_height = upper_arm_girth;
outer_arm_joint_radius = 15;

forearm_radius = outer_arm_joint_height / 2;

claw_radius_outer = 25;
claw_radius_inner = 15;
claw_opening_width = 8;
claw_depth = forearm_radius * 2;
forearm_length = 40;
wrist_length = 25;
wrist_radius = 6;

outer_arm_joint_peg_radius = 4;

inner_arm_joint_radius = 15;
inner_arm_joint_height = outer_arm_joint_height;
inner_arm_joint_bump_radius = outer_arm_joint_peg_radius;
inner_arm_joint_bump_height = outer_arm_joint_height / 3 / 3;
elbow_joint_ball_height = inner_arm_joint_height / 3 * .7;

/**
 * Base
 */
wheel_gap = body_width * 0.8;
wheel_depth = 80;
base_depth = body_depth * 0.5;
base_height = 60;

// Measured.
tread_crawler_horizontal_length = 187.5;



tread_width = 60;

wheel_radius = base_depth / 2 * 1.2;

axle_radius = 7.7;
tread_brace_thickness = 8;
wheel_wall_thickness = tread_brace_thickness;



tread_circumference = (2 * PI * (base_depth / 2)) + (2 * tread_crawler_horizontal_length);
tread_radius_inner = tread_circumference / ( 2 * PI );
tread_height = 5; // track thickness (difference in radius between inside and outside)
tread_radius_outer = tread_radius_inner + tread_height; // outside radius of track

tread_thickness=0.2; // thread width
tread_tooth_count=40; // number of teeth around the track
tread_tooth_ratio=0.6; // tooth size ratio (between 0 and 1)

// The part of each wheel that touches the tread accounts for X% of the total tread length.
wheel_percentage = ((2 * PI * (base_depth / 2)) / 2) / tread_circumference;
wheel_tooth_count = floor(wheel_percentage * tread_tooth_count * 2); // Multiply by two to account for half of the teeth being unused at any moment.

// ai is the diameter of the indentations in the wheel
ai = (((wheel_radius / wheel_tooth_count) * (2 * PI)) - (4 * tread_thickness)) * tread_tooth_ratio;
indentation_circle_radius = ((tread_circumference / tread_tooth_count / 2) - (2 * tread_thickness)) * 0.45;

module antenna() {
	rotate([270+head_angle,0,0]) color( "gray" ) union() {
		translate([0, 0, -antenna_base_radius * 0.5]) difference() {
			sphere(r=antenna_base_radius);
			rotate([90-head_angle,0,0]) translate([0, 0, -antenna_base_radius * 0.5]) cube(antenna_base_radius * 2, true);
		};

		// Stop short of the full length so that the cylinder doesn't pole through the top of the ball.
		cylinder(r=antenna_girth / 2, h=antenna_length - (antenna_ball_radius / 2));

		translate([0, 0, antenna_length - antenna_ball_radius]) sphere(r=antenna_ball_radius);
	};
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

		linear_extrude((body_depth/2)) polygon([[0,0],[body_width,0],[body_width,-(joint_radius+wall_thickness)],[0,-(joint_radius+wall_thickness)]],[[0,1,2,3]]);
		linear_extrude((body_depth/2)) polygon([[top_left,body_height],[top_right,body_height],[top_right,body_height+(joint_radius+wall_thickness)],[top_left,body_height+(joint_radius+wall_thickness)]],[[0,1,2,3]]);
		linear_extrude((body_depth/2)) polygon([[0,0],[top_left,body_height],[top_left-(joint_radius+wall_thickness),body_height],[-(joint_radius+wall_thickness),0]],[[0,1,2,3]]);
		linear_extrude((body_depth/2)) polygon([[body_width,0],[top_right,body_height],[top_right+(joint_radius+wall_thickness),body_height],[body_width+(joint_radius+wall_thickness),0]],[[0,1,2,3]]);
	}
};

/**
 * The back of the robot body.
 */
module back() {
	difference() {
		body_side();

		// Peg holes
		translate([0, 0, (body_depth / 2) - (body_depth / 2 * peg_height_ratio * 1.25)]) linear_extrude(body_depth / 2 * peg_height_ratio * 1.25) union() {
			translate([0, wall_thickness / 2, 0]) union() {
				// Bottom holes.
				translate([peg_corner_offset, 0, 0]) circle(r=peg_hole_radius);
				translate([body_width - peg_corner_offset, 0, 0]) circle(r=peg_hole_radius);
								translate([body_width / 2 - joint_radius - ( wall_thickness / 2 ), 0, 0]) circle(r=peg_hole_radius);
								translate([body_width / 2 + joint_radius + ( wall_thickness / 2 ), 0, 0]) circle(r=peg_hole_radius);

			};

			translate([0, body_height - (wall_thickness / 2), 0]) union() {
				// Top holes.
				translate([top_left + peg_corner_offset, 0, 0]) circle(r=peg_hole_radius);
				translate([top_right - peg_corner_offset, 0, 0]) circle(r=peg_hole_radius);
								translate([body_width / 2 - joint_radius - ( wall_thickness / 2 ), 0, 0]) circle(r=peg_hole_radius);
								translate([body_width / 2 + joint_radius + ( wall_thickness / 2 ), 0, 0]) circle(r=peg_hole_radius);
						};

						translate([0, body_height / 2, 0]) union() {
							// Side holes.
							translate([(top_left + wall_thickness) / 2, 0, 0]) circle(r=peg_hole_radius);
							translate([top_right + ( (body_width - top_right - wall_thickness ) / 2 ), 0, 0]) circle(r=peg_hole_radius);
						};
	   		};
	};
};

/**
 * The "leg".
 */
module base() {
	middle_bar_width = joint_radius * 3 / 4 * 3;
	hole_width = ( wheel_gap - middle_bar_width - ( wall_thickness * 2 ) ) / 2;

	difference() {
		cube([wheel_gap, wheel_depth, base_depth], true );
		cube([wheel_gap - (wall_thickness * 2), wheel_depth - (wall_thickness * 2), base_depth], true );
	};

	cube([joint_radius * 3 / 4 * 3, wheel_depth, base_depth], true );

	cylinder(r=joint_radius * 3 / 4, h=base_height);

	translate([0, 0, base_height]) difference() {
		sphere(r=joint_ball_radius);
		translate([0, 0, joint_ball_radius / 2 * 3]) cube(joint_ball_radius * 2, true);
	};

	// The "A" logos.
	translate([0, 0, -base_depth / 2]) linear_extrude(base_depth) union() {
		translate([ ( middle_bar_width / 2 ) + ( hole_width / 2 ), -( wheel_depth )  / 2, 0]) scale(0.75) translate([-60,0,0]) import ("../inc/A.dxf");
		rotate([0,0,180]) translate([ ( middle_bar_width / 2 ) + ( hole_width / 2 ), -( wheel_depth )  / 2, 0]) scale(0.75) translate([-60,0,0]) import ("../inc/A.dxf");
	};
};

/**
 * The button under the meter on his chest.
 */

module button() {
    cube([button_width, button_height, button_depth + wall_thickness]);
}

/**
 * The combined set of buttons that can be inserted from the inside of the body front.
 */
module buttons() {
    rotate([90, 0, 0]) union() {
        translate([-meter_width*1.25*.5, -button_height * .125, -3]) color( "white") cube([meter_width * 1.25, button_height * 1.25, 3]);
        color( "yellow" ) translate([-meter_width / 2,0,0]) button();
        color( "red" ) translate([(-meter_width / 2) + button_width + (meter_width * .25 / 3),0,0]) button();
        color( "purple" ) translate([meter_width *.25 / 3 / 2,0,0]) button();
        color( "aqua" ) translate([-button_width + (meter_width / 2),0,0]) button();
    }
}

/**
 * The inner portion of the eye.
 */
module eye() {
	difference() {
		color( "white" ) cylinder(r=inner_eye_radius * .975, h=inner_eye_depth );
		color( "black" ) cube([pupil_width,pupil_width,inner_eye_depth]);
	}
};

/**
 * From the elbow to the end of the claw.
 */
module forearm() {
	color( "green" ) translate([0,0,-outer_arm_joint_height / 2]) union() {
		// The ball of the elbow joint.
		translate([0,0,outer_arm_joint_height / 2]) elbow_joint_ball();

		// The thicker part of the forearm.
		translate([0,0,outer_arm_joint_height / 2]) rotate([90,0,0]) difference() {
			cylinder(r=forearm_radius, h=forearm_length);
			translate([0,outer_arm_joint_height / 2,0]) rotate([90,0,0]) cylinder(r=outer_arm_joint_radius, h=outer_arm_joint_height);
		}

		// The thinner part of the forearm.
		translate([0,-(forearm_length),outer_arm_joint_height / 2]) rotate([90,0,0]) cylinder(r=wrist_radius, h=wrist_length);

		// The claw.
		translate([0,-(forearm_length+wrist_length+outer_arm_joint_radius+((claw_radius_outer-claw_radius_inner)*.75)),(outer_arm_joint_height / 2) - (claw_depth / 2 )]) linear_extrude(claw_depth) rotate([180,0,0])
		difference() {
			difference() {
				circle(r=claw_radius_outer);
				circle(r=claw_radius_inner);
			}
			translate([-claw_opening_width/2,0,0]) square([claw_opening_width,claw_radius_outer]);
		}
	}
};

/**
 * The front of his body.
 */
module front() {
	individual_vent_width = (vent_width / ((vent_count * 2) - 1 ));
	peg_height = (body_depth / 2 * peg_height_ratio);

	difference() {
		color( "green" ) body_side();

		/**
		 * The vent.
		 */
		color( "black" ) translate([body_width - vent_left - vent_width,vent_top - vent_height,0]) union() {
			for ( i = [0 : vent_count - 1] ) {
				translate([i * individual_vent_width * 2, 0, 0]) cube([individual_vent_width,vent_height,vent_depth]);
			};
		};
	};

	// Corner pegs
	translate([0, 0, body_depth / 2]) union() {
		translate([0, wall_thickness / 2, 0]) union() {
			// Bottom pegs.
			translate([peg_corner_offset, 0, 0]) cylinder(h=peg_height,r1=peg_radius, r2=peg_radius / 2);
			translate([body_width-peg_corner_offset, 0, 0]) cylinder(h=peg_height,r1=peg_radius, r2=peg_radius / 2);
						translate([body_width / 2 - joint_radius - ( wall_thickness / 2 ), 0, 0]) cylinder(h=peg_height,r1=peg_radius, r2=peg_radius / 2);
						translate([body_width / 2 + joint_radius + ( wall_thickness / 2 ), 0, 0]) cylinder(h=peg_height,r1=peg_radius, r2=peg_radius / 2);
		};

		translate([0, body_height - (wall_thickness / 2), 0]) union() {
			// Top pegs.
			translate([top_left+peg_corner_offset, 0, 0]) cylinder(h=peg_height,r1=peg_radius, r2=peg_radius / 2);
			translate([top_right-peg_corner_offset, 0, 0]) cylinder(h=peg_height,r1=peg_radius, r2=peg_radius / 2);
						translate([body_width / 2 - joint_radius - ( wall_thickness / 2 ), 0, 0]) cylinder(h=peg_height,r1=peg_radius, r2=peg_radius / 2);
						translate([body_width / 2 + joint_radius + ( wall_thickness / 2 ), 0, 0]) cylinder(h=peg_height,r1=peg_radius, r2=peg_radius / 2);

		};
				translate([0, body_height / 2, 0]) union() {
					   // Side holes.
					   translate([(top_left + wall_thickness) / 2, 0, 0]) cylinder(h=peg_height,r1=peg_radius, r2=peg_radius / 2);
					   translate([top_right + ( (body_width - top_right - wall_thickness ) / 2 ), 0, 0]) cylinder(h=peg_height,r1=peg_radius, r2=peg_radius / 2);
				};
	};
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
	peg_height = (head_depth / 2 * peg_height_ratio);

	union() {
		head_side();

		// Corner pegs
		translate([0, 0, head_depth / 2]) union() {
			translate([0, wall_thickness / 2, 0]) union() {
				// Bottom pegs.
				translate([peg_corner_offset, 0, 0]) cylinder(h=peg_height,r1=peg_radius, r2=peg_radius / 2);
				translate([head_width-peg_corner_offset, 0, 0]) cylinder(h=peg_height,r1=peg_radius, r2=peg_radius / 2);
			};

			translate([0, head_height - (wall_thickness / 2), 0]) union() {
				// Top pegs.
				translate([head_top_left+peg_corner_offset, 0, 0]) cylinder(h=peg_height,r1=peg_radius, r2=peg_radius / 2);
				translate([head_top_right-peg_corner_offset, 0, 0]) cylinder(h=peg_height,r1=peg_radius, r2=peg_radius / 2);
			};
		};
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

			/*


			color( "white" ) translate([0,0,-wall_thickness / 4]) linear_extrude(wall_thickness / 4) union() {
				// Todo These percentages for x offset should be calculated using trig based on the had angle.
				translate([head_width * 0.05, .32*head_height, 0]) circle(r=.0125 * head_width);
				translate([head_width * 0.06, .47*head_height, 0]) circle(r=.0125 * head_width);

				translate([head_width * 0.95, .32*head_height, 0]) circle(r=.0125 * head_width);
				translate([head_width * 0.94, .47*head_height, 0]) circle(r=.0125 * head_width);
			};
			*/
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

module eye_ring() {
	// Eye rings
	color( "green" ) linear_extrude(outer_eye_depth) difference() {
		circle(r=outer_eye_radius);
		circle(r=inner_eye_radius);
	};
};

module meter() {

	union() {
		color( "white" ) linear_extrude(3) difference() {
			circle(r=meter_width / 2 * .92);
			translate([-100,-23,0]) square(200);
		}

		color( "white" ) linear_extrude(5) difference() {
			circle(r=meter_width / 2);
			translate([-100,-23,0]) square(200);
			circle(r=meter_width / 2 * .92);
		}

		color( "black" ) translate([0,-32,1]) linear_extrude(5) rotate([0,0,135]) union() {
			circle(r=5);
			polygon([[-5,0], [0,25], [5,0]], [[0,1,2]]);
		}
	}
};

module nameplate_stamp() {
	linear_extrude(3) square([nameplate_width*2,nameplate_height], true);
	mirror([1,0,0]) linear_extrude(10) text(text="AKISBOT", size=nameplate_height*0.68, halign="center", valign="center", spacing=1.1);
};

module neck() {
	color( "green" ) union() {
		translate([neck_length / 2, 0, 0]) difference() {
			sphere(r=joint_ball_radius);
			translate([( joint_ball_radius * 4 / 3 ), 0, 0]) cube(joint_ball_radius * 2, true);
		};

		mirror([1,0,0]) translate([neck_length / 2, 0, 0]) difference() {
			sphere(r=joint_ball_radius);
			translate([( joint_ball_radius * 4 / 3 ), 0, 0]) cube(joint_ball_radius * 2, true);
		};

		rotate([0, 90, 0]) translate([0, 0, -(neck_length / 2)]) cylinder(r=neck_girth / 2, h=neck_length);
	}
};

module elbow_joint_ball() {
	translate([0,0,-elbow_joint_ball_height/2]) union() {
		// The "ball."
		cylinder(r=inner_arm_joint_radius, h=elbow_joint_ball_height);

		// The bottom peg.
		translate([0,0,-inner_arm_joint_bump_height]) cylinder(h=inner_arm_joint_bump_height, r2=inner_arm_joint_bump_radius, r1 = inner_arm_joint_bump_radius / 2 );

		// The top peg.
		translate([0,0,elbow_joint_ball_height]) cylinder(h=inner_arm_joint_bump_height, r1=inner_arm_joint_bump_radius, r2 = inner_arm_joint_bump_radius / 2 );
	};
};

module upper_arm() {
	color( "green" ) union() {
		// Shoulder joint.
		difference() {
			sphere(r=joint_ball_radius);
			translate([(joint_radius*4/3),0,0]) cube([joint_radius*2, joint_radius*2, joint_radius*2],true);
		};

		difference() {
			rotate([0,90,0]) translate([0,0,-(upper_arm_length+joint_radius)]) linear_extrude(upper_arm_length+joint_radius)  circle(r=upper_arm_girth/2);
			translate([-(upper_arm_length+joint_radius),0,-inner_arm_joint_height/2]) linear_extrude(inner_arm_joint_height) circle(r=inner_arm_joint_radius);
		};

		// The outside circular joint pieces at the elbow.
		translate([-(upper_arm_length+joint_radius),0,-(outer_arm_joint_height/2)]) difference() {
			// The outer parts of the socket.
			cylinder(r=outer_arm_joint_radius, h=outer_arm_joint_height);

			// The opening for elbow_joint_ball.
			translate([0,0,outer_arm_joint_height / 3]) cylinder(r=outer_arm_joint_radius, h=outer_arm_joint_height / 3);

			// The center hole for the pegs.
			cylinder(r=outer_arm_joint_peg_radius, h=outer_arm_joint_height);
		};
	}
};

wheel_axle_offset = (tread_crawler_horizontal_length / 2) + (axle_radius);

/**
 * The brace that holds the wheels.
 */
module tread_brace() {
	color( "green" ) difference() {
		union() {
			cube([tread_brace_thickness, tread_crawler_horizontal_length, base_depth], true);
			translate([-tread_brace_thickness/2, 0, 0]) union() {
			translate([0, tread_crawler_horizontal_length / 2, 0]) rotate([0,90,0]) cylinder(r=base_depth / 2, h=tread_brace_thickness);
			translate([0, -tread_crawler_horizontal_length / 2, 0]) rotate([0,90,0]) cylinder(r=base_depth / 2, h=tread_brace_thickness);
			}
		}

		translate([-tread_brace_thickness/2, 0, 0]) union() {
			 translate([0, wheel_axle_offset, 0]) rotate([0,90,0]) cylinder(r=axle_radius, h=tread_brace_thickness);
			translate([0, -wheel_axle_offset, 0]) rotate([0,90,0]) cylinder(r=axle_radius, h=tread_brace_thickness);
		}

		union() {
			translate([0, wheel_axle_offset+(base_depth/2), 0]) cube([tread_brace_thickness*2, base_depth, axle_radius*2*.75], true);

			translate([0, -(wheel_axle_offset+(base_depth/2)), 0]) cube([tread_brace_thickness*2, base_depth, axle_radius*2*.75], true);
		}
	}
};


module track(){

	linear_extrude(tread_width+tread_brace_thickness) difference(){
		circle(r=tread_radius_outer);

		for(i=[1:tread_tooth_count]) rotate([0, 0, i * 360 / tread_tooth_count]) {
			translate([tread_radius_inner-indentation_circle_radius,0,0]) rotate([0,0,270]) union() {
				circle(r=indentation_circle_radius);
				polygon(points=[[-indentation_circle_radius,0], [0,indentation_circle_radius+(tread_height*2)], [indentation_circle_radius,0]], paths=[[0,1,2]]);
			}
		}
	}
}


tread_socket_width = tread_width;
wheel_half_height = (tread_socket_width + (2 * wheel_wall_thickness)) / 2;
gap_width = tread_brace_thickness * 1.1;

module wheel(){
	union() {
		wheel_half();
		cylinder(r=axle_radius, h=wheel_half_height+(gap_width*2));
	}

	translate([wheel_radius * 2.5, 0, 0]) difference() {
		wheel_half();
		translate([0, 0, wheel_wall_thickness]) cylinder(r=axle_radius*1.02, h=wheel_half_height+(gap_width*3));
	};
}

module wheel_half() {
	intersection() {
		difference() {
			cylinder(r=wheel_radius, h=tread_socket_width + (2 * wheel_wall_thickness));
			for (i=[1:wheel_tooth_count]) {
				rotate([0, 0, i * (360 / wheel_tooth_count)]) translate([wheel_radius, 0, wheel_wall_thickness]) cylinder(r=ai / 2,h=tread_socket_width);
			}
		}

		translate([0, 0, wheel_half_height / 2]) cube([wheel_radius * 2, wheel_radius * 2, wheel_half_height], true);
	}
};

module monogram_stamp() {
	mirror([1,0,0]) translate([5,0,0]) union() {
		translate([-5,0,0]) cube([40, 29, 3]);
		linear_extrude(20) translate([-2, -2.35, 0]) resize([31,29,0]) import("../inc/A.dxf");
		translate([-1.5,13,0]) cylinder(r=1.5, h=20);
		translate([32,13,0]) cylinder(r=1.5, h=20);
	}
}