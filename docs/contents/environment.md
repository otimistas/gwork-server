# Environment Variables

The following variables should be set in the environment variable
There are two ways to set environment variables.

## Basic Application Settings

| Name | Valid values | Description | Require | Default |
| --- | --- |
| `APP_DEBUG` | true or false | Indicates if this is a debug environment. | ✕ | false |
| `APP_ENV` | production, staging, test, development | Indicates the current environment.
 | ✕ | production |
| `PORT` | {number} | Indicates the port number of the grpc server. | ✕ | 50051 |
| `DEBUGGING_PORT` | {number} | Indicates the port number for debugging. | ✕ | 2345 |

## Database Settings

| Name | Valid values | Description | Require | Default |
| --- | --- |
| `DB_CONNECTION` | {[valid database](./database.md)} | Indicates the database manager to connect to. | ✕ | pgsql |
| `DB_HOST` | {string} | Indicates the host name of the database.
 | ✕ | localhost |
| `DB_PORT` | {number} | Indicates the port number of the database. | ✕ | 5432 |
| `DB_NAME` | {string} | Indicates the database name. | ○ | ✕ |
| `DB_USERNAME` | {string} | Indicates the user name for the database connection. | ○ | ✕ |
| `DB_PASSWORD` | {string} | Indicates the password for the database connection. | ✕ | ✕ |

## Application Settings

| Name | Valid values | Description | Require | Default |
| --- | --- |
| `FAKE_TIME` | {time format(RFC3339)} | The current time can be overridden by the set time when retrieving the current time. | ✕ | false |
| `STORAGE_PATH` | {dir absolute path} | Specify the absolute path to the storage. | ○ | ✕ |
