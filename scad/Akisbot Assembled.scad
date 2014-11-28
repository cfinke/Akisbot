include <Akisbot.scad>;

// ((joint_ball_radius * 4 / 3) * 2) is the distance between the centers of the two neck piece balls.
head_offset_y = body_height - (joint_radius*2/3) + ((joint_ball_radius * 4 / 3) * 2) - (joint_radius*2/3);

translate([-body_width/2,body_depth/2,0]) rotate([90,0,0]) back();
rotate([0,0,180]) translate([-body_width/2,body_depth/2,0]) rotate([90,0,0]) front();

// Neck and head
translate([0,0, body_height - (joint_radius*2/3)]) translate([0, 0, neck_length / 2]) rotate([0,90,0]) neck();

translate([-head_width/2,head_depth/2,head_offset_y]) rotate([90,0,0]) head_back();
rotate([0,0,180]) translate([-head_width/2,head_depth/2,head_offset_y]) rotate([90,0,0]) union() {
	head_front();

	// Eye rings
	translate([0, eye_offset_y, outer_eye_depth * -1]) union() {
		translate([(head_width / 2) + eye_offset_x, 0, 0]) eye_ring();
		translate([(head_width / 2) - eye_offset_x, 0, 0]) eye_ring();
	};
};

// Upper arms
translate([-(body_width / 2) + top_left+top_joint_x_offset,0,body_height-top_joint_y_offset]) upper_arm();
mirror([1,0,0]) translate([-(body_width / 2) + top_left+top_joint_x_offset,0,body_height-top_joint_y_offset]) upper_arm();

// Forearms
translate([-(body_width / 2) + top_left+top_joint_x_offset-upper_arm_length-joint_radius,0,body_height-top_joint_y_offset]) forearm();
mirror([1,0,0]) translate([-(body_width / 2) + top_left+top_joint_x_offset-upper_arm_length-joint_radius,0,body_height-top_joint_y_offset]) forearm();

color( "green" ) translate([0,0,-base_height + ( joint_radius * 1 / 3 )]) base();

translate([0,0,-base_height + ( joint_radius * 1 / 3 )]) union() {
	color( "green" ) union() {
            translate([(wheel_gap / 2)+(tread_brace_thickness/2),0,0]) tread_brace();
            mirror([1,0,0]) translate([(wheel_gap / 2)+(tread_brace_thickness/2),0,0]) tread_brace();
        };

	color( "gray" ) union() {
	   translate([-(wheel_gap / 2) - wheel_half_height - tread_brace_thickness,wheel_axle_offset,0]) rotate([0,90,0]) wheel_half();
      translate([-(wheel_gap / 2) - wheel_half_height - tread_brace_thickness,-wheel_axle_offset,0]) rotate([0,90,0]) wheel_half();
      translate([(wheel_gap / 2) + wheel_half_height+tread_brace_thickness,wheel_axle_offset,0]) rotate([0,-90,0]) wheel_half();
      translate([(wheel_gap / 2) + wheel_half_height+tread_brace_thickness,-wheel_axle_offset,0]) rotate([0,-90,0]) wheel_half();

		translate([-(wheel_gap / 2) + wheel_half_height,wheel_axle_offset,0]) rotate([0,90,180]) wheel_half();
		translate([-(wheel_gap / 2) + wheel_half_height,-wheel_axle_offset,0]) rotate([0,90,180])wheel_half();
		translate([(wheel_gap / 2) - wheel_half_height,wheel_axle_offset,0]) rotate([0,-90,180]) wheel_half();
		translate([(wheel_gap / 2) - wheel_half_height,-wheel_axle_offset,0]) rotate([0,-90,180]) wheel_half();
	};

	color( "black" ) union() {
		scale([1,1.2,0.5]) translate([-((wheel_gap / 2) + gap_width+wheel_half_height-wheel_wall_thickness),0,0]) rotate([0,90,0]) difference() {
			track();
			cylinder(r=tread_radius_inner-(indentation_circle_radius*2)-tread_thickness, h=tread_width);
		}

		scale([1,1.2,0.5]) translate([((wheel_gap / 2) + gap_width+wheel_half_height-wheel_wall_thickness)-tread_width-tread_brace_thickness,0,0]) rotate([0,90,0]) difference() {
			track();
			cylinder(r=tread_radius_inner-(indentation_circle_radius*2)-tread_thickness, h=tread_width);
		}
	}
};

translate([-(head_width / 2) + head_top_left, 0, body_height + head_height - (antenna_base_radius / 2)]) rotate([0,270,0]) antenna();
mirror([1,0,0]) translate([-(head_width / 2) + head_top_left, 0, body_height + head_height - (antenna_base_radius / 2)]) rotate([0,270,0]) antenna();

translate([-eye_offset_x,-(head_depth / 2)-inner_eye_depth,head_offset_y+eye_offset_y]) rotate([270,0,0]) eye();
translate([eye_offset_x,-(head_depth / 2)-inner_eye_depth,head_offset_y+eye_offset_y]) rotate([270,0,0]) eye();

translate([0,-body_depth/2,body_height * .25]) rotate([90,180,0]) meter();
translate([0,-(body_depth/2)+wall_thickness, body_height * .25]) buttons();