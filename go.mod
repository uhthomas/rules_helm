module github.com/uhthomas/rules_helm

go 1.15

require helm.sh/helm/v3 v3.3.1

replace (
	github.com/Azure/go-autorest => github.com/Azure/go-autorest v14.2.1-0.20200911203600-b076c1437d05+incompatible
	github.com/Sirupsen/logrus => github.com/sirupsen/logrus v1.6.0
	github.com/docker/cli => github.com/docker/cli v0.0.0-20200617172703-0ed913b885c8
	github.com/docker/docker => github.com/moby/moby v17.12.0-ce-rc1.0.20200618181300-9dc6525e6118+incompatible
	helm.sh/helm/v3 => github.com/uhthomas/helm/v3 v3.1.0-rc.1.0.20200914121339-c609c2401763
)
