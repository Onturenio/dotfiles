function ai() {
    # Colors
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    YELLOW='\033[1;33m'
    RED='\033[0;31m'
    NC='\033[0m' # No Color

    # Check if a task was provided
    if [ $# -eq 0 ]; then
        echo -e "${RED}Usage: ai <task description>${NC}"
        echo -e "${BLUE}Example: ai list all PDF files in current directory${NC}"
        return 1
    fi

    # Combine all arguments into a single task description
    task="$*"

    # Show processing message
    echo -e "${BLUE}🤔 Processing request: ${YELLOW}$task${NC}"
    echo

    # Prompt template for the LLM
    prompt="You are a helpful bash command generator. Respond with only the exact command with no prefix, no markdown, no explanation. Task: $task"

    # Call Ollama API and clean the output
    response=$(curl -s http://localhost:11434/api/generate -d "{
      \"model\": \"phi4\",
      \"prompt\": \"$prompt\",
      \"stream\": false
    }" | jq -r '.response' | sed 's/^bash\s*//g' | sed 's/^\`\`\`.*//g' | sed 's/\`\`\`$//g' | tr -d '`' | xargs)

    # Check if we got a response
    if [ -z "$response" ]; then
        echo -e "${RED}Error: Failed to get a response from Ollama${NC}"
        return 1
    fi

    # Print the command with a prompt
    echo -e "${GREEN}💡 Generated command:${NC}"
    echo -e "${YELLOW}$response${NC}"
    echo

    # Ask for confirmation
    echo -e "${BLUE}Do you want to execute this command? (y/N)${NC} "
    read confirm

    if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
        echo -e "${GREEN}🚀 Executing command...${NC}"
        eval "$response"
    else
        echo -e "${YELLOW}⏸️  Command not executed${NC}"
    fi
}

bindkey -s '^g' 'ai '  # Bind Ctrl+G to the ai function
