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

# 4. Environment Configuration (Manual Steps)

Write-Host "`n--- 4. Environment Configuration (Manual Steps) ---"
Write-Host "These steps require a Google Cloud Project ID and credentials, which will be provided at the hackathon."
Write-Host "1. Authenticate Your Account: gcloud auth application-default login"
Write-Host "2. Set Your Project: gcloud config set project YOUR_PROJECT_ID"
Write-Host "3. Verify APIs (Optional): gcloud services enable aiplatform.googleapis.com run.googleapis.com"

Write-Host "`n--- Prerequisite Check Complete ---"
Write-Host "Please review the output and address any '❌' items."
