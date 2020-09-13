def _helm_chart_impl(ctx):
    ctx.download_and_extract(
        url = ctx.attr.urls,
        sha256 = ctx.attr.sha256,
    )

    ctx.file("BUILD.bazel", """
package(default_visibility = ["//visibility:public"])

load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")

pkg_tar(
    name = "chart",
    extension = "tar.gz",
    srcs = glob(["**/*"]),
)""")

helm_chart = repository_rule(
    _helm_chart_impl,
    attrs = {
        "urls": attr.string_list(mandatory = True),
        "sha256": attr.string(),
    },
)

def _helm_template_impl(ctx):
    out = ctx.actions.declare_directory(ctx.label.name + "/chart")

    args = ctx.actions.args()
    args.add("template", ctx.file.chart.path)
    args.add("--output-dir", out.path)
    [args.add("-f", f.path) for f in ctx.files.values]

    ctx.actions.run(
        outputs = [out],
        executable = ctx.executable._helm,
        arguments = [args],
        inputs = [ctx.file.chart] + ctx.files.values,
    )

    return [DefaultInfo(files = depset([out]))]

helm_template = rule(
    _helm_template_impl,
    attrs = {
        "chart": attr.label(mandatory = True, allow_single_file = True),
        "values": attr.label_list(allow_files = True),
        "_helm": attr.label(
            executable = True,
            cfg = "exec",
            default = "@sh_helm_helm_v3//cmd/helm:helm",
        )
    },
)
