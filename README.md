# root-aio

Alunperin HTC:n Desire -puhelimelle koodattu AllInOne-ratkaisu nopeuttamaan romipäivityksen jälkeisiä toimenpiteitä. 
Varsinaisina ominaisuuksina:

- Low-level eli välitön sammutus sekä uudelleenkäynnistys normaalisti, palautustilaan ja käynnistyslataajaan
- EFS-osion varmuuskopiointi ja palautus (=puhelimen IMEI:n turvaaminen)
- Akkutietojen tyhjentäminen
- Logcat -lokin dumppaaminen
- Dalvik-välimuistin tyhjentäminen
- Käynnistysanimaation disablointi/enablointi
- Kameran suljinäänen disablointi/enablointi
- Sovellusten luku-/kirjoituslupien korjaus

Ja under the hood:
- Root-oikeuksien tarkistus
- Busyboxin binäärien olemassaolon tarkistus