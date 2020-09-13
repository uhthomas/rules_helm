# rules_helm
Bazel rules for [Helm](https://helm.sh/).

## Usage
Add the following to your WORKSPACE
```starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "com_github_uhthomas_rules_helm",
    sha256 = "",
    urls = [],
)

load("@com_github_uhthomas_rules_helm//helm:repositories.bzl", "rules_helm_dependencies")

rules_helm_dependencies()
```

To use use the following rules, use the following load statement.
```starlark
load("@com_github_uhthomas_rules_helm//helm:defs.bzl", "helm_chart", "helm_template")
```

rules_helm currently defines three rules;
### helm_chart
helm_chart downloads the chart and validates its checksum, making it available
for use in other rules.
| Name   | Type        | Default       |
| ------ | ----------- | ------------- |
| urls   | string_list | **mandatory** |
| sha256 | string      | ""            |

### helm_template
helm_template renders the templates from the given chart.
| Name   | Type       | Default        |
| ------ | ---------- | -------------- |
| chart  | label      | **mandatory**  |
| values | label_list | None           |

## Limitations
* Charts must be fetched from a pre-defined gzip archive. This is for
reproducibility, and because helm dependency resolution is not hermetic by default.
* Not all flags can be passed to `helm template`. It's trivial to add more though.
* Chart dependencies are not fetched or resolved.

## Roadmap
This is for a full [end-to-end k8s x Bazel project](https://github.com/uhthomas/automata).
It does want I want _for now_, but really I want the API to be less explicit,
making more sense at a glance, rather than seeing archive links. So instead of
```starlark
helm_chart(
    name = "io_github_kubernetes_ingress_nginx_ingress_nginx",
    sha256 = "e218dc24614f64e2886314c71c804ca10d159298aaa56a1dcc0097e64d6ebd5f",
    urls = ["https://github.com/kubernetes/ingress-nginx/releases/download/ingress-nginx-2.16.0/ingress-nginx-2.16.0.tgz"]
)
```
something like the following would be much better.
```starlark
helm_chart(
    name = "io_github_kubernetes_ingress_nginx_ingress_nginx",
    repo = "https://kubernetes.github.io/ingress-nginx",
    chart = "ingress-nginx",
    version = "2.16.0",
    sha256 = "e218dc24614f64e2886314c71c804ca10d159298aaa56a1dcc0097e64d6ebd5f",
)
```

One day.
