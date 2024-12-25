const std = @import("std");
const http = std.http;
const json = std.json;

pub fn main() !void {
    // initializing GPA
    const gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    //initialize HTTP server
    var server = try http.Server.init(allocator, 8080, handleRequest);
    defer server.deinit();

    std.debug.print("server running on http://localhost:8080\n", .{});
    try server.run();
}
