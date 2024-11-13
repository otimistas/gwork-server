// Package infrastructure Responsible for specific technical details
// and implementation of external libraries and frameworks
//
// Specific database connection details, how to use the validation library
// and how to connect to external APIs are implemented here.
package infrastructure

// Repository This interface must be satisfied to put in a CONTAINER that performs dependency injection.
type Repository any
