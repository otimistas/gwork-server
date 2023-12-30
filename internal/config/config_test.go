package config_test

import (
	"os"
	"testing"
	"time"

	"github.com/google/go-cmp/cmp"

	"github.com/otimistas/gwork-server/internal/config"
)

func TestGet(t *testing.T) {
	// Unset environment variables for test
	envKeys := []string{
		"PORT",
		"DEBUGGING_PORT",
		"DB_CONNECTION",
		"DB_HOST",
		"DB_PORT",
		"DB_NAME",
		"DB_USERNAME",
		"DB_PASSWORD",
		"DB_URL",
		"STORAGE_PATH",
		"APP_DEBUG",
		"APP_ENV",
		"FAKE_TIME",
	}
	for _, v := range envKeys {
		t.Setenv(v, "")
		os.Unsetenv(v)
	}

	cases := []struct {
		name   string
		env    map[string]string
		out    *config.Config
		failed bool
	}{
		{
			name: "minimum",
			env: map[string]string{
				"DB_NAME":      "app",
				"DB_USERNAME":  "user",
				"DB_URL":       "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				"STORAGE_PATH": "/path/to/storage/dir",
			},
			out: &config.Config{
				Port:          50051,
				DebuggingPort: 2345,
				DBConnection:  "postgresql",
				DBHost:        "localhost",
				DBPort:        5432,
				DBName:        "app",
				DBUsername:    "user",
				DBUrl:         "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				StoragePath:   "/path/to/storage/dir",
				AppEnv:        "production",
			},
		},
		{
			name: "full",
			env: map[string]string{
				"PORT":           "3000",
				"DEBUGGING_PORT": "2346",
				"DB_CONNECTION":  "mysql",
				"DB_HOST":        "db",
				"DB_PORT":        "9999",
				"DB_NAME":        "app",
				"DB_USERNAME":    "user",
				"DB_PASSWORD":    "password",
				"DB_URL":         "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				"STORAGE_PATH":   "/path/to/storage/dir",
				"APP_DEBUG":      "true",
				"APP_ENV":        "staging",
				"FAKE_TIME":      "true",
			},
			out: &config.Config{
				Port:          3000,
				DebuggingPort: 2346,
				DBConnection:  "mysql",
				DBHost:        "db",
				DBPort:        9999,
				DBName:        "app",
				DBUsername:    "user",
				DBPassword:    "password",
				DBUrl:         "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				StoragePath:   "/path/to/storage/dir",
				AppDebug:      true,
				AppEnv:        "staging",
				FakeTime: config.FakeTimeMode{
					Enabled: true,
					Time:    config.DefaultFakeTime,
				},
			},
		},
		{
			name: "FAKE_TIME is RFC3339 string",
			env: map[string]string{
				"DB_NAME":      "app",
				"DB_USERNAME":  "user",
				"DB_URL":       "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				"STORAGE_PATH": "/path/to/storage/dir",
				"FAKE_TIME":    "2023-01-02T12:34:56Z",
			},
			out: &config.Config{
				Port:          50051,
				DebuggingPort: 2345,
				DBConnection:  "postgresql",
				DBHost:        "localhost",
				DBPort:        5432,
				DBName:        "app",
				DBUsername:    "user",
				DBUrl:         "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				StoragePath:   "/path/to/storage/dir",
				AppEnv:        "production",
				FakeTime: config.FakeTimeMode{
					Enabled: true,
					Time:    time.Date(2023, 1, 2, 12, 34, 56, 0, time.UTC),
				},
			},
		},
		{
			name: "FAKE_TIME is true",
			env: map[string]string{
				"DB_NAME":      "app",
				"DB_USERNAME":  "user",
				"DB_URL":       "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				"STORAGE_PATH": "/path/to/storage/dir",
				"FAKE_TIME":    "true",
			},
			out: &config.Config{
				Port:          50051,
				DebuggingPort: 2345,
				DBConnection:  "postgresql",
				DBHost:        "localhost",
				DBPort:        5432,
				DBName:        "app",
				DBUsername:    "user",
				DBUrl:         "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				StoragePath:   "/path/to/storage/dir",
				AppEnv:        "production",
				FakeTime: config.FakeTimeMode{
					Enabled: true,
					Time:    config.DefaultFakeTime,
				},
			},
		},
		{
			name: "FAKE_TIME is 1",
			env: map[string]string{
				"DB_NAME":      "app",
				"DB_USERNAME":  "user",
				"DB_URL":       "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				"STORAGE_PATH": "/path/to/storage/dir",
				"FAKE_TIME":    "1",
			},
			out: &config.Config{
				Port:          50051,
				DebuggingPort: 2345,
				DBConnection:  "postgresql",
				DBHost:        "localhost",
				DBPort:        5432,
				DBName:        "app",
				DBUsername:    "user",
				DBUrl:         "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				StoragePath:   "/path/to/storage/dir",
				AppEnv:        "production",
				FakeTime: config.FakeTimeMode{
					Enabled: true,
					Time:    config.DefaultFakeTime,
				},
			},
		},
		{
			name: "FAKE_TIME is false",
			env: map[string]string{
				"DB_NAME":      "app",
				"DB_USERNAME":  "user",
				"DB_URL":       "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				"STORAGE_PATH": "/path/to/storage/dir",
				"FAKE_TIME":    "false",
			},
			out: &config.Config{
				Port:          50051,
				DebuggingPort: 2345,
				DBConnection:  "postgresql",
				DBHost:        "localhost",
				DBPort:        5432,
				DBName:        "app",
				DBUsername:    "user",
				DBUrl:         "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				StoragePath:   "/path/to/storage/dir",
				AppEnv:        "production",
			},
		},
		{
			name: "FAKE_TIME is 0",
			env: map[string]string{
				"DB_NAME":      "app",
				"DB_USERNAME":  "user",
				"DB_URL":       "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				"STORAGE_PATH": "/path/to/storage/dir",
				"FAKE_TIME":    "0",
			},
			out: &config.Config{
				Port:          50051,
				DebuggingPort: 2345,
				DBConnection:  "postgresql",
				DBHost:        "localhost",
				DBPort:        5432,
				DBName:        "app",
				DBUsername:    "user",
				DBUrl:         "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				StoragePath:   "/path/to/storage/dir",
				AppEnv:        "production",
			},
		},
		{
			name: "FAKE_TIME is empty string",
			env: map[string]string{
				"DB_NAME":      "app",
				"DB_USERNAME":  "user",
				"DB_URL":       "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				"STORAGE_PATH": "/path/to/storage/dir",
				"FAKE_TIME":    "",
			},
			out: &config.Config{
				Port:          50051,
				DebuggingPort: 2345,
				DBConnection:  "postgresql",
				DBHost:        "localhost",
				DBPort:        5432,
				DBName:        "app",
				DBUsername:    "user",
				DBUrl:         "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				StoragePath:   "/path/to/storage/dir",
				AppEnv:        "production",
			},
		},
		{
			name: "invalid PORT",
			env: map[string]string{
				"PORT":         "invalid",
				"DB_NAME":      "app",
				"DB_USERNAME":  "user",
				"DB_URL":       "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				"STORAGE_PATH": "/path/to/storage/dir",
			},
			failed: true,
		},
		{
			name: "invalid DEBUGGING_PORT",
			env: map[string]string{
				"DEBUGGING_PORT": "invalid",
				"DB_NAME":        "app",
				"DB_USERNAME":    "user",
				"DB_URL":         "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				"STORAGE_PATH":   "/path/to/storage/dir",
			},
			failed: true,
		},
		{
			name: "invalid DB_PORT",
			env: map[string]string{
				"DB_PORT":      "invalid",
				"DB_NAME":      "app",
				"DB_USERNAME":  "user",
				"DB_URL":       "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				"STORAGE_PATH": "/path/to/storage/dir",
			},
			failed: true,
		},
		{
			name: "invalid APP_ENV",
			env: map[string]string{
				"APP_ENV":      "invalid",
				"DB_NAME":      "app",
				"DB_USERNAME":  "user",
				"DB_URL":       "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				"STORAGE_PATH": "/path/to/storage/dir",
			},
			failed: true,
		},
		{
			name: "invalid APP_DEBUG",
			env: map[string]string{
				"APP_DEBUG":    "invalid",
				"DB_NAME":      "app",
				"DB_USERNAME":  "user",
				"DB_URL":       "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				"STORAGE_PATH": "/path/to/storage/dir",
			},
			failed: true,
		},
		{
			name: "invalid FAKE_TIME",
			env: map[string]string{
				"DB_NAME":      "app",
				"DB_USERNAME":  "user",
				"DB_URL":       "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				"STORAGE_PATH": "/path/to/storage/dir",
				"FAKE_TIME":    "invalid",
			},
			failed: true,
		},
		{
			name: "missing DB_NAME",
			env: map[string]string{
				"DB_USERNAME":  "user",
				"DB_URL":       "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				"STORAGE_PATH": "/path/to/storage/dir",
			},
			failed: true,
		},
		{
			name: "missing DB_USERNAME",
			env: map[string]string{
				"DB_NAME":      "app",
				"DB_URL":       "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
				"STORAGE_PATH": "/path/to/storage/dir",
			},
			failed: true,
		},
		{
			name: "missing DB_URL",
			env: map[string]string{
				"DB_NAME":      "app",
				"DB_USERNAME":  "user",
				"STORAGE_PATH": "/path/to/storage/dir",
			},
			failed: true,
		},
		{
			name: "missing STORAGE_PATH",
			env: map[string]string{
				"DB_NAME":     "app",
				"DB_USERNAME": "user",
				"DB_URL":      "postgres://postgres:password@localhost:5432/gwork?sslmode=disable",
			},
			failed: true,
		},
	}

	for _, v := range cases {
		t.Run(v.name, func(tt *testing.T) {
			for key, value := range v.env {
				tt.Setenv(key, value)
			}

			cfg, err := config.Get()
			switch {
			case err != nil && !v.failed:
				tt.Fatalf("unexpected error: %+v", err)
			case err == nil && v.failed:
				tt.Fatal("unexpected success")
			case err != nil && v.failed:
				// pass
				tt.Logf("expected error: %+v", err)
				return
			}

			if diff := cmp.Diff(v.out, cfg); diff != "" {
				tt.Errorf("unexpected result:\n%s", diff)
			}
		})
	}
}
