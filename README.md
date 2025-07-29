# VID profesiju atalgojuma dati

Šis repozitorijs satur R skriptus, kas automātiski lejupielādē, apvieno un apstrādā Latvijas Valsts ieņēmumu dienesta (VID) publicētos datus par profesiju atalgojumu.

Projekta mērķis ir izveidot vienotu, sakārtotu un analīzei gatavu datu kopu par profesiju atalgojumu Latvijā, apvienojot datus no vairākiem gadiem vienā failā. Gala rezultāts ir Excel `.xlsx` fails, kas ir gatavs tālākai analīzei, piemēram, veidojot `Pivot` tabulas vai izmantojot citos datu projektos.

## Datu avots

Dati tiek iegūti no VID publiski pieejamās informācijas par vidējo darba samaksu profesiju pamatgrupās. Pieejami VID tīmekļa vietnē lapā [Profesiju atalgojums
](https://www.vid.gov.lv/lv/profesiju-atalgojums)

## Repozitorija struktūra

  - `01_get_data.R`: Šis R skripts lejupielādē datus no VID mājaslapas saitēm, kas norādītas `all_links` sarakstā. Tas apvieno visus mēnešu datus vienā datu freimā un saglabā to `data/vid_data.rds` failā.
  - `02_transform_data.R`: Šis skripts ielasa `vid_data.rds` failu, veic datu tīrīšanu un transformāciju:
      - Pārsauc kolonnas, lai tās būtu vieglāk lasāmas un saprotamas.
      - No profesijas nosaukuma izdala profesijas kodu un pašu nosaukumu atsevišķās kolonnās.
      - Pievieno datumus, lai dati būtu viegli filtrējami pa laika periodiem.
      - Apstrādātie dati tiek saglabāti `data/processed_vid_data.xlsx` failā.
  - `data/`: Mape, kurā tiek glabāti izejas faili.
      - `vid_data.rds`: Neapstrādāti, apvienoti dati no visiem periodiem (R specifisks formāts).
      - `processed_vid_data.xlsx`: Apstrādāti, analīzei gatavi dati Excel formātā.

## Kā lietot

Lai palaistu skriptus un iegūtu datus, sekojiet šiem soļiem:

### 1\. Priekšnosacījumi

Pārliecinieties, ka jums ir uzstādīts R un sekojošas R pakotnes: `tidyverse`, `readxl`, `janitor`, `writexl`.

Ja kāda no pakotnēm trūkst, jūs varat tās uzstādīt, palaižot šo komandu R konsolē:

```r
install.packages(c("tidyverse", "readxl", "janitor", "writexl"))
```

### 2\. Darbības

1.  Noklonējiet šo repozitoriju savā datorā.
2.  Atveriet R vai RStudio.
3.  Palaidiet skriptu `01_get_data.R`. Tas var aizņemt kādu laiku, jo tiek lejupielādēti vairāki faili. Pēc tā izpildes `data` mapē parādīsies `vid_data.rds` fails.
4.  Palaidiet skriptu `02_transform_data.R`. Tas apstrādās datus un saglabās gala rezultātu.
5.  Gatavais fails analīzei būs pieejams `data/processed_vid_data.xlsx`.

## Izejas faila apraksts (`processed_vid_data.xlsx`)

Apstrādātais fails satur sekojošas kolonnas:

| Kolonnas nosaukums        | Apraksts                                                                                                                |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `profesijas_kods`         | Profesijas kods saskaņā ar Profesiju klasifikatoru.                                                                     |
| `profesijas_koda_garums`  | Profesijas koda zīmju skaits (var izmantot profesiju hierarhijas līmeņa noteikšanai).                                     |
| `profesija`               | Profesijas nosaukums.                                                                                                   |
| `nostradatas_stundas`     | Kopējais nostrādāto stundu skaits profesijā attiecīgajā mēnesī.                                                           |
| `videji_stundas_menesi`   | Vidējais darba stundu skaits mēnesī vienai darba vietai.                                                                  |
| `ienakumi_kopa`           | Ienākumi kopā (EUR) profesijā.                                                                                          |
| `videja_likme_stundai`    | Vidējā stundas tarifa likme (EUR).                                                                                      |
| `valsts_likmes_80_proc`   | 80% no vidējās stundas tarifa likmes valstī (EUR).                                                                        |
| `darba_vietu_skaits`      | Darba vietu skaits profesijā.                                                                                           |
| `ipatsvars_zem_80_proc`   | Darba vietu īpatsvars (%), kurās vidējā stundas tarifa likme ir mazāka par 80% no vidējās likmes valstī.                  |
| `datu_menesis`            | Mēnesis (datuma formātā), par kuru dati ir apkopoti.                                                                     |
| `dati_uz`                 | Datums, uz kuru dati ir aktuāli (nolasīts no oriģinālā Excel faila).                                                      |

## Papildināšana

VID regulāri publicē jaunus datus. Lai atjauninātu datu kopu ar jaunākajiem mēnešiem, `01_get_data.R` failā ir jāpapildina `all_links` saraksts ar jaunajām saitēm uz Excel failiem un jānorāda attiecīgais gads un mēnesis. Pēc tam atkārtoti jāpalaiž abi skripti.
