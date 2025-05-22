# 🚀 Open WebUI + LiteLLM Stack

This repository provides a clean, production-ready setup that combines [Open WebUI](https://github.com/open-webui/open-webui) and [LiteLLM](https://github.com/BerriAI/litellm) in a single Dockerized environment. Easily chat with models like GPT-4o, Claude 3.5, DeepSeek, Groq, and more — all through a sleek web interface and a unified backend.

---

## 🧩 What's Included

| Component     | Description                                                                 |
|---------------|-----------------------------------------------------------------------------|
| 🧠 **LiteLLM**     | An open-source proxy layer for various LLM APIs                        |
| 💬 **Open WebUI** | A beautiful frontend for LLM interaction via LiteLLM                    |
| 🗃 **PostgreSQL**  | Optional persistent database for model tracking via LiteLLM             |
| ⚙️ **Build Scripts** | Interactive shell scripts for setup, configuration, and deployment  |

---

## 📂 File Overview

```
📦 root/
├── build.sh             # Interactive installer for setting environment variables
├── run.sh               # Starts the full Docker stack with debug/background options
├── Dockerfile           # Builds a custom LiteLLM container
├── config.yml           # Lists all models and providers with env-linked API keys
├── .env                 # API secrets and master key used inside containers
├── docker-compose.yaml  # Service orchestration for Open WebUI, LiteLLM & DB
```

---

## 🛠️ Setup

### 1. Clone the Repo

```bash
git clone https://github.com/devsnit/openwebui-litellm.git
cd openwebui-litellm
```

### 2. Run the Installer

This will prompt you to enter all your environment variables and auto-create `.env`.

```bash
chmod +x build.sh
./build.sh
```

You will be asked for:
- 🔑 `MASTER_KEY` — required to access the LiteLLM API
- 🔐 API keys — for OpenAI, Anthropic, Groq, DeepSeek, etc.

Once complete, the LiteLLM Docker image will be built.

---

### 3. Start the Services

```bash
chmod +x run.sh
./run.sh
```

Choose whether to run in:
- **Debug mode** (see logs live in terminal)
- **Background mode** (recommended for production)

---

## 🔐 .env Variables

| Variable             | Description                          |
|----------------------|--------------------------------------|
| `MASTER_KEY`         | Required for authenticating requests |
| `OPENAI_API_KEY`     | Your OpenAI key                      |
| `ANTHROPIC_API_KEY`  | Your Claude key                      |
| `GROQ_API_KEY`       | Your Groq key                        |
| `DEEPSEEK_API_KEY`   | Your DeepSeek key                    |
| `CODESTRAL_API_KEY`  | Your Codestral key                   |

All values are injected into `config.yml` using the format: `os.environ/VAR_NAME`.

---

## 🧠 Model Configuration

Example from `config.yml`:

```yaml
- model_name: gpt-4o
  litellm_params:
    model: gpt-4o
    api_key: os.environ/OPENAI_API_KEY
```

Supported models include:
- OpenAI (`gpt-4o`, `gpt-4o-mini`)
- Anthropic (`Claude 3.5`)
- DeepSeek
- Codestral
- Groq (LLaMA 3.1 70B/8B)
- OpenRouter models

---

## 🌐 Access

Once the stack is running:

| Service       | URL                      |
|---------------|--------------------------|
| 🖥 Open WebUI | http://localhost:3000     |
| 🔁 LiteLLM API | http://localhost:4000    |

---

## 🧹 Cleanup

To stop all services:

```bash
docker compose down -v
```

---

## 📝 Notes

- Docker Compose maps `config.yml` into the LiteLLM container
- PostgreSQL is used only if you enable persistence in LiteLLM

---

## 📄 License

MIT License  
Crafted with ❤️ by [Devsnit](https://devsnit.com)
