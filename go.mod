module github.com/orphaner/02-tartine-name

go 1.14

require (
	github.com/orphaner/02-tartine-lib/pkg/core v0.0.0-20201121204803-901a69c5b66f
	github.com/spf13/pflag v1.0.5
)

replace github.com/orphaner/02-tartine-lib/pkg/core v0.0.0-20201121204803-901a69c5b66f => ../02-tartine-lib/pkg/core
