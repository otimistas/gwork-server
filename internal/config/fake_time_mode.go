package config

import (
	"errors"
	"strconv"
	"time"
)

// DefaultFakeTime Default initial time in time disguise mode.
var DefaultFakeTime = time.Date(2023, 1, 1, 12, 0, 0, 0, time.UTC)

// FakeTimeMode Indicates the time disguise mode setting.
type FakeTimeMode struct {
	// Enabled Valid when true
	Enabled bool
	// Time initial time
	Time time.Time
}

// parseFakeTimeMode Parses the time disguise mode setting string.
func parseFakeTimeMode(v string) (any, error) {
	if v == "" {
		return FakeTimeMode{}, nil
	}

	t, err := time.Parse(time.RFC3339, v)
	if err == nil {
		return FakeTimeMode{
			Enabled: true,
			Time:    t,
		}, nil
	}

	enabled, err := strconv.ParseBool(v)
	if err != nil {
		return nil, errors.New("invalid value")
	}

	if enabled {
		return FakeTimeMode{
			Enabled: true,
			Time:    DefaultFakeTime,
		}, nil
	}

	return FakeTimeMode{}, nil
}
