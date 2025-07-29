library(tidyverse)
library(readxl)
library(janitor)


all_links <- list(
  vid_2025_01 = list(link = "https://www.vid.gov.lv/lv/media/29444/download?attachment", month = 1, year = 2025),
  vid_2025_02 = list(link = "https://www.vid.gov.lv/lv/media/29765/download?attachment", month = 2, year = 2025),
  vid_2025_03 = list(link = "https://www.vid.gov.lv/lv/media/30168/download?attachment", month = 3, year = 2025),
  vid_2025_04 = list(link = "https://www.vid.gov.lv/lv/media/30624/download?attachment", month = 4, year = 2025),
  vid_2025_05 = list(link = "https://www.vid.gov.lv/lv/media/30824/download?attachment", month = 5, year = 2025),
  vid_2024_01 = list(link = "https://www.vid.gov.lv/lv/media/22569/download?attachment", month = 1, year = 2024),
  vid_2024_02 = list(link = "https://www.vid.gov.lv/lv/media/23166/download?attachment", month = 2, year = 2024),
  vid_2024_03 = list(link = "https://www.vid.gov.lv/lv/media/23658/download?attachment", month = 3, year = 2024),
  vid_2024_04 = list(link = "https://www.vid.gov.lv/lv/media/24285/download?attachment", month = 4, year = 2024),
  vid_2024_05 = list(link = "https://www.vid.gov.lv/lv/media/24960/download?attachment", month = 5, year = 2024),
  vid_2024_06 = list(link = "https://www.vid.gov.lv/lv/media/25752/download?attachment", month = 6, year = 2024),
  vid_2024_07 = list(link = "https://www.vid.gov.lv/lv/media/26109/download?attachment", month = 7, year = 2024),
  vid_2024_08 = list(link = "https://www.vid.gov.lv/lv/media/26781/download?attachment", month = 8, year = 2024),
  vid_2024_09 = list(link = "https://www.vid.gov.lv/lv/media/27549/download?attachment", month = 9, year = 2024),
  vid_2024_10 = list(link = "https://www.vid.gov.lv/lv/media/27967/download?attachment", month = 10, year = 2024),
  vid_2024_11 = list(link = "https://www.vid.gov.lv/lv/media/28365/download?attachment", month = 11, year = 2024),
  vid_2024_12 = list(link = "https://www.vid.gov.lv/lv/media/28782/download?attachment", month = 12, year = 2024),
  vid_2023_01 = list(link = "https://www.vid.gov.lv/lv/media/16000/download?attachment", month = 1, year = 2023),
  vid_2023_02 = list(link = "https://www.vid.gov.lv/lv/media/16230/download?attachment", month = 2, year = 2023),
  vid_2023_03 = list(link = "https://www.vid.gov.lv/lv/media/16548/download?attachment", month = 3, year = 2023),
  vid_2023_04 = list(link = "https://www.vid.gov.lv/lv/media/17226/download?attachment", month = 4, year = 2023),
  vid_2023_05 = list(link = "https://www.vid.gov.lv/lv/media/17565/download?attachment", month = 5, year = 2023),
  vid_2023_06 = list(link = "https://www.vid.gov.lv/lv/media/18168/download?attachment", month = 6, year = 2023),
  vid_2023_07 = list(link = "https://www.vid.gov.lv/lv/media/18837/download?attachment", month = 7, year = 2023),
  vid_2023_08 = list(link = "https://www.vid.gov.lv/lv/media/19491/download?attachment", month = 8, year = 2023),
  vid_2023_09 = list(link = "https://www.vid.gov.lv/lv/media/20331/download?attachment", month = 9, year = 2023),
  vid_2023_10 = list(link = "https://www.vid.gov.lv/lv/media/20736/download?attachment", month = 10, year = 2023),
  vid_2023_11 = list(link = "https://www.vid.gov.lv/lv/media/21408/download?attachment", month = 11, year = 2023),
  vid_2023_12 = list(link = "https://www.vid.gov.lv/lv/media/22077/download?attachment", month = 12, year = 2023),
  vid_2022_01 = list(link = "https://www.vid.gov.lv/lv/media/4404/download?attachment", month = 1, year = 2022),
  vid_2022_02 = list(link = "https://www.vid.gov.lv/lv/media/4407/download?attachment", month = 2, year = 2022),
  vid_2022_03 = list(link = "https://www.vid.gov.lv/lv/media/4410/download?attachment", month = 3, year = 2022),
  vid_2022_04 = list(link = "https://www.vid.gov.lv/lv/media/4413/download?attachment", month = 4, year = 2022),
  vid_2022_05 = list(link = "https://www.vid.gov.lv/lv/media/4416/download?attachment", month = 5, year = 2022),
  vid_2022_06 = list(link = "https://www.vid.gov.lv/lv/media/4419/download?attachment", month = 6, year = 2022),
  vid_2022_07 = list(link = "https://www.vid.gov.lv/lv/media/4422/download?attachment", month = 7, year = 2022),
  vid_2022_08 = list(link = "https://www.vid.gov.lv/lv/media/4425/download?attachment", month = 8, year = 2022),
  vid_2022_09 = list(link = "https://www.vid.gov.lv/lv/media/4428/download?attachment", month = 9, year = 2022),
  vid_2022_10 = list(link = "https://www.vid.gov.lv/lv/media/10704/download?attachment", month = 10, year = 2022),
  vid_2022_11 = list(link = "https://www.vid.gov.lv/lv/media/14478/download?attachment", month = 11, year = 2022),
  vid_2022_12 = list(link = "https://www.vid.gov.lv/lv/media/15543/download?attachment", month = 12, year = 2022),
  vid_2021_01 = list(link = "https://www.vid.gov.lv/lv/media/4431/download?attachment", month = 1, year = 2021),
  vid_2021_02 = list(link = "https://www.vid.gov.lv/lv/media/4434/download?attachment", month = 2, year = 2021),
  vid_2021_03 = list(link = "https://www.vid.gov.lv/lv/media/4437/download?attachment", month = 3, year = 2021),
  vid_2021_04 = list(link = "https://www.vid.gov.lv/lv/media/4440/download?attachment", month = 4, year = 2021),
  vid_2021_05 = list(link = "https://www.vid.gov.lv/lv/media/4443/download?attachment", month = 5, year = 2021),
  vid_2021_06 = list(link = "https://www.vid.gov.lv/lv/media/4446/download?attachment", month = 6, year = 2021),
  vid_2021_07 = list(link = "https://www.vid.gov.lv/lv/media/4449/download?attachment", month = 7, year = 2021),
  vid_2021_08 = list(link = "https://www.vid.gov.lv/lv/media/4452/download?attachment", month = 8, year = 2021),
  vid_2021_09 = list(link = "https://www.vid.gov.lv/lv/media/4455/download?attachment", month = 9, year = 2021),
  vid_2021_10 = list(link = "https://www.vid.gov.lv/lv/media/4458/download?attachment", month = 10, year = 2021),
  vid_2021_11 = list(link = "https://www.vid.gov.lv/lv/media/4461/download?attachment", month = 11, year = 2021),
  vid_2021_12 = list(link = "https://www.vid.gov.lv/lv/media/15057/download?attachment", month = 12, year = 2021),
  vid_2020_01 = list(link = "https://www.vid.gov.lv/lv/media/4500/download?attachment", month = 1, year = 2020),
  vid_2020_02 = list(link = "https://www.vid.gov.lv/lv/media/4497/download?attachment", month = 2, year = 2020),
  vid_2020_03 = list(link = "https://www.vid.gov.lv/lv/media/4494/download?attachment", month = 3, year = 2020),
  vid_2020_04 = list(link = "https://www.vid.gov.lv/lv/media/4491/download?attachment", month = 4, year = 2020),
  vid_2020_05 = list(link = "https://www.vid.gov.lv/lv/media/4488/download?attachment", month = 5, year = 2020),
  vid_2020_06 = list(link = "https://www.vid.gov.lv/lv/media/4485/download?attachment", month = 6, year = 2020),
  vid_2020_07 = list(link = "https://www.vid.gov.lv/lv/media/4482/download?attachment", month = 7, year = 2020),
  vid_2020_08 = list(link = "https://www.vid.gov.lv/lv/media/4479/download?attachment", month = 8, year = 2020),
  vid_2020_09 = list(link = "https://www.vid.gov.lv/lv/media/4476/download?attachment", month = 9, year = 2020),
  vid_2020_10 = list(link = "https://www.vid.gov.lv/lv/media/4473/download?attachment", month = 10, year = 2020),
  vid_2020_11 = list(link = "https://www.vid.gov.lv/lv/media/4470/download?attachment", month = 11, year = 2020),
  vid_2020_12 = list(link = "https://www.vid.gov.lv/lv/media/4467/download?attachment", month = 12, year = 2020)
)


process_excel_data <- function(link_info) {
  temp_file <- tempfile(fileext = ".xlsx")
  download.file(link_info$link, temp_file, mode = "wb", quiet = TRUE) 
  
  # Read cell A2
  value_a2 <- read_excel(temp_file, range = "A2", col_names = FALSE) %>%
    pull(1)
  
  # Read data, skipping 2 rows to get headers from row 3
  data <- read_excel(temp_file, skip = 2) %>%
    clean_names() %>%
    mutate(
      date = as.Date(paste0(link_info$year, "-", link_info$month, "-01")),
      value_from_A2 = value_a2
    )
  

  unlink(temp_file)
  
  return(data)
}


all_data_list <- map(all_links, process_excel_data)


combined_data <- bind_rows(all_data_list)

# Save data as RDS to data folder
write_rds(combined_data, "data/vid_data.rds", compress = "gz")


