<img width="300" src="https://github.com/coderalert0/rootly-1/assets/70709697/eb2f2321-0dd4-46c0-9357-656ef10a4e39">

This project implements two slack commands to declare and resolve incidents. It also provides a UI with a sortable table which lists the incidents and their attributes

<img width="1436" alt="Screen Shot 2023-06-01 at 8 28 33 AM" src="https://github.com/coderalert0/rootly-1/assets/70709697/226ab760-22fe-44b2-b60b-71455567a244">

## Class Design

**Incident:** This is the model which represents an incident, title must be present

**IncidentDecorator**: This is a class that contains presentation logic for the Incident model, this follows the presenter design pattern.

**IncidentsHelper:** This is a class to generate links for the column headers on the list page to facilitate sorting by ascending or descending value

**IncidentsController:** This is a class supporting two actions, index and call. The index action is responsible for displaying the list of incidents on the UI. The call action is a callback for the aforementioned slack commands

## Database Schema
<img width="200" src="https://github.com/coderalert0/rootly-1/assets/70709697/dabfedca-0549-4f83-a43b-fbc285276379">

## Directory Structure
**config/locales:** Contains the translation file. It is a best practice to keep static text in such a file rather than hard-coding it. It promotes DRY code and potential support for other languages in the future.

**decorators**: Contains decorator classes which follow the presenter design pattern. The purpose is to separate out presentation logic from non-presentation logic which promotes modular design and simpler unit tests.

**test**: Contains unit tests. Unit tests were written for the model, controller, and decorator

## Workflow

A slack application was first created for which a bot user was added. A bot user is required before slash commands can be added.

A slash command was then added with the following configuration.
```bash
Command: /rootly
Request URL: https://rootly-1.onrender.com/incidents/call
```
When a slash command is sent via Slack, a POST request is made to the aforementioned URL passing the command options and other metadata (ie user_name, channel_name) as params

The URL maps to IncidentsController#call which has conditional logic to handle both declare and resolve options

The controller action either creates or updates an incident depending on the slash command, and it ultimately renders a success message which is propagated back to Slack

## Running Locally

Clone the project

```bash
  git clone git@github.com:coderalert0/rootly-1.git
```

Go to the project directory

```bash
  cd rootly-1
```

Start the docker containers

```bash
  docker-compose up
```

Install and run ngrok to route request url to local environment. You will need to signup for an account at https://ngrok.com/
```bash
  ngrok http 3000
```

Update the slash command "Request URL" to point to the ngrok url

## Running Slack commands

### To create a new incident
```bash
  /rootly declare --title May Day May Day! --description All hell is breaking loose  --severity sev2
```
title: required\
description: optional\
severity: optional [sev0, sev1, sev2]

Output
```bash
  The incident was created
```

### To resolve an existing incident
```bash
  /rootly resolve [incident_id]
```
Output
```bash
  The resolution time was: 25 minutes, 4 seconds
```

## Live Environment
https://rootly-1.onrender.com/

## Live Demo
https://github.com/coderalert0/rootly-1/assets/70709697/585ce624-9bc9-4a0a-8ff7-d3058506f2a5

## Running Tests

To run tests, run the following command

```bash
  rspec test
```

## Caveats

The requirement for the resolve command to be only issued from the incident channel itself was not satisfied due to deployment issues. 

I tried to store the API key in an .env file however anytime I pushed the code to GitHub, Slack would detect this and deactivate the key. 

Alternatively I could not set an environment variable directly on render.com due to the free plan feature-walling ssh capabilities.

This prevented me from making API calls to create a new channel, so both declare and resolve commands needs to be made from the same channel. The resolve command requires an incident_id passed to it due to the channel creation limitation (refer to sample command in the Running Slack commands section)