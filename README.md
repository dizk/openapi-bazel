# OpenAPI Bazel

Bazel rule for OpenAPI generator

## Getting started

To use the OpenAPI rules, add the following to your projects `WORKSPACE` file

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

RULES_OPEN_API_VERSION = "8ba2fcf8509decf448ba458c8b3af3156fa3e364"
RULES_OPEN_API_SHA256 = "f6c334cf891d4a65711e1741f88440fdc3ba59d873cb818a218b800ad27d60a9"

http_archive(
    name = "bazel_openapi",
    strip_prefix = "rules_openapi-%s" % RULES_OPEN_API_VERSION,
    url = "https://github.com/dizk/openapi-bazel/archive/%s.tar.gz" % RULES_OPEN_API_VERSION,
    sha256 = RULES_OPEN_API_SHA256
)

load("@bazel_openapi//openapi:openapi.bzl", "openapi_bazel_repositories")
openapi_bazel_repositories()
```

Then in your `BUILD` file, just add the following so the rules will be available:

```python
load("@io_bazel_rules_openapi//openapi:openapi.bzl", "openapi_gen")
```
