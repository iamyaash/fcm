const std = @import("std");
const http = std.http;

pub fn main() !void {
    // Initialize a GeneralPurposeAllocator instance
    const gpa = std.heap.GeneralPurposeAllocator(.{});
    defer gpa.deinit();

    const allocator = &gpa.allocator;

    // Create a network listener for the server
    const listener = try std.net.Server.listen(std.net.Address.any_ipv4(8080), 100, allocator);
    defer listener.close();

    // Initialize the HTTP server
    var server = http.Server.init(listener, allocator);
    defer server.deinit();

    std.debug.print("Server running on http://localhost:8080\n", .{});

    // Start handling requests
    try server.serve(handleRequest);
}

fn handleRequest(req: *http.Request) !void {
    req.response.status = .ok;
    try req.response.write("Server is running\n");
}
