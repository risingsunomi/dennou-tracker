// http server front end

const std = @import("std");
const httpz = @import("httpz");

pub fn http_server() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var server = try httpz.Server(void).init(allocator, .{ .port = 80 }, {});
    defer {
        server.stop();
        server.deinit();
    }

    var router = server.router(.{});
    router.get("/announce", getAnnounce, .{});

    // blocks
    try server.listen();
}

fn getAnnounce(_: *httpz.Request, res: *httpz.Response) !void {
    std.log.info("announce called");
    std.log.info(res.status);
}
