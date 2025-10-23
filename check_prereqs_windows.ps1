#!/usr/bin/env powershell

Write-Host "--- Checking Prerequisites for Gemini Hackathon ---"

# Function to check command existence
function Test-CommandExists {
    param([string]$command)
    (Get-Command -Name $command -ErrorAction SilentlyContinue) -ne $null
}

# 1. Local Tooling Installation

Write-Host "`n--- 1. Local Tooling Installation ---"

# Check Git
if (Test-CommandExists git) {
    $gitVersion = (git --version).Split(" ")[2]
    Write-Host "✅ Git is installed. Version: $gitVersion"
} else {
    Write-Host "❌ Git is NOT installed. Please install it from https://git-scm.com/book/en/v2/Getting-Started-Installing-Git"
}

# Check Python 3.10+
if (Test-CommandExists python) {
    $pythonVersion = (python --version 2>&1).Split(" ")[1]
    $majorMinor = [version]($pythonVersion.Substring(0, $pythonVersion.LastIndexOf(".")))
    if ($majorMinor -ge [version]"3.10") {
        Write-Host "✅ Python 3.10+ is installed. Version: $pythonVersion"
    } else {
        Write-Host "❌ Python 3.10+ is NOT installed. Current version: $pythonVersion. Please install it from https://www.python.org/downloads/"
    }
} elseif (Test-CommandExists py) {
    $pythonVersion = (py -3 --version 2>&1).Split(" ")[1]
    $majorMinor = [version]($pythonVersion.Substring(0, $pythonVersion.LastIndexOf(".")))
    if ($majorMinor -ge [version]"3.10") {
        Write-Host "✅ Python 3.10+ is installed (via py launcher). Version: $pythonVersion"
    } else {
        Write-Host "❌ Python 3.10+ is NOT installed (via py launcher). Current version: $pythonVersion. Please install it from https://www.python.org/downloads/"
    }
} else {
    Write-Host "❌ Python is NOT installed. Please install it from https://www.python.org/downloads/"
}

# Check gcloud CLI
if (Test-CommandExists gcloud) {
    $gcloudVersion = (gcloud --version | Select-Object -First 1)
    Write-Host "✅ Google Cloud CLI (gcloud) is installed. Version: $gcloudVersion"
} else {
    Write-Host "❌ Google Cloud CLI (gcloud) is NOT installed. Please install it from https://cloud.google.com/sdk/docs/install"
}

# 2. Gemini CLI & Agent Starter Pack Tooling

Write-Host "`n--- 2. Gemini CLI & Agent Starter Pack Tooling ---"

# Check Node.js 20+
if (Test-CommandExists node) {
    $nodeVersion = (node -v).Replace("v", "")
    $nodeMajorVersion = [int]$nodeVersion.Split(".")[0]
    if ($nodeMajorVersion -ge 20) {
        Write-Host "✅ Node.js 20+ is installed. Version: $nodeVersion"
    } else {
        Write-Host "❌ Node.js 20+ is NOT installed. Current version: $nodeVersion. Please install it from https://nodejs.org/"
    }
} else {
    Write-Host "❌ Node.js is NOT installed. Please install it from https://nodejs.org/"
}

# Check Gemini CLI
$geminiCliInstalled = (npm list -g @google/gemini-cli -ErrorAction SilentlyContinue)
if ($geminiCliInstalled -match "@google/gemini-cli@") {
    $geminiCliVersion = ($geminiCliInstalled -split "@google/gemini-cli@")[1].Split("`n")[0]
    Write-Host "✅ Gemini CLI (@google/gemini-cli) is installed globally. Version: $geminiCliVersion"
} else {
    Write-Host "❌ Gemini CLI (@google/gemini-cli) is NOT installed globally. Run: npm install -g @google/gemini-cli"
}

# Check uv
if (Test-CommandExists uv) {
    $uvVersion = (uv --version).Split(" ")[1]
    Write-Host "✅ uv is installed. Version: $uvVersion"
} else {
    Write-Host "❌ uv is NOT installed. Install using: curl -LsSf https://astral.sh/uv/install.sh | sh (macOS/Linux) or powershell -ExecutionPolicy ByPass -c \"irm https://astral.sh/uv/install.ps1 | iex\" (Windows)"
}

# 3. Powering Up Your Gemini CLI with Extensions

Write-Host "`n--- 3. Gemini CLI Extensions (Manual Installation if not present) ---"
Write-Host "Please ensure the following Gemini CLI extensions are installed. If not, run the commands below:"
Write-Host "gemini extensions install https://github.com/derailed-dash/adk-docs-ext"
Write-Host "gemini extensions install https://github.com/gemini-cli-extensions/gcloud"
Write-Host "gemini extensions install https://github.com/ox01024/gemini-cli-git"
Write-Host "gemini extensions install https://github.com/gemini-cli-extensions/code-review"

# 4. Project Setup

Write-Host "`n--- 4. Project Setup ---"

# Check for agent_registration_tool directory
if (Test-Path -Path "agent_registration_tool" -PathType Container) {
    Write-Host "✅ agent_registration_tool directory found."
} else {
    Write-Host "❌ agent_registration_tool directory NOT found. Please clone it using: git clone https://github.com/VeerMuchandi/agent_registration_tool.git"
}

# Check for requirements.txt file
if (Test-Path -Path "requirements.txt" -PathType Leaf) {
    Write-Host "✅ requirements.txt file found."
} else {
    Write-Host "❌ requirements.txt file NOT found. Please create it."
}

# Check for virtual environment
if (Test-Path -Path "venv" -PathType Container) {
    Write-Host "✅ venv directory found."
} else {
    Write-Host "❌ venv directory NOT found. Please create a virtual environment using: python -m venv venv"
}

# Check for installed packages
if (Test-Path -Path "venv" -PathType Container) {
    $installedPackages = .\venv\Scripts\pip.exe list
    if ($installedPackages -match "google-cloud-aiplatform") {
        Write-Host "✅ google-cloud-aiplatform is installed."
    } else {
        Write-Host "❌ google-cloud-aiplatform is NOT installed. Please run: .\venv\Scripts\pip.exe install -r requirements.txt"
    }
    if ($installedPackages -match "google-auth") {
        Write-Host "✅ google-auth is installed."
    } else {
        Write-Host "❌ google-auth is NOT installed. Please run: .\venv\Scripts\pip.exe install -r requirements.txt"
    }
    if ($installedPackages -match "agent-starter-pack") {
        Write-Host "✅ agent-starter-pack is installed."
    } else {
        Write-Host "❌ agent-starter-pack is NOT installed. Please run: .\venv\Scripts\pip.exe install -r requirements.txt"
    }
}

# 5. Environment Configuration (Manual Steps)

Write-Host "`n--- 5. Environment Configuration (Manual Steps) ---"
Write-Host "These steps require a Google Cloud Project ID and credentials, which will be provided at the hackathon."
Write-Host "1. Authenticate Your Account: gcloud auth application-default login"
Write-Host "2. Set Your Project: gcloud config set project YOUR_PROJECT_ID"
Write-Host "3. Verify APIs (Optional): gcloud services enable aiplatform.googleapis.com run.googleapis.com"

Write-Host "`n--- Prerequisite Check Complete ---"
Write-Host "Please review the output and address any '❌' items."
