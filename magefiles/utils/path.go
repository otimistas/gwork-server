package utils

import (
	"fmt"
	"os"
)

// RepoRoot Returns the path to the repository root.
func RepoRoot() (string, error) {
	cur, err := os.Getwd()
	if err != nil {
		return "", fmt.Errorf("get working directory: %w", err)
	}

	return cur, nil
}
