return {
  settings = {
    yaml = {
      -- Dahili şema deposunu kapatıyoruz, SchemaStore.nvim kullanacağız
      schemaStore = {
        enable = false,
        url = "",
      },
      -- SchemaStore.nvim üzerinden güncel şemaları çekiyoruz
      schemas = require('schemastore').yaml.schemas(),
      
      -- Performans ve Doğrulama Ayarları
      format = { enable = true },
      validate = true,
      completion = true,
      
      -- Kubernetes veya büyük CloudFormation dosyaları için bellek sınırı
      maxItemsComputed = 10000,
    },
  },
}
