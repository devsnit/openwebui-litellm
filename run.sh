#!/bin/bash

# === Color codes ===
BOLD="\e[1m"
RESET="\e[0m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
GRAY="\e[90m"

print_section_header() {
  echo -e "\n${GRAY}============================================================${RESET}"
  echo -e "${BLUE}${BOLD}$1${RESET}"
  echo -e "${GRAY}============================================================${RESET}"
}

print_info() {
  echo -e "${BLUE}ℹ️  $1${RESET}"
}

print_success() {
  echo -e "${GREEN}✅ $1${RESET}"
}

# === Load .env ===
print_section_header "🌍 Loading Environment Variables"
set -a
source ./.env
set +a
print_success ".env variables loaded."

# === Stop Running Containers ===
print_section_header "🧹 Stopping Existing Containers"
docker compose down
print_success "Containers stopped."

# === Start Containers ===
print_section_header "🐳 Starting Stack"
echo -e "${YELLOW}❓ Do you want to run in debug mode (foreground logs)?${RESET}"
read -p "➡️  Type 'y' for debug mode or press Enter for background: " use_debug

if [[ "$use_debug" == "y" || "$use_debug" == "Y" ]]; then
  print_info "Starting in DEBUG mode (foreground)..."
  docker compose up
else
  print_info "Starting in background (detached mode)..."
  docker compose up -d
fi

print_success "Services started!"
echo -e "- 🌐 Open WebUI: http://localhost:3000"
echo -e "- 🔁 LiteLLM: http://localhost:4000"
