package(
    default_visibility = ["//visibility:private"],
)

load("@rules_openapi//openapi:defs.bzl", "version")
load("@rules_openapi//distro:defs.bzl", "print_rel_notes")
load("@rules_pkg//:pkg.bzl", "pkg_tar")


# Build the artifact to put on the github release page.
pkg_tar(
    name = "rules_openapi-%s" % version,
    srcs = [
        "//openapi:distribution",
    ],
    extension = "tar.gz",
    # It is all source code, so make it read-only.
    mode = "0444",
    # Make it owned by root so it does not have the uid of the CI robot.
    owner = "0.0",
    package_dir = ".",
    strip_prefix = ".",
)


print_rel_notes(
    name = "relnotes",
    outs = ["relnotes.txt"],
    deps_method = "rules_openapi_dependencies",
    org = "dizk",
    repo = "rules_openapi",
    setup_file = "openapi:deps.bzl",
    version = version,
)

