#!/bin/bash

# Function to print messages
print_message() {
  echo "================================================================================"
  echo "$1"
  echo "================================================================================"
}

# 1. Check for Git
if ! command -v git &> /dev/null
then
    print_message "Git is not installed. Please install it from https://git-scm.com/book/en/v2/Getting-Started-Installing-Git"
    exit 1
else
    print_message "Git is already installed."
fi

# 2. Check for Python
if ! command -v python3 &> /dev/null
then
    print_message "Python 3 is not installed. Please install version 3.10 or newer from https://www.python.org/downloads/"
    exit 1
else
    PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))
')
    if (( $(echo "$PYTHON_VERSION < 3.10" | bc -l) )); then
        print_message "Python version is $PYTHON_VERSION. Please upgrade to version 3.10 or newer."
        exit 1
    else
        print_message "Python version $PYTHON_VERSION is installed."
    fi
fi

# 3. Check for Google Cloud CLI
if ! command -v gcloud &> /dev/null
then
    print_message "Google Cloud CLI is not installed. Please install it from https://cloud.google.com/sdk/docs/install"
    exit 1
else
    print_message "Google Cloud CLI is already installed."
fi

# 4. Check for Node.js
if ! command -v node &> /dev/null
then
    print_message "Node.js is not installed. Please install version 20 or higher from https://nodejs.org/"
    exit 1
else
    NODE_VERSION=$(node -v)
    if (( $(echo "${NODE_VERSION:1} < 20" | bc -l) )); then
        print_message "Node.js version is $NODE_VERSION. Please upgrade to version 20 or higher."
        exit 1
    else
        print_message "Node.js version $NODE_VERSION is installed."
    fi
fi

# 5. Install Gemini CLI
if ! command -v gemini &> /dev/null
then
    print_message "Installing Gemini CLI..."
    npm install -g @google/gemini-cli
else
    print_message "Gemini CLI is already installed."
fi

# 6. Install uv
if ! command -v uv &> /dev/null
then
    print_message "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
else
    print_message "uv is already installed."
fi

# 7. Install Gemini CLI Extensions
print_message "Installing Gemini CLI extensions..."
gemini extensions install https://github.com/derailed-dash/adk-docs-ext
gemini extensions install https://github.com/gemini-cli-extensions/gcloud
gemini extensions install https://github.com/ox01024/gemini-cli-git
gemini extensions install https://github.com/gemini-cli-extensions/code-review

# 8. Clone Agent Registration Tool
if [ ! -d "agent_registration_tool" ]
then
    print_message "Cloning agent_registration_tool..."
    git clone https://github.com/VeerMuchandi/agent_registration_tool.git
else
    print_message "agent_registration_tool directory already exists."
fi

# 9. Create Virtual Environment
if [ ! -d "venv" ]
then
    print_message "Creating virtual environment..."
    python3 -m venv venv
else
    print_message "Virtual environment 'venv' already exists."
fi

# 10. Create requirements.txt
print_message "Creating requirements.txt..."
cat > requirements.txt << EOL
google-cloud-aiplatform
google-auth
agent-starter-pack
EOL

# 11. Install Dependencies
print_message "Installing dependencies..."
source venv/bin/activate
pip install -r requirements.txt

print_message "All prerequisites are installed and configured."
