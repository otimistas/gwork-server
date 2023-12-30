package main

import (
	"context"
	"fmt"
	"path/filepath"

	"github.com/joho/godotenv"
	"github.com/magefile/mage/mg"
	"github.com/magefile/mage/sh"

	"github.com/otimistas/gwork-server/internal/config"
	"github.com/otimistas/gwork-server/magefiles/utils"
)

// Diff is mage namespace for code diff code.
type Diff mg.Namespace

// Tabledoc diff table schema and table document.
func (s Diff) Tabledoc(ctx context.Context) {
	mg.CtxDeps(ctx, s.tabledoc)
}

func (s Diff) tabledoc() error {
	repoRoot, err := utils.RepoRoot()
	if err != nil {
		return fmt.Errorf("get repo root: %w", err)
	}

	docDir := filepath.Join(repoRoot, "docs", "schema")

	if err := godotenv.Load(); err != nil {
		return fmt.Errorf("no .env file found: %w", err)
	}
	cfg, err := config.Get()
	if err != nil {
		return fmt.Errorf("get config: %w", err)
	}

	env := map[string]string{
		"TBLS_DSN":      cfg.DBUrl,
		"TBLS_DOC_PATH": docDir,
	}

	if err := sh.RunWithV(env, "tbls", "diff"); err != nil {
		return fmt.Errorf("run diff table document: %w", err)
	}

	return nil
}
