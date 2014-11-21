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
nameplate_depth = wall_thickness * .25;
vent_count = 8;

vent_left = top_left + ( length_of_body_top * .08 );
vent_top = body_height * .9;

nameplate_top = vent_top - vent_height -  (nameplate_height / 2 );
nameplate_left = vent_left;

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

antenna_length = head_width * 0.22;
antenna_girth = 6;
antenna_ball_radius = 8;
antenna_base_radius = head_depth / 2;

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
wrist_radius = 5;

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
wheel_width = 125;
wheel_depth = 80;
base_depth = body_depth * 0.5;
base_height = 60;

module antenna() {
    color( "gray" ) union() {
        translate([0, 0, -antenna_base_radius * 0.5]) difference() {
            sphere(r=antenna_base_radius);
            translate([0, 0, -antenna_base_radius * 0.5]) cube(antenna_base_radius * 2, true);
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
	cube([body_width *.1, body_height * .07, body_depth * 0.07]);
};

/**
 * The inner portion of the eye.
 */
module eye() {
	difference() {
		color( "white" ) cylinder(r=inner_eye_radius * .98, h=inner_eye_depth );
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
	resize(newsize=[nameplate_width,nameplate_height,nameplate_depth]) union() {
		color( "darkgreen" ) linear_extrude(3) square([60,13]);

		color( "white" ) translate([9,3,2])  linear_extrude(4) text(text="AKISBOT", size=7);
	}
};

module neck() {
    translate([neck_length / 2, 0, 0]) difference() {
        sphere(r=joint_ball_radius);
        translate([( joint_ball_radius * 5 / 3 ), 0, 0]) cube(joint_ball_radius * 2, true);
    };

    mirror([1,0,0]) translate([neck_length / 2, 0, 0]) difference() {
        sphere(r=joint_ball_radius);
        translate([( joint_ball_radius * 5 / 3 ), 0, 0]) cube(joint_ball_radius * 2, true);
    };
    
    rotate([0, 90, 0]) translate([0, 0, -(neck_length / 2)]) cylinder(r=neck_girth / 2, h=neck_length);
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
			translate([(joint_radius*5/3),0,0]) cube([joint_radius*2, joint_radius*2, joint_radius*2],true);
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

/**
 * The brace that holds the wheels.
 * @see http://www.thingiverse.com/thing:332816/
 */
module tread_brace() {
    // The wheels are rotated [-90º, 0, -90º] in the STL and are off-center by [15, 109.5, 7.5] (after scaling).
    color( "green" ) translate([-15, -109.5, -7.5]) scale(3) rotate([90, 0, 90]) import("../inc/Tread Brace.stl");
};

/**
 * The wheel that drives the crawlers.
 * @see http://www.thingiverse.com/thing:332816/
 */
module wheel() {
    // The wheels are rotated 30º in the STL and are off-center by [42, 6, 32] (after scaling).
    color( "gray" ) translate([-42, -6, -32]) scale(3) rotate([0, 0, -30]) import( "../inc/Tread Wheel.stl" );
}

/**
 * The rubber part of the treads.
 * @see http://www.thingiverse.com/thing:332816/
 */
module crawler() {
    // The crawlers are rotated [-90º, 0, -90º] in the STL and are off-center by [27.5, 180, 182] (after scaling).
    color( "black" ) translate([27.5, 180, 182]) rotate([90, 0, 90]) scale(3) import( "../inc/Treads.stl" );
}
