package config

import (
	"fmt"
)

type Environment string

const (
	ProductionEnv  Environment = "production"
	StagingEnv     Environment = "staging"
	DevelopmentEnv Environment = "development"
)

func parseEnvironmentMode(v string) (any, error) {
	if v == "" {
		return ProductionEnv, nil
	}

	switch ev := Environment(v); ev {
	case ProductionEnv, StagingEnv, DevelopmentEnv:
		return ev, nil
	default:
		return nil, fmt.Errorf("specify one of the following items: %s, %s, %s", ProductionEnv, StagingEnv, DevelopmentEnv)
	}
}
