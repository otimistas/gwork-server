// Package clock Define the clock interface to be used in the application.
//
// When using time.Now() in an application, the functionality of
// the clock package can be used to switch externally to fakeclock, etc.
package clock

import "time"

// Clock Interface for handling the current time.
// Use this interface when performing time-based processing,
// easy to disguise the time in tests, etc.
type Clock interface {
	// Now Returns the current time.
	Now() time.Time
}

var clk = &RealClock{}

// New Returns a Clock that handles the actual time.
func New() Clock {
	return clk
}

// RealClock Clock implementation by time.Now().
type RealClock struct{}

// Now Returns the current time.
func (s *RealClock) Now() time.Time {
	return time.Now()
}
