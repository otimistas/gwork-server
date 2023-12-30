# Sample Container

One command is all it takes to set up the entire environment.
Hot reloading is supported, and changes to the code automatically change the process, ensuring a smooth development experience.

```shell
docker compose up -d
```

When the container is first launched, the following commands are used to create tables and insert initial values.

```shell
docker compose exec app mage db:migrate
docker compose exec app mage db:seed
```

To lower the container, use the following command

```shell
docker compose down
```

It is also possible to exit the application normally by using the following command.

```shell
docker compose exec app mage kill
```

In addition, if you want to delete the volume and other items in the container together, execute the following command.

```shell
docker compose down --volumes --remove-orphans
```

## Container configuration
- app<br>
  A container for the application, mounted in the project root (other than the sample-container directory).<br>
  File changes are synchronized to the files in the container, and hot reloading is achieved by having the server monitor file changes in the container.
- db<br>
　It is a database container and uses postgresql as its DBMS.

### Execution of basic commands

There are two ways to execute commands from within a container.

It is recommended that the commands to be executed be done through [defined tasks](../contents/task.md).

- Run by command<br>
  As an example, consider execution from the app container.<br>
  It is important to note that when environment variables are used on a command, they are expanded before they enter the container.<br>
  The following `execute interactively` is recommended when executing complex commands or multiple commands.

  ```shell
  docker compose exec app {command}
  ```
- Enter the container and execute commands interactively
  As an example, execute the command to enter the app container.

  ```shell
  docker compose exec app bash
  ```

### Check logs

The following commands can be used to adequately review the logs.

Note that this command is effective as a way to check the logs of the app container.

```shell
docker compose logs --tail=400 -f app
```
