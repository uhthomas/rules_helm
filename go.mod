module github.com/uhthomas/rules_helm

go 1.15

require helm.sh/helm/v3 v3.3.1

replace (
	github.com/Azure/go-autorest => github.com/Azure/go-autorest v14.2.1-0.20200911203600-b076c1437d05+incompatible
	helm.sh/helm/v3 => github.com/uhthomas/helm/v3 v3.1.0-rc.1.0.20200914121339-c609c2401763
)
