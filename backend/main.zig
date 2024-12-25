const std = @import("std");
const http = std.http;
const allocator = std.heap.GeneralPurposeAllocator(.{}){};
const routes = @import("routes");

pub fn main() !void {
    // Initialize the GeneralPurposeAllocator (GPA) for dynamic memory management
    var gpa = allocator.init();
    defer gpa.deinit();

    // Initialize the HTTP server
    var server = try http.Server.init(gpa.allocator(), 8080, handleRequest);
    defer server.deinit();

    std.debug.print("Server running on http://localhost:8080\n", .{});
    try server.run(); // Start the HTTP server and wait for requests
}

fn handleRequest(req: *http.Request, allocator: *std.mem.Allocator) !void {
    switch (req.uri.path) {
        "/containers" => {
            try routes.get_containers.handleRequest(req, allocator); // Call the handler for /containers
        },
        "/images" => {
            try routes.get_images.handleRequest(req, allocator); // Call the handler for /images
        },
        "/pods" => {
            try routes.get_pods.handleRequest(req, allocator); // Call the handler for /pods
        },
        else => {
            // Handle other requests or return a 404 Not Found
            req.response.status = .not_found;
            try req.response.write("404 - Not Found\n");
        },
    }
}
