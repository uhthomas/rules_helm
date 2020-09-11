load("@bazel_gazelle//:deps.bzl", "go_repository")

def rules_helm_dependencies():
    pass


def _maybe(rule, name, **kwargs):
    if name not in native.existing_rules():
        rule(name = name, **kwargs)
