# Automated CI/CD Pipeline in Bash

A lightweight **CI/CD (Continuous Integration / Continuous Deployment) pipeline** built from scratch using **Bash scripting on Ubuntu Linux**.

This project automates the core software delivery workflow:

- Pull latest code from Git
- Create deployment backups
- Build source code
- Run automated tests
- Deploy successful builds
- Rollback on failure
- Generate logs
- Send webhook notifications

The goal of this project was to understand how modern CI/CD tools like Jenkins and GitHub Actions work internally by recreating their core functionality using only Linux utilities and shell scripting.

---

## Skills Demonstrated

- Bash scripting
- Linux automation
- CI/CD pipeline design
- Git workflows
- Multi-environment deployment
- Rollback strategies
- Logging & monitoring
- Process and error handling

---

## Features

✅ Automated Git integration  
✅ Build automation using g++  
✅ Automated testing using shell scripts  
✅ Separate deployment environments  
✅ Rollback on build/test/deploy failure  
✅ Timestamped logs  
✅ Webhook notifications using curl  
✅ Modular pipeline architecture  

---

## Project Structure

```text
bash-cicd-pipeline/
├── build/          # Compiled binaries
├── config/         # Environment configuration files
├── deploy/         # Deployment targets
├── logs/           # Pipeline logs
├── src/            # Source code + tests
└── pipeline.sh     # Main CI/CD pipeline
```

### Folder Overview

- **src/** → Contains C++ programs and their test scripts  
- **config/** → Environment-specific configuration files  
- **build/** → Generated compiled binaries  
- **deploy/** → Simulated deployment directories  
- **logs/** → Pipeline execution logs  
- **pipeline.sh** → Main automation script  

---

## Pipeline Architecture

```text
Git Pull → Backup → Build → Test → Deploy
                     ↓
                  Rollback
```

### Pipeline Stages

1. Pull latest code  
2. Backup current deployment  
3. Build selected program  
4. Run automated tests  
5. Deploy if successful  
6. Rollback if any stage fails  

---

## Supported Environments

The pipeline supports three isolated environments:

- **dev**
- **staging**
- **prod**

Each environment has:
- Separate configuration
- Separate deployment directory
- Independent webhook configuration

---

## Sample Programs

To simulate real builds, the pipeline supports multiple C++ applications:

- Calculator
- Even/Odd Checker
- Fibonacci Generator
- Palindrome Checker

Each program contains:
- `main.cpp`
- `test.sh`

The pipeline can build and test any of these automatically.

---

## Tech Stack

- Ubuntu Linux
- Bash
- Git
- g++
- curl
- C++

---

## Setup

Clone repository:

```bash
git clone <your-repo-url>
cd Automated_CICD_Pipeline
```

Make script executable:

```bash
chmod +x pipeline.sh
```

---

## Usage

Run pipeline:

```bash
./pipeline.sh <environment> <program>
```

Example:

```bash
./pipeline.sh dev calculator
```

More examples:

```bash
./pipeline.sh staging fibonacci
./pipeline.sh prod palindrome
./pipeline.sh dev evenodd
```

---

## Example Successful Run

```text
[INFO] Starting pipeline...
[INFO] Pull successful
[INFO] Backup created
[INFO] Build successful
[INFO] Tests passed
[SUCCESS] Deployment completed
```

---

## Failure Handling

If any stage fails:

- Build failure
- Test failure
- Deployment failure
- Unexpected crash

The pipeline automatically:

1. Stops execution  
2. Restores previous deployment  
3. Logs the failure  
4. Sends failure notification  

Example:

```text
[ERROR] Tests failed
[WARN] Rollback triggered
[INFO] Previous deployment restored
```

---

## Logging

Each pipeline run generates timestamped logs.

Example:

```text
[2026-07-03 18:45:02] INFO: Build started
[2026-07-03 18:45:05] INFO: Tests passed
[2026-07-03 18:45:07] SUCCESS: Deployment complete
```

Logs help with:
- Debugging
- Monitoring
- Deployment history

---

## Operating System Concepts Applied

This project demonstrates several OS concepts:

### Process Management
External commands spawn child processes:
- git
- g++
- cp
- curl

### Exit Codes
Commands return:
- `0` → success
- non-zero → failure

Pipeline decisions depend on these codes.

### File System Operations
Used heavily for:
- backups
- deployment
- cleanup
- logging

Commands used:
- `mkdir`
- `cp`
- `rm`

### Signal Handling
The pipeline uses Bash `trap` for cleanup and recovery.

Example:

```bash
trap on_exit EXIT
```

---

## Why I Built This

I wanted to understand what happens behind tools like:

- Jenkins
- GitHub Actions
- GitLab CI/CD

Instead of using managed services, I implemented core CI/CD behavior manually using Bash and Linux commands.

Building this project helped me better understand:

- automation
- process orchestration
- deployment strategies
- failure recovery
- system-level scripting

---

## Future Improvements

Possible enhancements:

- Remote deployment via SSH
- Parallel build stages
- Docker integration
- Dashboard for pipeline history
- Cloud deployment support

---

## Demo

Add screenshots or terminal recordings here:

- Successful deployment
- Failed build with rollback
- Webhook notifications

Example:

```md
![Success](assets/success.png)
![Rollback](assets/failure.png)
```

---

## Author

**Khadija Asim**  
Computer Science Student
