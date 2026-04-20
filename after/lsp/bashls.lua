return {
  settings = {
    bashIde = {
      -- Script içindeki tüm dosyaları (source edilenler dahil) tarar
      globPattern = "*@(.sh|.inc|.bash|.command)",
      -- ShellCheck desteğini aktif eder
      shellcheckPath = "shellcheck",
      shellcheckArguments = {},
    },
  },
  filetypes = { "sh", "bash", "zsh" }, -- Zsh dosyalarında da temel destek sağlar
}
