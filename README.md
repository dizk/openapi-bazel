# OpenAPI Bazel

Bazel rule for OpenAPI generator

## Getting started

To use the OpenAPI rules, add the following to your projects `WORKSPACE` file

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
    name = "rules_openapi",
    url = "https://github.com/dizk/rules_openapi/releases/download/0.2.0/rules_openapi-0.2.0.tar.gz",
    sha256 = "0fb0a01b88787a2e0418cf2bdf2c60c057398f676f4cded7a6b3a2320fdbe7ba",
)
load("@rules_openapi//openapi:deps.bzl", "rules_openapi_dependencies")
rules_openapi_dependencies()
```

Then in your `BUILD` file, just add the following so the rules will be available:

```python
load("@rules_openapi//openapi:openapi.bzl", "openapi_generator")
```
