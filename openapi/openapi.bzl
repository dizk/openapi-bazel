# Copyright 2020 dizk
# Copyright 2019 OpenAPI-Generator-Bazel Contributors

def _comma_separated_pairs(pairs):
    return ",".join([
        "{}={}".format(k, v)
        for k, v in pairs.items()
    ])

def _generator_arguments(ctx, declared_dir):
    arguments = ["-jar"]
    arguments.append(ctx.file.openapi_generator_cli.path)

    arguments.append("generate")

    arguments.append("-i")
    arguments.append(ctx.file.spec.path)

    arguments.append("-g")
    arguments.append(ctx.attr.generator)

    arguments.append("-o")
    arguments.append(declared_dir.path)

    arguments.append("-p")
    arguments.append(_comma_separated_pairs(ctx.attr.system_properties))

    arguments.append("--additional-properties")
    additional_properties = dict(ctx.attr.additional_properties)
    if ctx.attr.generator == "java" and \
       "hideGenerationTimestamp" not in ctx.attr.additional_properties:
        additional_properties["hideGenerationTimestamp"] = "true"

    arguments.append(_comma_separated_pairs(additional_properties))

    arguments.append("--type-mappings")
    arguments.append(_comma_separated_pairs(ctx.attr.type_mappings))

    if ctx.attr.api_package:
        arguments.append("--api-package")
        arguments.append(ctx.attr.api_package)

    if ctx.attr.invoker_package:
        arguments.append("--invoker-package")
        arguments.append(ctx.attr.invoker_package)

    if ctx.attr.model_package:
        arguments.append("--model-package")
        arguments.append(ctx.attr.model_package)

    if ctx.attr.engine:
        arguments.append("--engine")
        arguments.append(ctx.attr.engine)

    return arguments

def _impl(ctx):
    declared_dir = ctx.actions.declare_directory("%s" % (ctx.attr.name))

    inputs = [
        ctx.file.openapi_generator_cli,
        ctx.file.spec,
    ]

    ctx.actions.run(
        inputs = inputs,
        outputs = [declared_dir],
        executable = str(ctx.attr._jdk[java_common.JavaRuntimeInfo].java_executable_exec_path),
        arguments = _generator_arguments(ctx, declared_dir),
        tools = ctx.files._jdk
    )

    srcs = declared_dir.path

    return DefaultInfo(files = depset([
        declared_dir,
    ]))

_openapi_generator = rule(
    attrs = {
        # downstream dependencies
        "deps": attr.label_list(),
        # openapi spec file
        "spec": attr.label(
            mandatory = True,
            allow_single_file = [
                ".json",
                ".yaml",
            ],
        ),
        "generator": attr.string(mandatory = True),
        "api_package": attr.string(),
        "invoker_package": attr.string(),
        "model_package": attr.string(),
        "additional_properties": attr.string_dict(),
        "system_properties": attr.string_dict(),
        "engine": attr.string(),
        "type_mappings": attr.string_dict(),
        "is_windows": attr.bool(mandatory = True),
        "_jdk": attr.label(
            default = Label("@bazel_tools//tools/jdk:current_java_runtime"),
            providers = [java_common.JavaRuntimeInfo],
        ),
        "openapi_generator_cli": attr.label(
            cfg = "host",
            default = Label("@openapi_generator_cli//jar"),
            allow_single_file = True,
        ),
    },
    implementation = _impl,
)

def openapi_generator(name, **kwargs):
    _openapi_generator(
        name = name,
        is_windows = select({
            "@bazel_tools//src/conditions:windows": True,
            "//conditions:default": False,
        }),
        **kwargs
    )
