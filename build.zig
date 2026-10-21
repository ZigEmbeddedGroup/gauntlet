const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const kicad = b.addModule("kicad", .{
        .root_source_file = b.path("src/kicad.zig"),
        .target = target,
        .optimize = optimize,
    });

    const backplane_generator = b.addExecutable(.{
        .name = "backplane_generator",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/backplane_generator.zig"),
            .imports = &.{
                .{ .name = "kicad", .module = kicad },
            },
            .target = target,
            .optimize = optimize,
        }),
    });

    b.installArtifact(backplane_generator);
}
