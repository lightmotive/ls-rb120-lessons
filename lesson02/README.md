# Lesson notes

1. [PlantUML syntax](https://plantuml.com/class-diagram).

## pets_diagram

![pets_diagram](https://www.plantuml.com/plantuml/svg/SoWkIImgAStDuL9GSCpBp4tCKR1IA2hDqz145iWgpIq0YY24R6fqTHLSyjE18a0ImdKgpSb90GiXAt9EBE5oICrB0Le10000 "pets_diagram")

## Get PlantUML working locally:

1. Learn how to [connect multiple dev containers](https://code.visualstudio.com/remote/advancedcontainers/connect-multiple-containers).
   1. Configure docker-compose.yml to build the [PlantUML server container](https://github.com/plantuml/plantuml-server) before the dev container.
   2. Update `plantuml.server` setting in `settings` of Ruby container's devcontainer.json.
      1. Replace "https://www.plantuml.com/plantuml" with correct container network's plantuml container URL (Docker network and port?).