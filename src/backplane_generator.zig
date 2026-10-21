const std = @import("std");
const kicad = @import("kicad");

const main_card_hp = 10;
const card_hp = 4;
const minimum_hp = main_card_hp + card_hp;

// origin of the footprint is pin a1 in kicad, which is the first pin of the row
// left of the b row. The b row is where all the design guide measurements are
// WRT. it is also not center, but it should be easy enough to figure out what
// the Y should be. I am going to make the vertical centerline zero so that it's
// easy to mirror.

/// Offest of the first row b from the edge of the backplane.
const pitch_line = 7.92;
const pitch_width = 2.54;
const hp_width = 5.08;
const row_b_to_mounting_hole = 0.3;
const mounting_hole_dia = 2.7;

/// height of board
const h1 = u(3) - 4.8;

/// distance between mounting holes
const h2 = u(3) - 10.85;

const footprint_offset: Point = .{
    .x = pitch_line - pitch_width,
    .y = -2.54 * (32.0 - 1.0) / 2.0,
};
const upper_hole_offset: Point = .{
    .x = pitch_line - row_b_to_mounting_hole,
    .y = h2 / 2,
};

const lower_hole_offset: Point = .{
    .x = upper_hole_offset.x,
    .y = -upper_hole_offset.y,
};

fn u(n: usize) f64 {
    return @as(f64, @floatFromInt(n)) * 44.45;
}

const Point = struct {
    x: f64,
    y: f64,

    pub fn format(p: *const Point, w: *std.Io.Writer) !void {
        try w.print("(xy {} {})", .{ p.x, p.y });
    }

    pub fn add(p: *const Point, other: *const Point) Point {
        return .{
            .x = p.x + other.x,
            .y = p.y + other.y,
        };
    }
};

const Rect = struct {
    start: Point,
    end: Point,

    pub fn format(r: *const Rect, w: *std.Io.Writer) !void {
        try w.print("(start={f} end={f})", .{ r.start, r.end });
    }
};

pub fn main(init: std.process.Init) !void {
    const arena = init.arena.allocator();

    const args = try init.minimal.args.toSlice(init.arena.allocator());
    if (args.len != 2) {
        return error.InvalidArgCount;
    }

    const hp = try std.fmt.parseInt(usize, args[1], 0);
    if (hp < (main_card_hp + card_hp)) {
        std.log.err("{} HP is not big enough for this system, you need at least {}", .{ hp, minimum_hp });
        std.process.exit(1);
    }

    var origins: std.ArrayList(Point) = .empty;
    try origins.append(arena, .{ .x = 0, .y = 0 });

    var count: usize = main_card_hp;
    while (count <= (hp - card_hp)) : (count += card_hp) {
        try origins.append(arena, .{ .x = hp_width * @as(f64, @floatFromInt(count)), .y = 0 });
    }

    std.log.info("board dimensions: height={}mm width={}mm", .{ h1, hp_width * @as(f64, @floatFromInt(hp)) });

    const edge_cuts: Rect = .{
        .start = .{
            .x = 0.0,
            .y = h1 / 2,
        },
        .end = .{
            .x = hp_width * @as(f64, @floatFromInt(hp)),
            .y = -(h1 / 2),
        },
    };

    std.log.info("edge_cuts={f}", .{edge_cuts});

    var mounting_holes: std.ArrayList(Point) = .empty;
    var footprints: std.ArrayList(Point) = .empty;
    for (origins.items) |origin| {
        try footprints.append(arena, origin.add(&footprint_offset));
        try mounting_holes.append(arena, origin.add(&upper_hole_offset));
        try mounting_holes.append(arena, origin.add(&lower_hole_offset));
    }

    std.log.info("footprints", .{});
    for (footprints.items) |entry|
        std.log.info("  - {f}", .{entry});

    std.log.info("mounting holes:", .{});
    for (mounting_holes.items) |entry|
        std.log.info("  - {f}", .{entry});
}
