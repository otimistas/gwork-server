# Development

This document describes the process for running this application on your local computer.

## Requirements
- [Go](#how-to-install-go)
- [aqua](#how-to-install-aqua)

### How to install Go

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

You should now have a running server! Visit [localhost:10012](http://localhost:10012) in your browser.

When you're ready to stop your local server, type <kbd>Ctrl</kbd>+<kbd>C</kbd> in your terminal window.

### Using GitHub Codespaces

As an alternative, you can simply use [GitHub Codespaces](https://docs.github.com/en/codespaces/overview). For more information about using a codespace for working on GitHub documentation, see "[Working in a codespace](https://docs.github.com/en/contributing/setting-up-your-environment-to-work-on-github-docs/working-on-github-docs-in-a-codespace)."

In a matter of minutes, you will be ready to edit, preview and test your changes directly from the comfort of your browser.

### How to Debug

go-delve is available by default for the go debugger.
See [[go-delve/delve](https://github.com/go-delve/delve)](https://github.com/go-delve/delve) for usage.

Of course, you can also use your favorite debugging tools.

## READMEs

For more info about working with this site, check out these READMEs:
