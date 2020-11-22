package main

import (
	"github.com/orphaner/02-tartine-lib/pkg/core/logger"
	flag "github.com/spf13/pflag"
)

var (
	name string
)

func init() {
	flag.StringVar(&name, "name", "raymond", "your name")
	flag.Parse()
}

func main() {
	logger.InitLogger()
	logger.Log.WithField("name", name).Info("hello world")
}
