" AI-VIM setup
" Local LLM
" let s:model = 'bartowski/Phi-3.1-mini-4k-instruct-GGUF'
" let s:endpoint_url = 'http://localhost:1234/v1/chat/completions'
"
" OpenAI
let s:model = 'gpt-4o-mini'
let s:endpoint_url = 'https://api.openai.com/v1/chat/completions'

" :AI
" - engine: complete | chat - see how to configure chat engine in the section below
" - options: openai config (see https://platform.openai.com/docs/api-reference/completions)
" - options.request_timeout: request timeout in seconds
" - options.enable_auth: enable authorization using openai key
" - options.selection_boundary: seleciton prompt wrapper (eliminates empty responses, see #20)
" - ui.paste_mode: use paste mode (see more info in the Notes below)

" :AIEdit
" - engine: complete | chat - see how to configure chat engine in the section below
" - options: openai config (see https://platform.openai.com/docs/api-reference/completions)
" - options.request_timeout: request timeout in seconds
" - options.enable_auth: enable authorization using openai key
" - options.selection_boundary: seleciton prompt wrapper (eliminates empty responses, see #20)
" - ui.paste_mode: use paste mode (see more info in the Notes below)

" :AIChat
" - options: openai config (see https://platform.openai.com/docs/api-reference/chat)
" - options.initial_prompt: prompt prepended to every chat request (list of lines or string)
" - options.request_timeout: request timeout in seconds
" - options.enable_auth: enable authorization using openai key
" - options.selection_boundary: seleciton prompt wrapper (eliminates empty responses, see #20)
" - ui.populate_options: put [chat-options] to the chat header
" - ui.open_chat_command: preset (preset_below, preset_tab, preset_right) or a custom command
" - ui.scratch_buffer_keep_open: re-use scratch buffer within the vim session
" - ui.paste_mode: use paste mode (see more info in the Notes below)

" This prompt instructs model to work with syntax highlighting
let s:initial_chat_prompt =<< trim END
>>> system

You are a general assistant.
If you attach a code block add syntax type after ``` to enable syntax highlighting.
END

let g:vim_ai_chat = {
\  "options": {
\    "model": s:model,
\    "endpoint_url": s:endpoint_url,
\    "max_tokens": 0,
\    "temperature": 1,
\    "request_timeout": 20,
\    "enable_auth": 1,
\    "selection_boundary": "",
\    "initial_prompt": s:initial_chat_prompt,
\  },
\  "ui": {
\    "code_syntax_enabled": 1,
\    "populate_options": 0,
\    "open_chat_command": "preset_below",
\    "scratch_buffer_keep_open": 0,
\    "paste_mode": 1,
\  },
\}

" Notes:
" ui.paste_mode
" - if disabled code indentation will work but AI doesn't always respond with a code block
"   therefore it could be messed up
" - find out more in vim's help `:help paste`
" options.max_tokens
" - note that prompt + max_tokens must be less than model's token limit, see #42, #46
" - setting max tokens to 0 will exclude it from the OpenAI API request parameters, it is
"   unclear/undocumented what it exactly does, but it seems to resolve issues when the model
"   hits token limit, which respond with `OpenAI: HTTPError 400`


let initial_prompt =<< trim END
>>> system

You are going to play a role of a completion engine with following parameters:
Task: Provide compact code/text completion, generation, transformation or explanation
Topic: general programming and text editing
Style: Plain result without any commentary, unless commentary is necessary. Skip using markdown formatting in the reply
Audience: Users of text editor and programmers that need to transform/generate text
END

let chat_engine_config = {
\  "engine": "chat",
\  "options": {
\    "endpoint_url": s:endpoint_url,
\    "model": s:model,
\    "max_tokens": 1000,
\    "temperature": 0.1,
\    "request_timeout": 20,
\    "selection_boundary": "",
\    "initial_prompt": initial_prompt,
\  },
\}

let g:vim_ai_complete = chat_engine_config
let g:vim_ai_edit = chat_engine_config
let g:vim_ai_chat = {
\  "options": {
\    "model": s:model,
\    "endpoint_url": s:endpoint_url,
\    "temperature": 0.5,
\    "max_tokens": 0,
\  },
\  "ui": {
\    "code_syntax_enabled": 1,
\    "populate_options": 0,
\    "open_chat_command": "preset_below",
\    "scratch_buffer_keep_open": 0,
\    "paste_mode": 1,
\  },
\}


" Map <leader>ai to trigger AI command silently
noremap <silent> <leader>ai :AI<CR>

" Map <leader>ae to trigger AIEdit command silently
noremap <silent> <leader>ae :AIEdit<CR>

" Map <leader>ac to trigger AIChat command silently
noremap <silent> <leader>ac :AIChat<CR>


