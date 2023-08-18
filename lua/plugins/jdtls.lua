return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mfussenegger/nvim-jdtls" },
    opts = {
      setup = {
        jdtls = function(_, _)
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
              local home = os.getenv("HOME")
              local java_home = os.getenv("JAVA_HOME")
              local jdtls = require("jdtls")
              local root_markers = { "gradlew", "mvnw", ".git" }
              local root_dir = require("jdtls.setup").find_root(root_markers)
              local mason_pkgs = vim.fn.stdpath('data') .. "/mason/packages"
              local workspace_folder = home .. "/.nvim-workspace-root/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
              local bundles = {
                vim.fn.glob(mason_pkgs .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
              }
              vim.list_extend(bundles, vim.split(vim.fn.glob(mason_pkgs .. "/java-test/extension/server/*.jar"), "\n"))

              local on_attach = function(client, bufnr)
                jdtls.setup_dap({ hotcodereplace = "auto" })
                jdtls.setup.add_commands()

                -- Default keymaps
                local function map(mode, l, r, desc)
                  vim.keymap.set(mode, l, r, { silent = true, buffer = bufnr, desc = desc })
                end
                map("n", "<leader>co", jdtls.organize_imports, "Organize Imports")
                map("n", "<leader>ctc", jdtls.test_class, "Test Class [Dap]")
                map("n", "<leader>ctm", jdtls.test_nearest_method, "Test Nearest Method [Dap]")

                require("lsp.defaults").on_attach(client, bufnr)
              end

              local config = {
                flags = {
                  debounce_text_changes = 80,
                },
                capabilities = require("cmp_nvim_lsp").default_capabilities(
                  vim.lsp.protocol.make_client_capabilities()
                ),
                on_attach = on_attach,
                init_options = {
                  bundles = bundles,
                },
                root_dir = root_dir,
                settings = {
                  java = {
                    format = {
                      settings = {
                        url = mason_pkgs .. "/jdtls/eclipse-formatter.xml",
                        profile = "GoogleStyle",
                      },
                    },
                    signatureHelp = { enabled = true },
                    contentProvider = { preferred = "fernflower" },
                    completion = {
                      favoriteStaticMembers = {
                        "org.hamcrest.MatcherAssert.assertThat",
                        "org.hamcrest.Matchers.*",
                        "org.hamcrest.CoreMatchers.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                        "org.mockito.Mockito.*",
                      },
                      filteredTypes = {
                        "com.sun.*",
                        "io.micrometer.shaded.*",
                        "java.awt.*",
                        "jdk.*",
                        "sun.*",
                      },
                    },
                    sources = {
                      organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                      },
                    },
                    codeGeneration = {
                      toString = {
                        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                      },
                      hashCodeEquals = {
                        useJava7Objects = true,
                      },
                      useBlocks = true,
                    },
                    configuration = {
                      runtimes = {
                        { name = "JavaSE-17", path = java_home },
                      },
                    },
                  },
                },
                cmd = {
                  java_home .. "/bin/java",
                  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                  "-Declipse.product=org.eclipse.jdt.ls.core.product",
                  "-Dosgi.bundles.defaultStartLevel=4",
                  "-Dlog.protocol=true",
                  "-Dlog.level=ALL",
                  "-Xmx2g",
                  "--add-modules=ALL-SYSTEM",
                  "--add-opens=java.base/java.util=ALL-UNNAMED",
                  "--add-opens=java.base/java.lang=ALL-UNNAMED",
                  "-javaagent:" .. mason_pkgs .. "/jdtls/lombok.jar",
                  "-jar",
                  vim.fn.glob(mason_pkgs .. "/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
                  "-configuration",
                  mason_pkgs .. "/jdtls/config_linux",
                  "-data",
                  workspace_folder,
                },
              }
              require("jdtls").start_or_attach(config)
            end,
          })
          return true
        end,
      },
    },
  },
}
