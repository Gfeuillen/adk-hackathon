# **Gemini Hackathon Guide**

This guide will walk you through creating, deploying, and registering your first agent using the Gemini CLI and the Agent Starter Pack. The CLI is an interactive AI agent, so you will be giving it instructions in plain English.

### **Step 1: Create Your Agent**

**Note on Authentication:** If you encounter an authentication error, you may need to re-authenticate with Google Cloud. Run the following command in your terminal, which will open a browser window for you to log in:

```bash
gcloud auth application-default login
```

Please run the following command in your terminal to create the agent. I will wait for you to confirm that the command has been successfully executed inside the newly created directory.

```bash
uvx agent-starter-pack create <YOUR_AGENT_NAME> --region eu-west4
```

Replace `<YOUR_AGENT_NAME>` with a name for your agent. The agent name should not contain spaces or special characters.

Once the command is complete, please tell me so I can proceed with the next steps.

### **Step 2: Define Your Agent's Capabilities**

Once you confirm that the agent has been created, I will look for the agent's directory in your project. After I locate the directory, I will ask you a few questions to understand what you want your agent to be able to do. This will help me to customize the agent's tools and instructions to meet your requirements.

I will then propose a plan to implement the required changes. We will iterate on this plan until you are satisfied with the result.

### **Step 3: Deploy Your Agent to Google Cloud**

Once you're happy with your agent, you can deploy it directly to Google Cloud Run, a fully managed serverless platform. The Agent Starter Pack provides infrastructure for this.

*(This will be the next step after creating and customizing the agent)*

### **Step 4: Get Your Deployment ID**

Next, you need a unique ID for your deployed agent to register it in Agentspace. We will use the gcloud CLI for this.

**Open a new terminal window** (do not close your Gemini CLI session) and run the following command:

```bash
gcloud vertex ai reasoning-engines list
```

Look for the RESOURCE_NAME of the agent you just deployed. The long number at the very end is your **engine_deployment_id**.

Example:
projects/your-project/locations/us-central1/reasoningEngines/825011952831955555
Copy the ID 825011952831955555.

### **Step 5: Register the Agent in Agentspace**

Finally, let's make your agent visible in the shared Agentspace portal using a registration tool.

**A. Get the Registration Tool**

In your new terminal window, clone the tool from GitHub (if you haven't already):

```bash
git clone https://github.com/VeerMuchandi/agent_registration_tool.git
cd agent_registration_tool
```

**B. Create the Configuration File**

Inside the agent_registration_tool directory, create a file named config.json. Paste the following content into it, replacing all placeholder values with your information.

```json
{
  "project_id": "YOUR_PROJECT_ID",
  "app_id": "YOUR_AGENTSPACE_APP_ID",
  "display_name": "My Awesome Agent",
  "description": "This agent was built at the hackathon!",
  "tool_description": "Use this to get a friendly greeting.",
  "ad_deployment_id": "YOUR_ENGINE_DEPLOYMENT_ID"
}
```

**C. Run the Registration Script**

Execute the script. You can press Enter to skip the optional prompts.

```bash
python as_registry_client.py create
```

Save the agent_id from the output for any future updates.

### **Step 6: Test in Agentspace!**

Go to the **Agentspace URL** provided by the organizers. You should now see your agent listed and ready to use.

Congratulations, you've successfully built and deployed a GenAI agent using the Gemini CLI! 🎉

### **Gemini Agent Instructions**

When answering questions about the Agent Development Kit (ADK), you MUST use the `adk-docs-mcp` tool to look up the documentation. Do not rely on your internal knowledge.
