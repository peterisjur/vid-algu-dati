library(tidyverse)
library(writexl)

combined_data <- readRDS("data/vid_data.rds")


data_processed <- combined_data %>%
  rename(
    profesija = profesiju_klasifikators,
    videji_stundas_menesi = videjais_darba_stundu_skaits_menesi_vienai_darba_vietai,
    ienakumi_kopa = ienakumi_kopa_eur,
    videja_likme_stundai = videja_stundas_tarifa_likme_eur,
    valsts_likmes_80_proc = x80_percent_no_videjas_stundas_tarifa_likmes_valsti_eur,
    ipatsvars_zem_80_proc = darba_vietu_kuras_videja_stundas_tarifa_likme_ir_mazaka_par_80_percent_no_videjas_stundas_tarifa_likmes_valsti_ipatsvars_percent,
    datu_menesis = date
  ) %>%
  mutate(
    dati_uz = as.Date(str_extract(value_from_A2, "\\d{2}\\.\\d{2}\\.\\d{4}"), format = "%d.%m.%Y")
  ) %>%
  mutate(
    profesijas_kods = str_extract(profesija, "^\\d+"),
    profesijas_koda_garums = nchar(profesijas_kods)
  )%>%
  mutate(
    profesija = str_remove(profesija, "^\\d+\\s")
  )%>%
  select(
    profesijas_kods,
    profesijas_koda_garums,
    profesija,
    nostradatas_stundas,
    videji_stundas_menesi,
    ienakumi_kopa,
    videja_likme_stundai,
    valsts_likmes_80_proc,
    darba_vietu_skaits,
    ipatsvars_zem_80_proc,
    datu_menesis,
    dati_uz
  )

# save data to xlsx file
write_xlsx(data_processed, "data/processed_vid_data.xlsx")


