include <Akisbot.scad>

$fa = 1;
$fs = 1;

// todo 257 = body height plus neck height
head_offset_y = 257;

translate([-body_width/2,body_depth/2,0]) rotate([90,0,0]) back();
rotate([0,0,180]) translate([-body_width/2,body_depth/2,0]) rotate([90,0,0]) front();
translate([-(body_width / 2 ) + nameplate_left, -( body_depth / 2 ), nameplate_top - nameplate_height]) rotate([90, 0, 0]) nameplate();

// Neck and head
translate([0,0, body_height - (joint_radius*2/3)]) rotate([0,90,0]) neck();
// todo 257 = body height plus neck height
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
            translate([wheel_gap / 2,0,0]) tread_brace();
            mirror([1,0,0]) translate([wheel_gap / 2,0,0]) tread_brace();
        };

	color( "gray" ) union() {
            translate([-wheel_gap / 2,90,0]) wheel();
            translate([-wheel_gap / 2,-90,0]) wheel();
            translate([wheel_gap / 2,90,0]) rotate([0,0,180]) wheel();
            translate([wheel_gap / 2,-90,0]) rotate([0,0,180]) wheel();
        };

	color( "black") union() {
            translate([-wheel_gap / 2,0,0]) crawler();
            translate([wheel_gap / 2,0,0]) crawler();
        };
};

translate([-(head_width / 2) + head_top_left, 0, body_height + head_height - (antenna_base_radius / 2)]) rotate([0,270,0]) antenna();
mirror([1,0,0]) translate([-(head_width / 2) + head_top_left, 0, body_height + head_height - (antenna_base_radius / 2)]) rotate([0,270,0]) antenna();

translate([-eye_offset_x,-(head_depth / 2)-inner_eye_depth,head_offset_y+eye_offset_y]) rotate([270,0,0]) eye();
translate([eye_offset_x,-(head_depth / 2)-inner_eye_depth,head_offset_y+eye_offset_y]) rotate([270,0,0]) eye();

translate([0,-body_depth/2,60]) rotate([90,180,0]) meter();
color( "yellow" ) translate([-60,-body_depth/2,60]) rotate([90,0,0]) button();
color( "red" ) translate([-28,-body_depth/2,60]) rotate([90,0,0]) button();
color( "purple" ) translate([4,-body_depth/2,60]) rotate([90,0,0]) button();
color( "aqua" ) translate([36,-body_depth/2,60]) rotate([90,0,0]) button();
