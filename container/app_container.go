package container

import (
	"github.com/otimistas/gwork-server/infrastructure/dbrepo"
)

// AppContainer This is a container for all containers in the application that require DI.
//
// By registering and retrieving instances through containers below the infrastructure layer on the application,
// it is possible to achieve this without being aware of this layer in terms of logic.
type AppContainer struct {
	DB *Container[dbrepo.DBRepository]
}

// App The only container in the application
var App = AppContainer{
	DB: NewContainer[dbrepo.DBRepository](),
}
