const std = @import("std");
const process = std.process;

pub fn main() !void {
    // Allocator setup
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Podman system service command
    const command = &[_][]const u8{
        "podman", "system", "service",
        "tcp:localhost:8080",
        "--time=0"
    };

    // Create child process using process.Child instead of ChildProcess
    var child = process.Child.init(command, allocator);

    // Configure process to run in background
    child.stdout_behavior = .Ignore;
    child.stderr_behavior = .Ignore;

    // Spawn the Podman system service
    try child.spawn();

    std.debug.print("Podman system service started on localhost:8080\n", .{});
}
