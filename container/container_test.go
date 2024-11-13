package container_test

import (
	"testing"

	"github.com/otimistas/gwork-server/container"
	"github.com/otimistas/gwork-server/infrastructure/dbrepo"
)

func TestAppContainer(t *testing.T) {
	container.App.DB.Set("test", dbrepo.New())
}
