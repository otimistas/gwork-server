package main

import (
	"context"
	"fmt"
	"os"
	"path/filepath"

	"github.com/joho/godotenv"
	"github.com/magefile/mage/mg"
	"github.com/magefile/mage/sh"

	"github.com/otimistas/gwork-server/internal/config"
	"github.com/otimistas/gwork-server/magefiles/utils"
)

// Generate is mage namespace for code generation.
type Generate mg.Namespace

// Tabledoc generates table document codes.
func (s Generate) Tabledoc(ctx context.Context) {
	mg.CtxDeps(ctx, s.tabledoc)
}

// Protoc generates go code for grpc.
func (s Generate) Protoc(ctx context.Context) {
	mg.CtxDeps(ctx, s.protoc)
}

// Migration generates migration file.
func (s Generate) Migration(ctx context.Context, filename string) {
	mg.CtxDeps(ctx, s.migrationGenerator(filename))
}

func (s Generate) tabledoc() error {
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

	if err := sh.RunWithV(env, "tbls", "doc", "--rm-dist"); err != nil {
		return fmt.Errorf("run generate table document: %w", err)
	}

	return nil
}

func (s Generate) protoc() error {
	repoRoot, err := utils.RepoRoot()
	if err != nil {
		return fmt.Errorf("get repo root: %w", err)
	}

	protoDir := filepath.Join(repoRoot, "proto")

	genCmd := fmt.Sprintf("protoc -I%[1]s --go_out=%[1]s --go-grpc_out=%[1]s %[2]s/*.proto", repoRoot, protoDir)

	if err := sh.RunV("bash",
		"-c",
		genCmd,
	); err != nil {
		return fmt.Errorf("run generate go code for grpc: %w", err)
	}

	return nil
}

func (s Generate) migrationGenerator(filename string) func() error {
	return func() error {
		repoRoot, err := utils.RepoRoot()
		if err != nil {
			return fmt.Errorf("get repo root: %w", err)
		}

		dbDir := filepath.Join(repoRoot, "db", "migrations")

		managers, err := os.ReadDir(dbDir)
		if err != nil {
			return fmt.Errorf("read directory: %w", err)
		}

		for _, manager := range managers {
			if manager.IsDir() {
				migrateDir := filepath.Join(repoRoot, "db", "migrations", manager.Name())

				if err := sh.RunV("migrate",
					"create", "-ext", "sql", "-dir", migrateDir, "-seq", filename,
				); err != nil {
					return fmt.Errorf("run generate migration: %w", err)
				}
			}
		}

		return nil
	}
}
