#!/bin/bash

ENV=${1:-dev}
PROGRAM=${2:-calculator}

CONFIG_FILE="./config/${ENV}.cfg"
PROGRAM_DIR="./src/${PROGRAM}"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Error: No config found for environment: $ENV"
    exit 1
fi

if [[ ! -d "$PROGRAM_DIR" ]]; then
    echo "Error: No program found: $PROGRAM"
    echo "Available: calculator, evenodd, fibonacci, palindrome"
    exit 1
fi

source "$CONFIG_FILE"
trap on_exit EXIT

on_exit() {
    if [[ $? -ne 0 ]]; then
        log "ERROR" "Pipeline exited unexpectedly"
        rollback
    fi
    rm -rf "$BACKUP_DIR"
}

LOG_FILE="./pipeline_${ENV}_$(date +%Y%m%d_%H%M%S).log"

log() {
    local level=$1
    local msg=$2
    echo "[$(date '+%H:%M:%S')] [$level] $msg" | tee -a "$LOG_FILE"
}

run_step() {
    local step_name=$1
    shift
    log "INFO" "Starting: $step_name"
    "$@"
    local exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        log "ERROR" "$step_name failed (exit code: $exit_code)"
        return 1
    fi
    log "OK" "$step_name passed"
    return 0
}

stage_pull() {
    if git remote | grep -q .; then
        git stash
        run_step "Git Pull" git pull
    else
        log "INFO" "Git Pull skipped (no remote configured)"
    fi
}

stage_backup() {
    BACKUP_DIR="/home/jay/Desktop/OS-LabFinal/backup_${ENV}_$(date +%s)"
    mkdir -p "$BACKUP_DIR"
    cp -r "$DEPLOY_DIR/." "$BACKUP_DIR/" 2>/dev/null
    log "INFO" "Backup created at $BACKUP_DIR"
}

stage_build() {
    run_step "Build" g++ "$PROGRAM_DIR/main.cpp" -o build/app
}

stage_test() {
    run_step "Tests" bash "$PROGRAM_DIR/test.sh"
}

stage_deploy() {
    run_step "Deploy" cp -r build/app "$DEPLOY_DIR/"
}

rollback() {
    log "WARN" "Initiating rollback for environment: $ENV"
    if [[ -n "$BACKUP_DIR" && -d "$BACKUP_DIR" ]]; then
        cp -r "$BACKUP_DIR/." "$DEPLOY_DIR/"
        log "OK" "Rollback complete. Restored from $BACKUP_DIR"
    else
        log "WARN" "No backup found. Rollback skipped."
    fi
}

notify() {
    local status=$1
    if [[ -n "$WEBHOOK_URL" ]]; then
        curl -s -X POST "$WEBHOOK_URL" -H "Content-Type: application/json" -d "{\"pipeline\": \"$ENV_NAME\", \"status\": \"$status\"}"
        log "INFO" "Webhook notification sent: $status"
    else
        log "WARN" "No webhook URL configured, skipping notification"
    fi
}

STAGES=(stage_pull stage_backup stage_build stage_test stage_deploy)

log "INFO" "Pipeline started for environment: $ENV"

for stage in "${STAGES[@]}"; do
    $stage
    if [[ $? -ne 0 ]]; then
        log "ERROR" "Pipeline halted at: $stage"
        rollback
        notify "FAILED at $stage"
        exit 1
    fi
done

log "OK" "Pipeline completed successfully for environment: $ENV"
notify "SUCCESS"
