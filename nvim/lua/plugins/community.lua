-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.



---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.nightfox-nvim" },

  { import = "astrocommunity.recipes.neovide" },

  -- LSP
  { import = "astrocommunity.recipes.picker-lsp-mappings" },

  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity.pack.php" },
  { import = "astrocommunity.pack.python" },
  -- { import = "astrocommunity.pack.swift" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.eslint" },

  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.nginx" },
  { import = "astrocommunity.pack.terraform" },

  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.proto" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.xml" },
  { import = "astrocommunity.pack.yaml" },

  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.vue" },

  
  -- Utils

  { import = "astrocommunity.git.neogit" },

  { import = "astrocommunity.split-and-window.windows-nvim" },
  { import = "astrocommunity.split-and-window.colorful-winsep-nvim" },

  { import = "astrocommunity.docker.lazydocker" },
  { import = "astrocommunity.git.gitgraph-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },


}

