package domain

import (
	"context"
	"time"

	"github.com/google/uuid"
)

// UserEntity Definitions for User Domains
type UserEntity struct {
	ID             uuid.UUID `json:"id"`
	LoginID        string    `json:"login_id"`
	Password       string    `json:"password"`
	Name           string    `json:"name"`
	LastLoggedInAt time.Time `json:"last_logged_in_at"`
	CreatedBy      uuid.UUID `json:"created_by"`
	FromSystem     bool      `json:"from_system"`
	CreatedAt      time.Time `json:"created_at"`
	UpdatedAt      time.Time `json:"updated_at"`
}

type (
	// CreateUserParams Define arguments for user creation
	CreateUserParams struct {
		LoginID    string
		Password   string
		Name       string
		FromSystem bool
		CreatedBy  uuid.UUID
	}

	// UpdateUserNameParams Define arguments for user name change
	UpdateUserNameParams struct {
		ID   uuid.UUID
		Name string
	}

	// UpdateUserLoggedAtParams Define arguments for user login
	UpdateUserLoggedAtParams struct {
		ID uuid.UUID
	}

	// UpdateUserPasswordParams Define arguments for changing user passwords
	UpdateUserPasswordParams struct {
		ID       uuid.UUID
		Password string
	}
)

// UserRepository Database operation interface around the user
type UserRepository interface {
	CreateUser(ctx context.Context, arg CreateUserParams) (UserEntity, error)
	DeleteUser(ctx context.Context, id uuid.UUID) error
	FindUser(ctx context.Context, id uuid.UUID) (UserEntity, error)
	FindUserForLogin(ctx context.Context, loginID string) (UserEntity, error)
	GetUsers(ctx context.Context) ([]UserEntity, error)
	GetUsersFromName(ctx context.Context, name string) ([]UserEntity, error)
	UpdateUserLoggedAt(ctx context.Context, arg UpdateUserLoggedAtParams) (UserEntity, error)
	UpdateUserName(ctx context.Context, arg UpdateUserNameParams) (UserEntity, error)
	UpdateUserPassword(ctx context.Context, arg UpdateUserPasswordParams) (UserEntity, error)
}
