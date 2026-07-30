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
  -- zsh BİLEREK yok: bashls shellcheck'i çağırıyor, shellcheck ise zsh
  -- desteklemiyor ("Unknown shell: zsh"). Zsh dosyaları eklenirse geçerli kod
  -- (${(s.:.)VAR}, _comps[...], zstyle '...$realpath') hata olarak işaretlenir.
  filetypes = { "sh", "bash" },
}
