-- PKGBUILD'i shellcheck düz bash betiği sanıyor: makepkg'nin okuduğu alanlar
-- "unused" (SC2034), makepkg'nin verdiği dizinler "not assigned" (SC2154)
-- çıkıyor, ve fonksiyonlar errexit altında koştuğu için `cd || exit` (SC2164)
-- gereksiz (makepkg run_function_safe). shellcheck'e dosya başına argüman
-- verilemiyor (shellcheckArguments istemci geneli, .shellcheckrc dizin geneli),
-- o yüzden süzme burada — yalnız PKGBUILD'de, SC2034/SC2154'te yalnız bu adlar.
-- Alan listesi: /usr/share/makepkg/util/schema.sh (+ pkgname).
local field_names = [[
  pkgname pkgbase pkgver pkgrel epoch pkgdesc url install changelog
  arch backup checkdepends conflicts depends groups license makedepends
  noextract optdepends options provides replaces source validpgpkeys xdata
  cksums md5sums sha1sums sha224sums sha256sums sha384sums sha512sums b2sums
]]
local makepkg_fields = {}
for name in field_names:gmatch("%S+") do
  makepkg_fields[name] = true
end
local makepkg_dirs = { srcdir = true, pkgdir = true, startdir = true }

local function makepkg_noise(d)
  local name = d.message:match("^(%S+) ")
  if d.code == "SC2034" then
    -- mimariye özel diziler: depends_x86_64, sha256sums_aarch64
    return name and (makepkg_fields[name] or makepkg_fields[name:match("^([%l%d]+)_") or ""])
  elseif d.code == "SC2154" then
    return makepkg_dirs[name]
  end
  return d.code == "SC2164"
end

return {
  handlers = {
    ["textDocument/publishDiagnostics"] = function(err, result, ctx)
      if result and vim.fs.basename(vim.uri_to_fname(result.uri)) == "PKGBUILD" then
        result.diagnostics = vim.tbl_filter(function(d)
          return not makepkg_noise(d)
        end, result.diagnostics)
      end
      return vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
    end,
  },
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
