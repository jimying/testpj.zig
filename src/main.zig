const std = @import("std");
const c = @cImport({
    @cDefine("PJ_AUTOCONF", "1");
    @cDefine("PJ_IS_LITTLE_ENDIAN", "1");
    @cDefine("PJ_IS_BIG_ENDIAN", "0");
    @cInclude("pj/os.h");
    @cInclude("pj/pool.h");
    @cInclude("pjmedia/rtp.h");
});

pub fn main() !void {
    std.debug.print("test pjproject api\n", .{});

    _ = c.pj_init();

    // problem1: test memory pool  (error: dependency loop detected)
    var cp: c.pj_caching_pool = undefined;
    c.pj_caching_pool_init(&cp, null, 0);

    const pool = c.pj_pool_create(&cp.factory, "test", 1000, 1000, null);
    _ = c.pj_pool_alloc(pool, 100);
    c.pj_pool_release(pool);

    c.pj_caching_pool_destroy(&cp);

    // problem2: pjmedia_rtp_hdr (raw defined in pjmedia/rtp.h) is not translated crorrect
    //var rtp_hdr: c.pjmedia_rtp_hdr = undefined;

    c.pj_shutdown();
}
