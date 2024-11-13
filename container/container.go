// Package container Provides a dependency injection container.
//
// This can be used when you want to use an interface that requires dependency resolution,
// such as a database or logger.
package container

import (
	"fmt"

	"github.com/jinzhu/copier"

	"github.com/otimistas/gwork-server/infrastructure"
)

var (
	// ErrAlreadyKey Error with a key that already exists.
	ErrAlreadyKey = fmt.Errorf("already exist key")
	// ErrNotExistKey Error when a non-existent key is specified.
	ErrNotExistKey = fmt.Errorf("not exist key")
	// ErrInvalidValue Error if the value is not set in bind or singleton.
	ErrInvalidValue = fmt.Errorf("bound value not found")
	// ErrAlreadyBind This is an error if bind or singleton has already been called.
	ErrAlreadyBind = fmt.Errorf("already call bind or singleton")
)

// Container Indicates the containers available on the application.
//
// The repository associated with the container to be used must satisfy the infrastructure.Repository.
type Container[T infrastructure.Repository] struct {
	used         keyValue
	repositories map[string]*T
}

// NewContainer Generates a container in an initialized state.
func NewContainer[T infrastructure.Repository]() *Container[T] {
	return &Container[T]{
		repositories: map[string]*T{},
	}
}

// Set Set the repository to the container key.
//
// Overwrites the key even if it exists.
func (c *Container[T]) Set(key string, repo *T) {
	c.repositories[key] = repo
}

// SetNew It behaves much the same as Set, but returns an error if the key already exists.
func (c *Container[T]) SetNew(key string, repo *T) error {
	if _, exist := c.repositories[key]; exist {
		return ErrAlreadyKey
	}
	c.repositories[key] = repo

	return nil
}

// Get Retrieves the repository for the specified key.
func (c *Container[T]) Get(key string) (*T, error) {
	repo, ok := c.repositories[key]
	if !ok {
		return nil, ErrNotExistKey
	}

	return repo, nil
}

// Bind Attaches the repository of the specified key to the container.
//
// In the case of bind, a new instance is created each time it is resolved,
// but the configuration items set in set continue to be maintained.
// Note that once bound, the binding cannot be performed again.
func (c *Container[T]) Bind(key string) error {
	_, ok := c.repositories[key]
	if !ok {
		return ErrNotExistKey
	}

	if c.used.IsValid {
		return ErrAlreadyBind
	}

	c.used.IsValid = true
	c.used.Key = key

	return nil
}

// Singleton Tie the repository to the container with a singleton.
//
// Note that unlike bind, it always returns the same instance.
// Note that once bound, the binding cannot be performed again.
func (c *Container[T]) Singleton(key string) error {
	_, ok := c.repositories[key]
	if !ok {
		return ErrNotExistKey
	}

	if c.used.IsValid {
		return ErrAlreadyBind
	}

	c.used.IsValid = true
	c.used.Key = key
	c.used.Singleton = true

	return nil
}

// Resolve Returns the repository tied to the container.
//
// Returns repositories tied by bind or singleton.
// The difference between the two is whether an instance is created each time or
// whether the same instance is always returned.
func (c *Container[T]) Resolve() (*T, error) {
	if !c.used.IsValid {
		return nil, ErrInvalidValue
	}
	key := c.used.Key
	repo, ok := c.repositories[key]
	if !ok {
		return nil, ErrNotExistKey
	}

	if c.used.Singleton {
		return repo, nil
	}

	var toValue *T

	if err := copier.CopyWithOption(toValue, repo, copier.Option{DeepCopy: true}); err != nil {
		return nil, fmt.Errorf("copy repository: %w", err)
	}

	return toValue, nil
}
