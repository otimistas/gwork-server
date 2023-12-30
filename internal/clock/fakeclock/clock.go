// Package fakeclock Defines a fake clock that implements the clock package
//
// Use this if you want to fix the time for a dummy or specify it explicitly.
package fakeclock

import (
	"sync"
	"time"

	"github.com/otimistas/gwork-server/internal/clock"
)

var _ clock.Clock = (*Clock)(nil)

// Clock implementation that returns a fixed time.
type Clock struct {
	mu  sync.RWMutex
	now time.Time
}

// New Generates and returns a Clock fixed at the specified time.
func New(t time.Time) *Clock {
	return &Clock{
		now: t,
	}
}

// Now Returns a fixed time.
func (s *Clock) Now() time.Time {
	s.mu.RLock()
	defer s.mu.RUnlock()
	return s.now
}

// SetTime Change the time to the specified value.
func (s *Clock) SetTime(t time.Time) {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.now = t
}
