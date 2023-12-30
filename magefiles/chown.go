package main

import (
	"context"
	"fmt"
	"os/user"

	"github.com/magefile/mage/mg"
	"github.com/magefile/mage/sh"

	"github.com/otimistas/gwork-server/magefiles/utils"
)

// Chown Change ownership of the working directory to the current user.
func Chown(ctx context.Context) {
	mg.CtxDeps(ctx, chown)
}

func chown() error {
	repoRoot, err := utils.RepoRoot()
	if err != nil {
		return fmt.Errorf("get repo root: %w", err)
	}

	currentUser, err := user.Current()
	if err != nil {
		panic(err)
	}

	if err := sh.RunV("sudo", "chown", "-R", currentUser.Username, repoRoot); err != nil {
		return fmt.Errorf("chown: %w", err)
	}

	return nil
}
