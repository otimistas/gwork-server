package pgadapter

import (
	"fmt"

	"github.com/google/uuid"

	"github.com/otimistas/gwork-server/domain"
	"github.com/otimistas/gwork-server/gen/sqlc/pgquery"
)

// ConvertUserEntities Convert users on multiple postgresql to users on the domain.
func ConvertUserEntities(u []pgquery.MUser) ([]domain.UserEntity, error) {
	users := make([]domain.UserEntity, len(u))

	for i, us := range u {
		v, err := ConvertUserEntity(us)
		if err != nil {
			return []domain.UserEntity{}, fmt.Errorf("convert user: %w", err)
		}

		users[i] = v
	}

	return users, nil
}

// ConvertUserEntity Create entities for domains from entity data for postgresql
func ConvertUserEntity(u pgquery.MUser) (domain.UserEntity, error) {
	createdBy, err := UUIDToDomain(u.CreatedBy)
	if err != nil {
		return domain.UserEntity{}, fmt.Errorf("retrieve uuid from created_by: %w", err)
	}

	return domain.UserEntity{
		ID:             u.ID,
		LoginID:        u.LoginID,
		Password:       u.Password,
		Name:           u.Name,
		LastLoggedInAt: u.LastLoggedInAt.Time,
		CreatedBy:      createdBy,
		FromSystem:     u.FromSystem,
		CreatedAt:      u.CreatedAt,
		UpdatedAt:      u.UpdatedAt,
	}, nil
}

// ConvertCreateUserParams Convert from param on domain to param for postgresql.
func ConvertCreateUserParams(p domain.CreateUserParams) (pgquery.CreateUserParams, error) {
	return pgquery.CreateUserParams{
		LoginID:    p.LoginID,
		Password:   p.Password,
		Name:       p.Name,
		CreatedBy:  UUIDToPg(p.CreatedBy),
		FromSystem: p.FromSystem,
	}, nil
}

// ConvertUpdateUserNameParams Convert from param on domain to param for postgresql.
func ConvertUpdateUserNameParams(p domain.UpdateUserNameParams) (pgquery.UpdateUserNameParams, error) {
	return pgquery.UpdateUserNameParams{
		ID:   p.ID,
		Name: p.Name,
	}, nil
}

// UpdateUserLoggedAtParams Convert from param on domain to param for postgresql.
func UpdateUserLoggedAtParams(p domain.UpdateUserLoggedAtParams) (uuid.UUID, error) {
	return p.ID, nil
}

// UpdateUserPasswordParams Convert from param on domain to param for postgresql.
func UpdateUserPasswordParams(p domain.UpdateUserPasswordParams) (pgquery.UpdateUserPasswordParams, error) {
	return pgquery.UpdateUserPasswordParams{
		ID:       p.ID,
		Password: p.Password,
	}, nil
}
