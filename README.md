# Welcome to OlhAedes!

Hi! For a brief context, this is a project with a scientific focus and with the purpose of assisting in pest control programs in the real world, more precisely, the LIRAa program.

The "Levantamento de Índice Rápido para *Aedes aegypti*" (LIR*A*a) is an official guidance already approved and in use that aims to provide entomoepidemiological survey indexes for a quick and timely mapping of the possible progress of Aedes aegypti in order to direct the appropriate actions to be taken.

The **OlhAedes** project aims to make the LIR*A*a process more efficient by abandoning its analogue mode and computerizing the entire flow, from the data collected by the field agents to their laboratory analysis.

# Modules

This application is basically divided into 3 modules:

1. PWA - Progressive Web App
    - Application used by field agents for data collection.
2. Admin
    - Application used to manage the collected data, check out reports, etc.
3. API
    - Application to support and processes all the information needed by both the admin and pwa  applications

# Dependencies

- Ruby Version  `3.1.0`
- Rails Version  `7.0.2`
- Database  `PostgreSQL`
- Rails Server  `Puma`

# Installation

1. Clone the project
```bash
$ git clone git@github.com:diligasi/olhaedes.git
```

2. Get the credential keys from the project manager and put the `master.key` on the `config/` folder. The other keys should be put on the `config/credentials` folder.

3. Run bundler to install everything
```bash
$ bundle install
```

4. Run specs
```bash
$ bundle exec rspec .
```

5. The specs should run without error
