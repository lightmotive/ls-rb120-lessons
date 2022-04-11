# Lesson notes

## pets_diagram

![pets_diagram](pets_diagram.svg "pets_diagram")

## Local PlantUML - personal project:

1. Learn how to [connect multiple dev containers](https://code.visualstudio.com/remote/advancedcontainers/connect-multiple-containers).
   1. Configure docker-compose.yml to build the [PlantUML server container](https://github.com/plantuml/plantuml-server) before the dev container.
   2. Update `plantuml.server` setting in `settings` of Ruby container's devcontainer.json.
      1. Replace "https://www.plantuml.com/plantuml" with correct container network's plantuml container URL (Docker network and port?).
2. Learn [PlantUML class diagram syntax](https://plantuml.com/class-diagram); improve diagram in this folder, ensuring local diagrams generate as expected.
   1. Tweak server and dev container settings as needed.