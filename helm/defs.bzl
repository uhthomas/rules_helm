def _helm_template_impl(ctx):
    out = ctx.actions.declare_directory(ctx.label.name)
    ctx.actions.run(
        outputs = [out],
        executable = ctx.executable._helm,
        arguments = ["plugin", "list"],
    )

    return [DefaultInfo(files = depset([out]))]

helm_template = rule(
    _helm_template_impl,
    attrs = {
        "_helm": attr.label(
            executable = True,
            cfg = "exec",
            default = "@sh_helm_helm_v3//cmd/helm:helm",
        )
    },
)
