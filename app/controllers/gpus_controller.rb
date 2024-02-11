class GpusController < ApplicationController
  Listing = Struct.new(:name, :ram, :chip, :condition, :price, :available, :url)

  def index
    @chips = chips
    @gpus = []
    file = File.open "best-buy-gpu-feb-9.json"
    data = JSON.load file
    data.each do |d|
      listing = Listing.new(
        name: d["name"],
        ram: d["details"].find { |h| h["name"] == "GPU Video Memory (RAM)"}&.dig("value")&.split(" ")&.first,
        chip: d["details"].find { |h| h["name"] == "Graphics Processing Unit (GPU)"}&.dig("value"),
        condition: d["condition"],
        price: d["regularPrice"],
        available: d["onlineAvailability"],
        url: d["url"])
      @gpus << listing
    end
  end

  def price_index
    @price_gpus = price_chips
    @gpus = []
    file = File.open "best-buy-gpu-feb-9.json"
    data = JSON.load file
    data.each do |d|
      listing = @gpus.find { |o| o[:chip] == d["details"].find { |h| h["name"] == "Graphics Processing Unit (GPU)"}&.dig("value") }

      if listing
        if d["regularPrice"] < listing[:price]
          listing[:price] = d["regularPrice"] if d["regularPrice"] < listing[:price]
          listing[:url] = d["url"]
        end
      else
        listing = {
          manufacturer: d["details"].find { |h| h["name"] == "GPU Chipset Manufacturer"}&.dig("value"),
          name: d["name"],
          price: d["regularPrice"],
          ram: d["details"].find { |h| h["name"] == "GPU Video Memory (RAM)"}&.dig("value")&.split(" ")&.first,
          chip: d["details"].find { |h| h["name"] == "Graphics Processing Unit (GPU)"}&.dig("value"),
          condition: d["condition"],
          clock: d["details"].find { |h| h["name"] == "GPU Base Clock Frequency"}&.dig("value")&.split(" ")&.first,
          url: d["url"]
        }

        @gpus << listing
      end
    end
  end

  private

  def chips
    [
      "NVIDIA GeForce GT 1030",
      "AMD Radeon RX 580 GTS",
      "NVIDIA GeForce RTX 3060 Ti",
      "NVIDIA GeForce RTX 3060",
      "NVIDIA GeForce RTX 2070 SUPER",
      "AMD Radeon RX 5700 XT",
      "NVIDIA GeForce RTX 2060",
      "NVIDIA GeForce RTX 3080 Ti",
      "NVIDIA GeForce RTX 3070 Ti",
      "AMD Radeon RX 6600",
      "NVIDIA GeForce RTX 3050",
      "AMD Radeon RX 6500 XT",
      "NVIDIA GeForce GTX 1650",
      "AMD Radeon RX 6700 XT",
      "AMD Radeon RX 6650 XT",
      "NVIDIA GeForce GTX 1660 SUPER",
      "NVIDIA GeForce RTX 4080",
      "NVIDIA GeForce RTX 4090",
      "AMD Radeon RX 6700",
      "AMD Radeon RX 6950 XT",
      "NVIDIA GeForce RTX 4070 Ti",
      "AMD Radeon RX 7900 XT",
      "AMD Radeon RX 7900 XTX",
      "NVIDIA GeForce RTX 4070",
      "Intel Arc A750",
      "NVIDIA GeForce RTX 4060 Ti",
      "AMD Radeon RX 7600M",
      "AMD Radeon RX 7600",
      "NVIDIA GeForce RTX 4060",
      "AMD Radeon RX 6800",
      "AMD Radeon RX 7800 XT",
      "AMD Radeon RX 7700 XT",
      "AMD Radeon RX 6750 XT",
      "NVIDIA GeForce RTX 4070 Ti SUPER",
      "NVIDIA GeForce RTX 4080 SUPER",
      "NVIDIA GeForce RTX 4070 SUPER",
      "AMD Radeon RX 7600 XT"]
  end

  def price_chips
    [
      "NVIDIA GeForce RTX 4090",
      "NVIDIA GeForce RTX 4080 SUPER",
      "NVIDIA GeForce RTX 4080",
      "NVIDIA GeForce RTX 4070 Ti SUPER",
      "NVIDIA GeForce RTX 4070 Ti",
      "NVIDIA GeForce RTX 4070 SUPER",
      "NVIDIA GeForce RTX 4070",
      "NVIDIA GeForce RTX 4060 Ti",
      "NVIDIA GeForce RTX 4060",
      "NVIDIA GeForce RTX 3080 Ti",
      "NVIDIA GeForce RTX 3070 Ti",
      "NVIDIA GeForce RTX 3060 Ti",
      "NVIDIA GeForce RTX 3060",
      "NVIDIA GeForce RTX 3050",
      "NVIDIA GeForce RTX 2070 SUPER",
      "NVIDIA GeForce RTX 2060",
      "NVIDIA GeForce GTX 1660 SUPER",
      "NVIDIA GeForce GTX 1650",
      "NVIDIA GeForce GT 1030",
      "AMD Radeon RX 7900 XTX",
      "AMD Radeon RX 7900 XT",
      "AMD Radeon RX 7800 XT",
      "AMD Radeon RX 7700 XT",
      "AMD Radeon RX 7600 XT",
      "AMD Radeon RX 7600M",
      "AMD Radeon RX 7600",
      "AMD Radeon RX 6950 XT",
      "AMD Radeon RX 6800",
      "AMD Radeon RX 6750 XT",
      "AMD Radeon RX 6700 XT",
      "AMD Radeon RX 6700",
      "AMD Radeon RX 6650 XT",
      "AMD Radeon RX 6600",
      "AMD Radeon RX 6500 XT",
      "AMD Radeon RX 5700 XT",
      "AMD Radeon RX 580 GTS",
      "Intel Arc A750"
    ]
  end
end


# @gpus = [
#   {
#     price: 1_879_94,
#     ram: 24,
#     condition: "Excellent - Refurbished",
#     chip: "NVIDIA GeForce RTX 4090",
#     title: "Dell Nvidia GeForce RTX 4090 24GB GDDR6X Graphics Card - DPN 0DH84X",
#     url: "https://www.ebay.com/itm/126265558958?hash=item1d660387ae:g:DQoAAOSwMS9llcs0&amdata=enc%3AAQAIAAAA4Ia0ymjRTgTfqhlq3pzmlL28wlUATO%2FvEq4xhs9Dkse30KBZu7gEupDIMY%2B1IAeqpHrm7P5mle36KkFsro1yk8Gs6BQJMIONrqnr1h67Hskt9O%2B8rFreq8sAlcmxqJdIMWguGJaXU8IiBq%2F2ahq%2BurwYOGEQ9NFqCwQu3lSUgHQ2vBnnu47dzGm%2F%2BM6CsZqmswagrSXIf%2FPGSQ7XS6ehMgKn3RAgw%2BJNXUp016hKoBuQFtA%2FXA5qv4KYw1DJX6e3MYGFzbySEmwUPfyLvZafetX3N07RoKY9aPAzgumoilpa%7Ctkp%3ABFBM5r_CyrBj"
#   },
#   {
#     price: 200_00,
#     ram: 12,
#     condition: "Used",
#     chip: "NVIDIA GeForce RTX 3060",
#     title: "ASUS Pheonix NVIDIA GeForce RTX 3060 12GB GDDR6 Video Card (PH-RTX3060-12G-V2)",
#     url: "https://www.ebay.com/itm/395187093581?epid=9053295159&hash=item5c02fc804d:g:nK8AAOSwos5lw-Rv&amdata=enc%3AAQAIAAAA4CmqCEdgQCv2aWapuD%2FguEfVuDduKv7sXNfPghEiMBZc%2BJ6Boobxqidhvr54697ghNFMpNnaNI4zCq5GIzMvm062Y0qde4bX28e%2B2wn%2BYQbOEGEpK0cKMlVQdvPHM%2BCCAOqApnY9zTaUeQzrlnLB%2Foxw1UV06SBH9bWpel%2BVGnu3541Rd59mBXNl2qYouZ662kRSYd9MlWFI0gAew2U3X1WLSdA69d8HU%2BiJBs6hNHcbuniykOH1bSNFBvPc5AArIz1FuR6i4P952w1YSNPnDlFq3elVgnpqKG%2BhwEtZcHwb%7Ctkp%3ABFBM4KSt6bBj"
#   },
#   {
#     price: 949_99,
#     ram: 16,
#     condition: "Used",
#     chip: "NVIDIA GeForce RTX 4080",
#     title: "ASUS GeForce RTX 4080 16G GDDR6X Graphics Card (TUF-RTX4080-16G-GAMING) - Tested",
#     url: "https://www.ebay.com/itm/325613512738?epid=2328753638&hash=item4bd013e822:g:KwkAAOSwOQNkNaem&amdata=enc%3AAQAIAAAA4If7z6KKAOCbTVyVpFtYcqdx6JieU7sF99PPlDo2a6n8oqMQMYxqXRSx%2B8ApSOFQyJWwfnDjHWoHD8QfOnm4wK%2F5n0xHl2Om9tI2TniD%2FVhAD1ZlxwK4vfB%2Bb01a5NVWKqGqPkY6cAR6m3Z%2FUW1jwURAuvWs3ZtjIUxd9nviE5z18x14FAxEHxQE0DiaQ4ODyCRyvvQbgc%2F%2FGfr55u3XB%2FVfLLJbgZqXiE8FTx7w0gO50aIZCAIZ0%2B%2BnfdGvUJIqGfLujZkZTBezHnrOsmVd5kOqO8EKt3CR1x56Pwx4OL1q%7Ctkp%3ABFBM4KSt6bBj",
#   }
# ]