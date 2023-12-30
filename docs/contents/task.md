# Task

Each task has its own command, so you can execute complex processes by executing that command.
It also serves as a list of tasks available in Visual Studio Code (GitHub Codespaces).

However, if you are using a container, you need to execute it from inside the container.

### Server Execution

#### `serve`

```shell
mage serve
```

Start the server.

#### `dev`

```shell
mage dev
```

Starts the development server.

The differences from the `serve` task are as follows

- live reloading (the ability to monitor file changes and rebuild automatically) is enabled
- Debugger ([delve](https://github.com/go-delve/delve)) can be attached.

You can change the port that the debug server LISTENS to by setting the environment variable `DEBUGGING_PORT`.

#### `kill`

```shell
mage kill
```

Kills processes associated with the development server.

Basically, use this when you have lost control of the `serve` or `dev` task in a Codespace environment, and you get an `address already in use` error when trying to start a new development server.
As a rule, do not use this function in the local environment, as it may kill unrelated processes.

### Database Management

The database for the task is stored in the [environment variable](. /environment.md).

#### `db:create`

```shell
mage db:create
```

Creates a database.

No tables are created.

#### `db:migrate`

```shell
mage db:migrate
```

Applies `/db/migrations/**/` to the already created database and creates the tables.
Execute any files that have not been executed. Note that you can use [db:up](#dbup-number) to specify how many versions to advance.

#### `db:up ${number}`

```shell
mage db:up "${number}"
```

Execute migration for the specified number.

#### `db:force ${version}`

```shell
mage db:force "${version}"
```

Force the database version to the specified version.

#### `db:rollback`

```shell
mage db:rollback
```

Rolls back all executed migrations.
You can use [db:down](#dbdown-number) to specify how many versions to roll back.

#### `db:down ${number}`

```shell
mage db:down "${number}"
```

Return migration for the specified number.

#### `db:seed`

```shell
mage db:seed
```

Apply [seeds.sql](. /db/seeds.sql) is applied to the created database to create the initial data.

#### `db:drop`

```shell
mage db:drop
```

Drops a database that has already been created.

#### `db:reset`

```shell
mage db:reset
```

Reset the database to a new state.

Resets a database by running `db:drop`, `db:create`, `db:migrate`, and `db:seed` in that order.

#### `db:fake`

```shell
mage db:fake
```

Inject fake data.
Note that this cannot be executed in a production environment.

### Miscellaneous

#### `lint`

```shell
mage lint
```

Performs static analysis of a Go file.

#### `generate:proto`

```shell
mage generate:proto
```

Generate Go files under `/pb` according to the contents of the file `/proto/*.proto`.

#### `generate:migration ${file}`

```shell
mage generate:migration ${file}
```

Generate a database migration file.

The generated code will be output under `/db/migrations/**/`.

#### `generate:query`

```shell
mage generate:query
```

Generate a Go file with schema `/db/migrations/**/` and query `/db/query/**/`.

The generated code will be output under `/infra/sql/**/`.

