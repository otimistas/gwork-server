package dbrepo

import (
	"context"
	"fmt"
	"time"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5"

	"github.com/otimistas/gwork-server/adapter/dbadapter/pgadapter"
	"github.com/otimistas/gwork-server/domain"
	"github.com/otimistas/gwork-server/gen/sqlc/pgquery"
)

// PgRepo A structure that implements a database operations repository using postgresql.
type PgRepo struct {
	conn *pgx.Conn
	// connPool *pgxpool.Pool
	// TODO: add logger interface
}

// func NewPgRepo(ctx context.Context, dbUrl string) (*PgRepo, error) {
// 	connPool, err := pgxpool.New(ctx, dbUrl)
// 	if err != nil {
// 		return nil, fmt.Errorf("cannot connect to db: %w", err)
// 	}

// 	return &PgRepo{nil, connPool}, nil
// }

// Register postgresql to be treated as a database operation repository.
func Register() {
}

const (
	pollDBInterval = 500 * time.Millisecond
	waitDBTimeout  = 120 * time.Second
)

// Begin Starts a transaction..
func (r PgRepo) Begin(ctx context.Context) (pgx.Tx, TxCleanup, error) {
	tx, err := r.conn.Begin(ctx)
	if err != nil {
		return nil, nil, fmt.Errorf("transaction begin: %w", err)
	}
	cleanup := func() error {
		err = tx.Rollback(ctx)
		if err != nil {
			return fmt.Errorf("transaction rollback: %w", err)
		}
		return nil
	}

	return tx, cleanup, nil
}

// Rollback Begin Rewind the transaction.
func (r PgRepo) Rollback(ctx context.Context, tx pgx.Tx) error {
	err := tx.Rollback(ctx)
	if err != nil {
		return fmt.Errorf("transaction rollback: %w", err)
	}
	return nil
}

// HasReady Check the database connection and wait until the database is ready for use.
func (r PgRepo) HasReady(ctx context.Context) (bool, error) {
	ctx, cancel := context.WithTimeout(ctx, waitDBTimeout)
	defer cancel()

	ticker := time.NewTicker(pollDBInterval)
	defer ticker.Stop()

	for {
		select {
		case <-ctx.Done():
			if err := ctx.Err(); err != nil {
				return false, fmt.Errorf("failed to wait for database setup: %w", err)
			}
			return true, nil
		case <-ticker.C:
			if err := r.conn.Ping(ctx); err != nil {
				continue
			}
			return true, nil
		}
	}
}

// CreateUser Create a new user.
func (r PgRepo) CreateUser(ctx context.Context, arg domain.CreateUserParams) (domain.UserEntity, error) {
	user := domain.UserEntity{}
	queries := pgquery.New(r.conn)

	pgParam, err := pgadapter.ConvertCreateUserParams(arg)
	if err != nil {
		return user, fmt.Errorf("convert create user param: %w", err)
	}
	muser, err := queries.CreateUser(ctx, pgParam)
	if err != nil {
		return user, fmt.Errorf("create user: %w", err)
	}

	user, err = pgadapter.ConvertUserEntity(muser)
	if err != nil {
		return user, fmt.Errorf("convert user entity: %w", err)
	}

	return user, nil
}

// DeleteUser Deletes the specified user based on id.
func (r PgRepo) DeleteUser(ctx context.Context, id uuid.UUID) error {
	queries := pgquery.New(r.conn)

	err := queries.DeleteUser(ctx, id)
	if err != nil {
		return fmt.Errorf("delete user: %w", err)
	}

	return nil
}

// FindUser Find a single user based on id.
func (r PgRepo) FindUser(ctx context.Context, id uuid.UUID) (domain.UserEntity, error) {
	user := domain.UserEntity{}
	queries := pgquery.New(r.conn)

	muser, err := queries.FindUser(ctx, id)
	if err != nil {
		return user, fmt.Errorf("find user: %w", err)
	}

	user, err = pgadapter.ConvertUserEntity(muser)
	if err != nil {
		return user, fmt.Errorf("convert user entity: %w", err)
	}

	return user, nil
}

// FindUserForLogin Searches for a single user with the specified login id.
func (r PgRepo) FindUserForLogin(ctx context.Context, loginID string) (domain.UserEntity, error) {
	user := domain.UserEntity{}
	queries := pgquery.New(r.conn)

	muser, err := queries.FindUserForLogin(ctx, loginID)
	if err != nil {
		return user, fmt.Errorf("find user for login id: %w", err)
	}

	user, err = pgadapter.ConvertUserEntity(muser)
	if err != nil {
		return user, fmt.Errorf("convert user entity: %w", err)
	}

	return user, nil
}

// GetUsers Get a list of multiple users.
func (r PgRepo) GetUsers(ctx context.Context) ([]domain.UserEntity, error) {
	queries := pgquery.New(r.conn)

	musers, err := queries.GetUsers(ctx)
	if err != nil {
		return []domain.UserEntity{}, fmt.Errorf("get users list: %w", err)
	}

	users, err := pgadapter.ConvertUserEntities(musers)
	if err != nil {
		return []domain.UserEntity{}, fmt.Errorf("convert users: %w", err)
	}

	return users, nil
}

// GetUsersFromName Returns a list of users resulting from a partial match search of user names.
func (r PgRepo) GetUsersFromName(ctx context.Context, name string) ([]domain.UserEntity, error) {
	queries := pgquery.New(r.conn)

	musers, err := queries.GetUsersFromName(ctx, pgadapter.TextToPg(name))
	if err != nil {
		return []domain.UserEntity{}, fmt.Errorf("get users list from name: %w", err)
	}

	users, err := pgadapter.ConvertUserEntities(musers)
	if err != nil {
		return []domain.UserEntity{}, fmt.Errorf("convert users: %w", err)
	}

	return users, nil
}

// UpdateUserLoggedAt Update the user's login date and time.
func (r PgRepo) UpdateUserLoggedAt(
	ctx context.Context,
	arg domain.UpdateUserLoggedAtParams,
) (domain.UserEntity, error) {
	user := domain.UserEntity{}
	queries := pgquery.New(r.conn)

	pgParam, err := pgadapter.UpdateUserLoggedAtParams(arg)
	if err != nil {
		return user, fmt.Errorf("convert param: %w", err)
	}
	muser, err := queries.UpdateUserLoggedAt(ctx, pgParam)
	if err != nil {
		return user, fmt.Errorf("update user logged at: %w", err)
	}

	user, err = pgadapter.ConvertUserEntity(muser)
	if err != nil {
		return user, fmt.Errorf("convert user entity: %w", err)
	}

	return user, nil
}

// UpdateUserName Update user name.
func (r PgRepo) UpdateUserName(ctx context.Context, arg domain.UpdateUserNameParams) (domain.UserEntity, error) {
	user := domain.UserEntity{}
	queries := pgquery.New(r.conn)

	pgParam, err := pgadapter.ConvertUpdateUserNameParams(arg)
	if err != nil {
		return user, fmt.Errorf("convert param: %w", err)
	}
	muser, err := queries.UpdateUserName(ctx, pgParam)
	if err != nil {
		return user, fmt.Errorf("update user name: %w", err)
	}

	user, err = pgadapter.ConvertUserEntity(muser)
	if err != nil {
		return user, fmt.Errorf("convert user entity: %w", err)
	}

	return user, nil
}

// UpdateUserPassword Perform a user password change.
func (r PgRepo) UpdateUserPassword(
	ctx context.Context,
	arg domain.UpdateUserPasswordParams,
) (domain.UserEntity, error) {
	user := domain.UserEntity{}
	queries := pgquery.New(r.conn)

	pgParam, err := pgadapter.UpdateUserPasswordParams(arg)
	if err != nil {
		return user, fmt.Errorf("convert param: %w", err)
	}
	muser, err := queries.UpdateUserPassword(ctx, pgParam)
	if err != nil {
		return user, fmt.Errorf("update user logged at: %w", err)
	}

	user, err = pgadapter.ConvertUserEntity(muser)
	if err != nil {
		return user, fmt.Errorf("convert user entity: %w", err)
	}

	return user, nil
}
