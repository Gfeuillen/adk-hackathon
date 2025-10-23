#!/bin/bash

echo "--- Checking Prerequisites for Gemini Hackathon ---"

# Function to check command existence
command_exists () {
  command -v "$1" >/dev/null 2>&1
}

# 1. Local Tooling Installation

echo -e "\n--- 1. Local Tooling Installation ---"

# Check Git
if command_exists git; then
  GIT_VERSION=$(git --version | awk '{print $3}')
  echo "✅ Git is installed. Version: $GIT_VERSION"
else
  echo "❌ Git is NOT installed. Please install it from https://git-scm.com/book/en/v2/Getting-Started-Installing-Git"
fi

# Check Python 3.10+
if command_exists python3; then
  PYTHON_VERSION=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
  if awk -v ver="$PYTHON_VERSION" 'BEGIN { if (ver >= 3.10) exit 0; else exit 1 }'; then
    echo "✅ Python 3.10+ is installed. Version: $PYTHON_VERSION"
  else
    echo "❌ Python 3.10+ is NOT installed. Current version: $PYTHON_VERSION. Please install it from https://www.python.org/downloads/"
  fi
else
  echo "❌ Python 3 is NOT installed. Please install it from https://www.python.org/downloads/"
fi

# Check gcloud CLI
if command_exists gcloud; then
  GCLOUD_VERSION=$(gcloud --version | head -n 1)
  echo "✅ Google Cloud CLI (gcloud) is installed. Version: $GCLOUD_VERSION"
else
  echo "❌ Google Cloud CLI (gcloud) is NOT installed. Please install it from https://cloud.google.com/sdk/docs/install"
fi

# 2. Gemini CLI & Agent Starter Pack Tooling

echo -e "\n--- 2. Gemini CLI & Agent Starter Pack Tooling ---"

# Check Node.js 20+
if command_exists node; then
  NODE_MAJOR_VERSION=$(node -v | cut -d '.' -f 1 | sed 's/v//')
  if [ "$NODE_MAJOR_VERSION" -ge 20 ]; then
    echo "✅ Node.js 20+ is installed. Version: $(node -v)"
  else
    echo "❌ Node.js 20+ is NOT installed. Current version: $(node -v). Please install it from https://nodejs.org/"
  fi
else
  echo "❌ Node.js is NOT installed. Please install it from https://nodejs.org/"
fi

# Check Gemini CLI
if npm list -g @google/gemini-cli >/dev/null 2>&1; then
  GEMINI_CLI_VERSION=$(npm list -g @google/gemini-cli | grep @google/gemini-cli | awk -F'@' '{print $3}')
  echo "✅ Gemini CLI (@google/gemini-cli) is installed globally. Version: $GEMINI_CLI_VERSION"
else
  echo "❌ Gemini CLI (@google/gemini-cli) is NOT installed globally. Run: npm install -g @google/gemini-cli"
fi

# Check uv
if command_exists uv; then
  UV_VERSION=$(uv --version | awk '{print $2}')
  echo "✅ uv is installed. Version: $UV_VERSION"
else
  echo "❌ uv is NOT installed. Install using: curl -LsSf https://astral.sh/uv/install.sh | sh (macOS/Linux) or powershell -ExecutionPolicy ByPass -c \"irm https://astral.sh/uv/install.ps1 | iex\" (Windows)"
fi

# 3. Powering Up Your Gemini CLI with Extensions

echo -e "\n--- 3. Gemini CLI Extensions (Manual Installation if not present) ---"
echo "Please ensure the following Gemini CLI extensions are installed. If not, run the commands below:"
echo "gemini extensions install https://github.com/derailed-dash/adk-docs-ext"
echo "gemini extensions install https://github.com/gemini-cli-extensions/gcloud"
echo "gemini extensions install https://github.com/ox01024/gemini-cli-git"
echo "gemini extensions install https://github.com/gemini-cli-extensions/code-review"

# 4. Environment Configuration (Manual Steps)

echo -e "\n--- 4. Environment Configuration (Manual Steps) ---"
echo "These steps require a Google Cloud Project ID and credentials, which will be provided at the hackathon."
echo "1. Authenticate Your Account: gcloud auth application-default login"
echo "2. Set Your Project: gcloud config set project YOUR_PROJECT_ID"
echo "3. Verify APIs (Optional): gcloud services enable aiplatform.googleapis.com run.googleapis.com"

echo -e "\n--- Prerequisite Check Complete ---"
echo "Please review the output and address any '❌' items."
