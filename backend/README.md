# Initialzing

1. **Start listening to the server**:
``` zig
var server = try http.Server.init(gpa.allocator(), 8080, handleRequest);
defer server.deinit();
```
> https://ziglang.org/documentation/master/std/#std.http.Server.init

``` zig
try server.run();
```
- Run if check.ok else return check.fail
