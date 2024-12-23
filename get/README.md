# Fetch Request
1. **Setup memory for the program**:

```zig
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
defer _ = gpa.deinit();
```
2. **Using memory for your HTTP client**:
```zig
var allocator = gpa.allocator();
```
> https://ziglang.org/documentation/master/std/#std.heap.general_purpose_allocator.GeneralPurposeAllocator

- `gpa` sets up memory for you
- `gpa.deinit()` - make sure the memory is cleaned after the program exits.
- `allocator` - get the memory allocator function that we can use it manage memory.

3. **Create the HTTP client**:
```zig
var client = std.http.Client{ .allocator = allocator };
defer client.deinit();
```

- `client` - create a client that will interact/communicate with the website.
- `defer client.deinit()` - clear the memory once the program exits.
>  https://ziglang.org/documentation/master/std/#std.http.Client
4. **Setting up the website URL request information from**:
```zig
const url = try std.Uri.parse("http:localhost:8080");
```
- `std.Uri.parse` - turns the string into a valid URI object that HTTP client can use.
- `try` - checks if the link is valid(in this code).
> https://ziglang.org/documentation/master/std/#std.Uri.parse
5. **Setting up the HTTP request**:
```zig
header_buffer: [4096]u8 = undefined;
var req = try client.open(.GET, url, .{
    .server_header_buffer = header_buffer[0..],
});
defer req.deinit();
```
- `header_buffer: [4096]u8` - fixed-size buffer(4KB) to store the headers of the HTTP response.
- `client.open(.GET, url, ...)` - opens a `GET` request to the specified `url`.
- `.server_header_buffer = header_buffer[0..]` - tells the client to use `header_buffer` to store the responses.
- `defer req.deinit()` - clears the memory once the program exits.

6. **Sending the HTTP request**:
```zig
try req.send();
try req.finish();
try req.wait();
```

- `send()` - sends the request(`req`) to the website.
- `finish()` - completes the request(*sending only*).
- `wait()` - waits for the website to respond.

7. **Checking if the request is succeeded**:
```zig
if (req.response.status != .ok) {
    std.debug.print("Request failed status: Staus {}\n", {req.response.status});
    return;
}
```
- This checks if the response was successful ("status:200"), if not, prints an error message and stops.

8. **Reading and Printing the data**:
```zig
const body = try req.reader().readAllocator(allocator, 1024 * 1024);
defer allocator.free(body);

std.debug.print("Response: \n{s}\n", .{body});
```
- reads the information in `body` returned from the website and,
- `allocator.free(body)` - stores it in memory.
