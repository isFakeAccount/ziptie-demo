const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.addModule("Test", .{
        .target = target,
        .optimize = optimize,
        .link_libc = false,
    });

    mod.addCSourceFile(.{
        .file = b.path("spammodule.c"),
        .language = .c,
    });


    // MSVC CRT Headers
    mod.addSystemIncludePath(b.path("../pyxwin/.pyxwin-cache/reduced/CRT_14.50.18.0/include"));

    // MSVC Libs
    mod.addLibraryPath(b.path("../pyxwin/.pyxwin-cache/reduced/CRT_14.50.18.0/lib/x64/"));

    // Windows SDK Headers
    mod.addSystemIncludePath(b.path("../pyxwin/.pyxwin-cache/reduced/SDK_10.0.26100/include"));
    mod.addSystemIncludePath(b.path("../pyxwin/.pyxwin-cache/reduced/SDK_10.0.26100/include/shared"));
    mod.addSystemIncludePath(b.path("../pyxwin/.pyxwin-cache/reduced/SDK_10.0.26100/include/ucrt"));
    mod.addSystemIncludePath(b.path("../pyxwin/.pyxwin-cache/reduced/SDK_10.0.26100/include/um"));
    mod.addSystemIncludePath(b.path("../pyxwin/.pyxwin-cache/reduced/SDK_10.0.26100/include/winrt"));

    mod.addLibraryPath(b.path("../pyxwin/.pyxwin-cache/reduced/SDK_10.0.26100/lib/ucrt/x64/"));
    mod.addLibraryPath(b.path("../pyxwin/.pyxwin-cache/reduced/SDK_10.0.26100/lib/um/x64/"));

    // Python dev Libraries and headers
    mod.addIncludePath(b.path("../Windows-Python/python-windows-x86_64/cpython-3.13.11-windows-x86_64-none/include"));
    mod.addLibraryPath(b.path("../Windows-Python/python-windows-x86_64/cpython-3.13.11-windows-x86_64-none/libs"));

    // Link system libraries
    mod.linkSystemLibrary("ucrt", .{.use_pkg_config = .no, .search_strategy = .paths_first});
    mod.linkSystemLibrary("kernel32", .{.use_pkg_config = .no, .search_strategy = .paths_first});
    mod.linkSystemLibrary("user32", .{.use_pkg_config = .no, .search_strategy = .paths_first});
    mod.linkSystemLibrary("user32", .{.use_pkg_config = .no, .search_strategy = .paths_first});
    mod.linkSystemLibrary("ntstc_msvcrt", .{.use_pkg_config = .no, .search_strategy = .paths_first});
    mod.linkSystemLibrary("libvcruntime", .{.use_pkg_config = .no, .search_strategy = .paths_first});

    mod.linkSystemLibrary("python313", .{});

    const lib = b.addLibrary(.{
        .name = "spam",
        .root_module = mod,
        .linkage = .dynamic,
    });

    b.installArtifact(lib);
}
