const std = @import("std");
const http = std.http;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    var client = http.Client{ .allocator = allocator };
    std.debug.print("{any}\n",.{client});
    defer client.deinit();
    std.debug.print("libpod/{s}\n", .{ "containers/json" });
    const url = try std.Uri.parse("http://localhost:8080/v1.40.0/libpod/containers/json");

    var header_buffer: [4096]u8 = undefined; // 4 KB buffer for headers
    var req = try client.open(.GET, url, .{
        .server_header_buffer = header_buffer[0..], // using the slice directly
    });
    defer req.deinit();

    try req.send();
    try req.finish();
    try req.wait();

    // Check response status
    if (req.response.status != .ok) {
        std.debug.print("Request failed: Status {}\n", .{req.response.status});
        return;
    }

    const body = try req.reader().readAllAlloc(allocator, 1024 * 1024); // allocating up to 1 MB for body
    defer allocator.free(body);

    std.debug.print("Response:\n{s}\n", .{body});
}
