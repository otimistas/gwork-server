package config

import (
	"fmt"
	"reflect"

	"github.com/caarlos0/env/v10"
)

// Config アプリケーション設定を表す構造体。
type Config struct {
	Port int `env:"PORT" envDefault:"50051"`
	// mysql, pgsql, sqlite
	DBConnection string `env:"DB_CONNECTION" envDefault:"pgsql"`
	DBHost       string `env:"DB_HOST" envDefault:"localhost"`
	DBPort       int    `env:"DB_PORT" envDefault:"5432"`
	DBName       string `env:"DB_NAME,required"`
	DBUsername   string `env:"DB_USERNAME,required"`
	DBPassword   string `env:"DB_PASSWORD"`

	AppDebug bool `env:"APP_DEBUG"`
	// development, staging, production
	AppEnv Environment `env:"APP_ENV" envDefault:"production"`
	// FakeTime Fake time mode setting
	// If a time is specified, fix to that time.
	// If a truthy value is specified, fix to the default time.
	FakeTime FakeTimeMode `env:"FAKE_TIME"`
}

var parseFuncMap = map[reflect.Type]env.ParserFunc{
	reflect.TypeOf(ProductionEnv):  parseEnvironmentMode,
	reflect.TypeOf(FakeTimeMode{}): parseFakeTimeMode,
}

func Get() (*Config, error) {
	cfg := &Config{}
	if err := env.ParseWithOptions(cfg, env.Options{FuncMap: parseFuncMap}); err != nil {
		return nil, fmt.Errorf("parse env: %w", err)
	}

	return cfg, nil
}
