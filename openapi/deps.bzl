load("@bazel_tools//tools/build_defs/repo:jvm.bzl", "jvm_maven_import_external")

OPENAPI_GENERATOR_VERSION = "4.3.1"

OPENAPI_GENERATOR_SHA = "f438cd16bc1db28d3363e314cefb59384f252361db9cb1a04a322e7eb5b331c1"

def rules_openapi_dependencies():
    jvm_maven_import_external(
        name = "openapi_generator_cli",
        artifact = "org.openapitools:openapi-generator-cli:%s" % OPENAPI_GENERATOR_VERSION,
        artifact_sha256 = OPENAPI_GENERATOR_SHA,
        server_urls = [
                "https://jcenter.bintray.com/",
                "https://repo1.maven.org/maven2",
        ]
    )
