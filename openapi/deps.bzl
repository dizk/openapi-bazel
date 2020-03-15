load("@bazel_tools//tools/build_defs/repo:jvm.bzl", "jvm_maven_import_external")

def rules_openapi_dependencies():
    jvm_maven_import_external(
        name = "openapi_generator_cli",
        artifact = "org.openapitools:openapi-generator-cli:4.1.3",
        artifact_sha256 = "234cbbc5ec9b56e4b585199ec387b5ad3aefb3eda9424c30d35c849dd5950d2f",
        server_urls = [
                "https://jcenter.bintray.com/",
                "https://repo1.maven.org/maven2",
        ]
    )
