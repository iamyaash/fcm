const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var client = try std.net.http.Client.init(allocator);
    defer client.deinit();

    const response = try client.get("http://localhost:8080/v4.0.0/containers/json", null);
    defer response.body.deinit();

    const body = try response.body.readAllAlloc(allocator, 4096);
    std.debug.print("Response: {s}\n", .{body});
}
