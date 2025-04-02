#!/bin/bash

# === Color Codes ===
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

# === Load .env ===
if [ -f .env ]; then
  set -a
  source ./.env
  set +a
else
  echo -e "${YELLOW}❌ .env file not found. Creating default .env...${RESET}"
  touch .env
fi

print_section_header "🔧 Configuration Setup"

read -p "➡️  Enter MASTER_KEY [${MASTER_KEY:-your_master_key}]: " input_master
MASTER_KEY=${input_master:-$MASTER_KEY}

read -p "➡️  Enter ANTHROPIC_API_KEY [${ANTHROPIC_API_KEY:-your_anthropic_api_key}]: " input_anthropic
ANTHROPIC_API_KEY=${input_anthropic:-$ANTHROPIC_API_KEY}

read -p "➡️  Enter OPENAI_API_KEY [${OPENAI_API_KEY:-your_openai_api_key}]: " input_openai
OPENAI_API_KEY=${input_openai:-$OPENAI_API_KEY}

read -p "➡️  Enter DEEPSEEK_API_KEY [${DEEPSEEK_API_KEY:-your_deepseek_api_key}]: " input_deepseek
DEEPSEEK_API_KEY=${input_deepseek:-$DEEPSEEK_API_KEY}

read -p "➡️  Enter CODESTRAL_API_KEY [${CODESTRAL_API_KEY:-your_codestral_api_key}]: " input_codestral
CODESTRAL_API_KEY=${input_codestral:-$CODESTRAL_API_KEY}

read -p "➡️  Enter GROQ_API_KEY [${GROQ_API_KEY:-your_groq_api_key}]: " input_groq
GROQ_API_KEY=${input_groq:-$GROQ_API_KEY}

# Save to .env
cat > .env <<EOF
MASTER_KEY=$MASTER_KEY
ANTHROPIC_API_KEY=$ANTHROPIC_API_KEY
OPENAI_API_KEY=$OPENAI_API_KEY
DEEPSEEK_API_KEY=$DEEPSEEK_API_KEY
CODESTRAL_API_KEY=$CODESTRAL_API_KEY
GROQ_API_KEY=$GROQ_API_KEY
EOF

echo -e "${GREEN}✅ .env updated successfully.${RESET}"

print_section_header "🐳 Building Custom LiteLLM Docker Image"
docker build -t litellm-custom -f Dockerfile . || { echo -e "${YELLOW}❌ Build failed.${RESET}"; exit 1; }
echo -e "${GREEN}✅ Image 'litellm-custom' built.${RESET}"

print_section_header "📦 Pulling Additional Docker Images"
docker compose pull openwebui db || true

print_section_header "📡 Docker Network Check"
if ! docker network ls | grep -qw bridge; then
  echo "Docker bridge network not found (which is unusual)."
fi

print_section_header "🏁 Ready! Use ./run.sh to start services."
echo -e "${GREEN}💡 You can now run the stack with: ./run.sh${RESET}"
