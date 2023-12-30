# Development

This document describes the process for running this application on your local computer.

## Requirements(Unless you [use Github Codespaces](#using-github-codespaces))
- [Go](#how-to-install-go)
- [aqua](#how-to-install-aqua)

### How to install Go

The Go language must be available in the development environment.

Please create an environment that allows development in the go language from [this document](https://go.dev/doc/install).

### How to install aqua

To install the build tool aqua, see [this document](https://aquaproj.github.io/docs/install).

If you want to know more details about how to use it, please refer to the following documents.

[aqua](https://aquaproj.github.io/docs/tutorial)

## Getting started

It runs on macOS, Windows, and Linux environments.

```shell
git clone https://github.com/otimistas/gwork-server.git
cd gwork-server
aqua policy allow "${PWD}/aqua-policy.yaml"
aqua i -l
```

### Use docker compose which is easy by default

You can easily build a server by using the containers provided.
This container uses hot reloading, so local file changes can be reflected in real time.

Check [this document](./sample-container.md) for more information.

### Use your own database server

If you want to use your own defined database server, register database-related information in `.env` and then start up the server.
You can connect to the database without using the `.env` file by setting the same following items in the environment variables.

Please check [this document](../contents/environment.md) for information on environment variable items.

When the environment variables are ready, execute the following command.

```shell
mage dev
```

This command allows development with hot loading.

## Using GitHub Codespaces

As an alternative, you can simply use [GitHub Codespaces](https://docs.github.com/en/codespaces/overview). For more information about using a codespace for working on GitHub documentation, see "[Working in a codespace](https://docs.github.com/en/contributing/setting-up-your-environment-to-work-on-github-docs/working-on-github-docs-in-a-codespace)."

In a matter of minutes, you will be ready to edit, preview and test your changes directly from the comfort of your browser.

### How to Debug

go-delve is available by default for the go debugger.
See [[go-delve/delve](https://github.com/go-delve/delve)](https://github.com/go-delve/delve) for usage.

Of course, you can also use your favorite debugging tools.

## About Environment Variables

In this application, environment variables can be set by writing them in the `.env` file.
Since the `.env` file does not exist at clone time, it can be easily implemented by copying and editing `.env.example`.

Please check [this document](../contents/environment.md) for information on environment variable items.

The application server and database server are designed to be loosely coupled, so that the database is not bound to the currently supported database configuration in `.env`.

## READMEs

For more info about working with this site, check out these READMEs:

- [Sample Container](./sample-container.md)
- [Environment Variables](../contents/environment.md)
