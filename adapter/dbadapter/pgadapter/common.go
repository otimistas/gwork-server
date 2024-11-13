// Package pgadapter Type conversion when using postgresql as db manager
package pgadapter

import (
	"fmt"

	"github.com/google/uuid"
	"github.com/jackc/pgx/v5/pgtype"
)

// UUIDToPg Convert uuid for postgresql.
func UUIDToPg(id uuid.UUID) pgtype.UUID {
	return pgtype.UUID{
		Bytes: id,
		Valid: true,
	}
}

// UUIDToDomain Convert uuid for domain.
func UUIDToDomain(id pgtype.UUID) (uuid.UUID, error) {
	cID, err := uuid.FromBytes(id.Bytes[:])
	if err != nil {
		return cID, fmt.Errorf("convert uuid: %w", err)
	}

	return cID, nil
}

// TextToPg Convert text for postgresql.
func TextToPg(text string) pgtype.Text {
	return pgtype.Text{
		String: text,
		Valid:  true,
	}
}
