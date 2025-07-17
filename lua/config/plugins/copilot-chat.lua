local prompts = {
  Explain = 'Please explain how the following code works.',
  Tests = 'Please explain how the selected code works, then generate unit tests for it.',
  Refactor = 'Please refactor the following code to improve its clarity and readability.',
  FixCode = 'Please fix the following code to make it work as intended.',
  FixError = 'Please explain the error in the following text and provide a solution.',
  BetterNamings = 'Please provide better names for the following variables and functions.',
  Documentation = 'Please provide documentation for the following code.',
}

-- Add AI integration with Copilot
return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' },
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    opts = {
      model = 'claude-3.7-sonnet-thought',
      prompts = prompts,
    },
    keys = {
      { '<leader>ct', '<cmd>CopilotChatToggle<cr>', desc = '[C]opilot [T]oggle' },
      { '<leader>cs', '<cmd>CopilotChatModels<cr>', desc = '[C]opilot [S]elect model' },
      { '<leader>cc', '<cmd>CopilotChatReset<cr>', desc = '[C]opilot [C]lear chat' },
      { '<leader>ce', '<cmd>CopilotChatExplain<cr>', desc = '[C]opilot [E]xplain code' },
      { '<leader>cg', '<cmd>CopilotChatTests<cr>', desc = '[C]opilot [G]enerate tests' },
      { '<leader>cr', '<cmd>CopilotChatRefactor<cr>', desc = '[C]opilot [R]efactor code' },
      { '<leader>cn', '<cmd>CopilotChatBetterNamings<cr>', desc = '[C]opilot Better [N]aming' },
      { '<leader>cf', '<cmd>CopilotChatFixError<cr>', desc = '[C]opilot [F]ix diagnostic' },
      { '<leader>cd', '<cmd>CopilotChatDocumentation<cr>', desc = '[C]opilot [D]ocument code' },
      { '<leader>cz', '<cmd>CopilotChatFixCode<cr>', desc = '[C]opilot fix code' },
    },
  },
}
