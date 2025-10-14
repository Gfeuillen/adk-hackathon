## **🚀 Gemini Hackathon: Prerequisites Guide**

Welcome, hackers\! To ensure you can hit the ground running and focus on building amazing things, please complete the following local setup **before** the event begins. At the hackathon, you will be provided with a Google Cloud Project ID, a default region, and credentials to log in.

---

### **1\. Local Tooling Installation**

You'll need a few command-line tools installed to interact with the provided cloud environment and build your agent.

* **Git**: We'll use Git to clone repositories and manage code.  
  * **Check if installed**: git \--version  
  * **To install**: Follow the instructions on the [official Git website](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).  
* **Python**: The agent starter pack requires Python.  
  * **Check if installed**: python3 \--version (We recommend version 3.10 or newer).  
  * **To install**: Download it from the [official Python website](https://www.python.org/downloads/).  
* **Google Cloud CLI (gcloud)**: This is the primary tool for interacting with your Google Cloud project from the terminal.  
  * **Check if installed**: gcloud \--version  
  * **To install**: Follow the official [Google Cloud CLI installation guide](https://cloud.google.com/sdk/docs/install).

---

### **2\. Gemini CLI & Agent Starter Pack Tooling**

This is the core of the hackathon. The Gemini CLI is an interactive AI agent that will help you build your own agent.

* **Node.js**: The Gemini CLI requires Node.js.  
  * **Check if installed**: node \-v (Version 20 or higher is required).  
  * **To install**: Download it from the [official Node.js website](https://nodejs.org/).  
* **Install Gemini CLI**: Once you have Node.js, install the Gemini CLI globally using npm (Node Package Manager).  
  Bash  
  npm install \-g @google/gemini-cli

* **Install uv**: The Agent Starter Pack uses uv to create new projects.  
  * **macOS / Linux**:  
    Bash  
    curl \-LsSf https://astral.sh/uv/install.sh | sh

  * **Windows**:  
    Bash  
    powershell \-ExecutionPolicy ByPass \-c "irm https://astral.sh/uv/install.ps1 | iex"

---

### **3\. Powering Up Your Gemini CLI with Extensions**

To give your Gemini CLI superpowers for the hackathon, you'll install a set of powerful extensions. These tools will allow the CLI to read documentation, interact with Google Cloud, manage your code with Git, and perform code reviews.

Run the following commands in your terminal to install each extension:

Bash

\# For Agent Development Kit (ADK) documentation access  
gemini extensions install https://github.com/derailed-dash/adk-docs-ext

\# To run Google Cloud (gcloud) commands  
gemini extensions install https://github.com/gemini-cli-extensions/gcloud

\# For Git utilities (e.g., commit, push)  
gemini extensions install https://github.com/ox01024/gemini-cli-git

\# For code review capabilities  
gemini extensions install https://github.com/gemini-cli-extensions/code-review

---

### **4\. Environment Configuration**

Once you arrive at the hackathon, you will need to configure your local tools to connect to the provided Google Cloud project.

1. **Authenticate Your Account**: Use the credentials provided by the organizers to log in. This command will open a browser window for you to sign in.  
   Bash  
   gcloud auth application-default login

2. **Set Your Project**: Configure the gcloud CLI to use the specific Project ID given to you.  
   Bash  
   gcloud config set project YOUR\_PROJECT\_ID

   (Replace YOUR\_PROJECT\_ID with the ID provided by the organizers).  
3. **Verify APIs (Optional but Recommended)**: The organizers should have enabled the necessary APIs, but you can run the following commands to be sure.  
   Bash  
   gcloud services enable aiplatform.googleapis.com run.googleapis.com

---

### **✅ Final Checklist**

Before the hackathon begins, please make sure you have completed the following:

* \[ \] **Git**, **Python 3.10+**, **Node.js 20+**, and the **Google Cloud CLI** are installed.  
* \[ \] The **Gemini CLI** (@google/gemini-cli) and **uv** are installed.  
* \[ \] The four required **Gemini CLI extensions** (adk-docs-ext, gcloud, git, code-review) are installed.

You're all set\! We can't wait to see what you build. 🎉