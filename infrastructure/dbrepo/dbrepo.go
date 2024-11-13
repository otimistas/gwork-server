// Package dbrepo Repositories dealing with database perimeter
//
// We have several abstracted repositories and implementations within the application.
package dbrepo

import (
	"context"

	"github.com/otimistas/gwork-server/domain"
)

// RepoTx This value is required to perform transaction processing.
type RepoTx any

// TxCleanup Function executed during transaction cleanup.
type TxCleanup func() error

// DBRepository Interface for manipulating databases
//
// Repositories that handle databases must satisfy this interface.
type DBRepository[T RepoTx] interface {
	Begin(context.Context) (T, TxCleanup, error)
	HasReady(context.Context) (bool, error)

	domain.UserRepository
}
