/*Thesis Data Analysis
Keshav Rastogi
6/7/20
Professor Jim Stock
*/

clear all
capture log close
cd "/Users/Keshav/Desktop/Harvard Senior Year/Thesis/Data Analysis"
log using DataAnalysis.log, replace

*Import and save datasets
import excel using "4Coffshore Stata_v2.xlsx", firstrow sheet("Sheet1")
save 4Coffshore, replace
clear
import excel using "Currency Converter.xlsx", firstrow sheet("2019 USD Conversions")
save Currency_Converter, replace
clear
import excel using "EIU Copper Steel Oil Raw.xlsx", firstrow sheet("Sheet1")
save EIU_Copper_Steel_Oil, replace
clear
import excel using "EIU Wages Raw.xlsx", firstrow sheet("Sheet1")
save EIU_Wages, replace
clear
import excel using "FRED Cement Raw.xlsx", firstrow sheet("Sheet1")
save FRED_Cement, replace
clear

use 4Coffshore

*Data cleaning- correcting inaccurate/empty observations, removing explicitly demonstration projects with <= 4 turbines and <= 10 MW or explicitly research/test projects. Comment below each observation drop explains why that observation was dropped. Any comment that ends with "stats" indicates a correction of an inaccurate or empty observation immediately above.
drop if WindFarmId == "NL0A"
*Onshore test for offshore
drop if WindFarmId == "FI25"
*Repowered wind farm
replace DistanceFromShoreAutokm = 0.4 if WindFarmId == "VN01"
replace WaterDepthMaxm = 3 if WindFarmId == "VN01"
replace WaterDepthMaxm = 3 if WindFarmId == "VN02"
*Bac Lieu stats
drop if WindFarmId == "BE11"
*Demonstration for Belwind
drop if WindFarmId == "ES64"
*Research facility without cost stats
drop if WindFarmId == "SE02"
*Repowered wind farm
replace TurbineMWMax = 3.6 if WindFarmId == "DE04"
replace CapacityMWMax = 281 if WindFarmId == "DE04"
*Fix turbine info for Borkum Riffgrund 1
drop if WindFarmId == "DE42"
*Single turbine project- demonstration project?
drop if WindFarmId == "JP03"
*Single turbine demonstration/research project
drop if WindFarmId == "CN29"
*Single turbine demonstration project
drop if WindFarmId == "CN0J"
*Single turbine demonstration project
replace ProjectCostMill = 1250 if WindFarmId == "UK04"
*Dudgeon stats
drop if WindFarmId == "ES61"
*Single turbine prototype project
drop if WindFarmId == "DE77"
*Single turbine pilot project
drop if WindFarmId == "JP33"
*5 of 6 turbines located onshore
drop if WindFarmId == "FR59"
*Single turbine demonstration/research project
drop if WindFarmId == "TW22"
*Two turbine pilot project
drop if WindFarmId == "DK09"
*Multi turbine test field
drop if WindFarmId == "JP06"
drop if WindFarmId == "JP13"
*Demonstration project for floating OFW
drop if WindFarmId == "IE13"
*Test/research site with no wind turbines?
drop if WindFarmId == "ES50"
*Single turbine prototype project
drop if WindFarmId == "SE20"
*Single turbine onshore research project
replace TurbineOEM = "Mingyang" if WindFarmId == "CN90"
*Guangdong Yudean Zhanjiang Wailuo stats
drop if WindFarmId == "UK73"
*Two turbine test project
drop if WindFarmId == "KR44"
*Single turbine demonstration project
drop if WindFarmId == "CN2B"
*Single turbine onshore demonstration project
replace TurbineOEM = "Shanghai Electric Wind Power Equipment Co., Ltd. (Sewind)" if WindFarmId == "CN41"
*Guodian Zhoushan Putuo District No. 6 stats
drop if WindFarmId == "DK79" | WindFarmId == "NL0W" | WindFarmId == "JP36"
*Single turbine onshore demonstration projects
drop if WindFarmId == "DK0B"
*Multiple turbine onshore test site
replace TurbineModelandOEM = "48x Envision 4.2 MW, 20x Haizhuang 5 MW" if WindFarmId == "CN35"
replace TurbineOEM = "Envision Energy" if WindFarmId == "CN35"
*Huaneng Dafeng Phase 1 stats
drop if WindFarmId == "CN94"
*Two turbine onshore demonstration project
drop if WindFarmId == "KR20"
*Single turbine onshore demonstration project
drop if WindFarmId == "UK76"
*Multi turbine floating OFW pilot project
drop if WindFarmId == "CN9W" | WindFarmId == "FR32"
*Single turbine onshore demonstration projects
replace ProjectCostMill = 7467 if WindFarmId == "JP05"
replace ProjectCostCurrency = "JPY" if WindFarmId == "JP05"
replace ProjectCostMill = 8533 if WindFarmId == "JP17"
replace ProjectCostCurrency = "JPY" if WindFarmId == "JP17"
*Kamisu stats
drop if WindFarmId == "NO55" | WindFarmId == "NO25"
*Incomplete? demonstration projects
drop if WindFarmId == "UK2H" | WindFarmId == "JP47" | WindFarmId == "JP12" | WindFarmId == "UK1E"
*Single turbine demonstration projects
drop if WindFarmId == "CN3B"
*Longyuan Nanri Island demonstration project
drop if WindFarmId == "ES53" | WindFarmId == "DK78"
*Multi turbine test projects
drop if WindFarmId == "FI02"
*Mostly onshore turbines
replace WindSpeed100mms = 9.75 if WindFarmId == "DK07" | WindFarmId == "DK11"
*Nysted and Rodsand II stats
drop if WindFarmId == "JP50"
*Single floating wind turbine
replace WindSpeed100mms = 9.75 if WindFarmId == "DK01"
*Samso stats
drop if WindFarmId == "SE36" | WindFarmId == "FR53"
*Floating turbine demonstration projects
drop if WindFarmId == "CNA3"
*Two turbine demonstration project
drop if WindFarmId == "DK94"
*Single onshore turbine
drop if WindFarmId == "CN02" | WindFarmId == "DK91" | WindFarmId == "DK90"
*Single turbine demonstration projects
drop if WindFarmId == "KR04" | WindFarmId == "ES59"
*Two turbine demonstration projects
drop if WindFarmId == "KR29"| WindFarmId == "NO04" | WindFarmId == "DK0T"
*Single turbine floating/onshore demonstration projects
drop if WindFarmId == "UK2I"
*Floating wind test project
drop if WindFarmId == "CN48" | WindFarmId == "CN0S" | WindFarmId == "CN14" | WindFarmId == "CN49" | WindFarmId == "CN2R"
*Single or two turbine pilot projects
replace WindSpeed100mms = 9.5 if WindFarmId == "DK05"
*Tuno Knob stats
replace WindSpeed100mms = 8.25 if WindFarmId == "SE06"
*Vindpark Vanern stats
replace WindSpeed100mms = 9.25 if WindFarmId == "NL85"
*Westermeerwind stats
replace WindSpeed100mms = 9.00 if WindFarmId == "NL28"
*Irene Vorrink stats
replace WindSpeed100mms = 8.75 if WindFarmId == "NL28"
*Middlegrunden stats
drop if WindFarmId == "DE23" | WindFarmId == "US12"
*CAPEX Outliers

*4Coffshore clarifications- These observations were previously missing CAPEX values, and I worked with 4C Offshore to find the necessary values.
drop if WindFarmId == "DK12" | WindFarmId == "DK04"
*Cannot find CAPEX
replace ProjectCostMill = 3000 if WindFarmId == "JP04"
replace ProjectCostCurrency = "JPY" if WindFarmId == "JP04"
*Sakata North Port stats
replace ProjectCostMill = 1770 if WindFarmId == "CN45"
replace ProjectCostCurrency = "CNY" if WindFarmId == "CN45"
replace ProjectCostMill = 1900 if WindFarmId == "CN3E"
replace ProjectCostCurrency = "CNY" if WindFarmId == "CN3E"
*Shanghai Lingang Demonstration Project stats
replace ProjectCostMill = 3470.8 if WindFarmId == "CN61"
replace ProjectCostCurrency = "CNY" if WindFarmId == "CN61"
*CGN Rudong Demonstration Project stats
replace ProjectCostMill = 6522.4236 if WindFarmId == "CN4C"
replace ProjectCostCurrency = "CNY" if WindFarmId == "CN4C"
*SPIC H2 stats
replace ProjectCostMill = 5930 if WindFarmId == "CN3N"
replace ProjectCostCurrency = "CNY" if WindFarmId == "CN3N"
*SPIC H3 stats
replace ProjectCostMill = 5331.3199 if WindFarmId == "CN4V"
replace ProjectCostCurrency = "CNY" if WindFarmId == "CN4V"
*Three Gorges Jiangsu Dafeng stats

*4Coffshore clarifications- These observations had inaccurate CAPEX values, and I worked with 4C Offshore to find the correct values.
replace ProjectCostMill = 1693.46 if WindFarmId == "CN3W"
*SPIC Binhai North H1 100MW stats
replace ProjectCostMill = 3111.10 if WindFarmId == "CN2Z"
*Rudong Offshore Wind Farm Demonstration Project -  Expansion Project (200MW) stats
replace ProjectCostMill = 5184.82 if WindFarmId == "CN2F"
*Jiangsu Longyuan Chiang Sand H1 stats
replace ProjectCostMill = 541.65 if WindFarmId == "CN07"
*Longyuan Rudong Intertidal Trial Wind Farm stats
replace ProjectCostMill = 18700 if WindFarmId == "TW16"
*Formosa 1 stats
replace ProjectCostMill = 3739.45 if WindFarmId == "CN90"
*Guangdong Yudean Zhanjiang Wailuo stats
replace ProjectCostMill = 448 if WindFarmId == "DK19"
*Horns Rev 2 stats
replace ProjectCostMill = 1692.97 if WindFarmId == "CN59"
replace ProjectCostMill = 846.33 if WindFarmId == "CN0O"
*Jiangsu Rudong 150 MW Phases 1 and 2 stats
replace ProjectCostMill = 700.9 if WindFarmId == "BE09"
replace ProjectCostMill = 420.5 if WindFarmId == "BE10"
*Thornton Phases 2 and 3 stats
replace ProjectCostMill = 1250 if WindFarmId == "UK33"
*West of Duddon Sands stats

*Merging forex adjustment
gen date_full_commissioning = date(FullCommissioning, "YMD")
gen yr = year(date_full_commissioning)
replace yr = 2020 if yr > 2019
replace date_full_commissioning = date(FullCommissioning, "DMY") if yr > 2019
merge m:1 yr ProjectCostCurrency using "Currency_Converter"
drop if _merge != 3

*Merging external control variables
rename _merge _merge1
merge m:1 yr using "EIU_Copper_Steel_Oil"
drop if _merge == 2
rename _merge _merge2
merge m:1 CountryName yr using "EIU_Wages"
drop if _merge == 2
rename _merge _merge3
merge m:1 yr using "FRED_Cement"
drop if _merge == 2
rename _merge _merge4
gen ln_copper = log(RefinedCoppercentslb)
gen ln_oil = log(BrentOilb)
gen ln_steel = log(SteeltonneWEur)
gen ln_wages = log(Wages)
gen ln_cement = log(Cement)

*Exploratory analyses
gen USDCAPEX = ProjectCostMill*Multiplier
gen capex_mw = USDCAPEX / CapacityMWMax
gen ln_capex_mw = log(capex_mw)
sort date_full_commissioning
gen cum_capacity = CapacityMWMax
replace cum_capacity = CapacityMWMax + cum_capacity[_n-1] if _n>1
gen ln_cum_capacity = log(cum_capacity)
scatter capex_mw date_full_commissioning if yr < 2020
scatter capex_mw yr if yr < 2020

*Within-country experience analysis setup
egen countrynum = group(CountryName)
sort countrynum date_full_commissioning
gen cum_country_capacity = CapacityMWMax
replace cum_country_capacity = CapacityMWMax + cum_country_capacity[_n-1] if _n>1 & (countrynum[_n-1] == countrynum[_n])
gen ln_cum_country_capacity = log(cum_country_capacity)

*Developer experience- Determining actual developers by breaking up special purpose vehicles and identifying subsidiaries. This section is organized by country.
*Belgium
replace Developers = "EDF, DEME, RWE" if Developers == "C-Power nv"
*C-Power nv
replace Developers = "Parkwind, Sumitomo" if Developers == "Nobelwind"
*Nobelwind
replace Developers = "Parkwind" if Developers == "Belwind NV"
*Belwind NV
replace Developers = "Parkwind, Aspiravi" if Developers == "Northwind NV (formerly ELDEPASCO LTD)"
*Northwind NV (formerly ELDEPASCO LTD)
replace Developers = "DEME, Aspiravi, Elicio Offshore, Green Offshore, Power@Sea, Z-Kracht" if Developers == "Rentel N.V."
*Rentel N.V.
replace Developers = "Elicio Offshore, Diamond Generating Europe, Eneco" if Developers == "Norther N.V."
*Norther N.V.
replace Developers = "Parkwind, Sumitomo" if Developers == "Northwester NV"
*Northwester NV

*China
replace Developers = "China Datang Corporation, Shanghai Green Environmental Energy Company, China General Nuclear, China Power New Energy Development Company" if Developers == "Shanghai Dong Hai Wind Power Generation Company Ltd (上海东海风力发电有限公司)"
*Shanghai Dong Hai Wind Power Generation Company Ltd (上海东海风力发电有限公司)
replace Developers = "China Longyuan Power Group Corporation" if Developers == "Jiangsu Longyuan Offshore Wind Power Co., Ltd. (江苏海上龙源风力发电有限公司)"
*Jiangsu Longyuan Offshore Wind Power Co., Ltd. (江苏海上龙源风力发电有限公司)
replace Developers = "China Longyuan Power Group Corporation, ZPMC" if Developers == "Jiangsu Longyuan Zhenhua Marine Engineering Co, Ltd(江苏龙源振华海洋工程有限公司)"
*Jiangsu Longyuan Zhenhua Marine Engineering Co, Ltd(江苏龙源振华海洋工程有限公司)
replace Developers = "Sinohydro Renewable Energy Company" if Developers == "Sinohydro Jiangsu Rudong Energy company"
*Sinohydro Jiangsu Rudong Energy company
replace Developers = "Sinohydro Renewable Energy Company" if Developers == "Shanghai East China Sea Wind Power Co., Ltd."
*Shanghai East China Sea Wind Power Co., Ltd.
replace Developers = "State Power Investment Corporation" if Developers == "State Power Investment Group Jiangsu Power Company Limited (国家电投集团江苏电力有限公司 )"
*State Power Investment Group Jiangsu Power Company Limited (国家电投集团江苏电力有限公司 )
replace Developers = "State Power Investment Corporation" if Developers == "CGN Wind Energy Limited (中广核风力发电有限公司 ）"
*CGN Wind Energy Limited (中广核风力发电有限公司 ）
replace Developers = "China Huaneng Group Company, Shanghai Green Environmental Energy Company, Shenergy Company" if Developers == "Shanghai Lingang Offshore Wind Power Co., Ltd. (上海临港海上风力发电有限公司)"
*Shanghai Lingang Offshore Wind Power Co., Ltd. (上海临港海上风力发电有限公司)
replace Developers = "China Huaneng Group Company, Huadian Power International Corporation" if Developers == "Huaneng Rudong Baxianjiao offshore windfarm Limited (华能如东八仙角海上风电有限责任公司)"
*Huaneng Rudong Baxianjiao offshore windfarm Limited (华能如东八仙角海上风电有限责任公司)
replace Developers = "China Longyuan Power Group Corporation" if Developers == "China Longyuan Power Group Corporation Limited(龙源 电力 集团 股份有限公司)"
*China Longyuan Power Group Corporation Limited(龙源 电力 集团 股份有限公司)
replace Developers = "State Power Investment Corporation" if Developers == "State Power Investment Corporation (SPIC) (国家电力投资集团)"
*State Power Investment Corporation (SPIC) (国家电力投资集团)
replace Developers = "Sinohydro Renewable Energy Company" if Developers == "Sinohydro Renewable Energy Co.,Ltd(中国水电建设新能源开发有限公司)"
*Sinohydro Renewable Energy Co.,Ltd(中国水电建设新能源开发有限公司)
replace Developers = "China Guodian Corporation" if Developers == "GD Zhejiang Zhoushan offshore wind power development Co. (国电电力浙江舟山海上风电开发有限公司)"
*GD Zhejiang Zhoushan offshore wind power development Co. (国电电力浙江舟山海上风电开发有限公司)
replace Developers = "China Three Gorges Corporation" if Developers == "China Three Gorges New Energy Co., Ltd. (中国三峡新能源有限公司)"
*China Three Gorges New Energy Co., Ltd. (中国三峡新能源有限公司)
replace Developers = "China Huaneng Group Company" if Developers == "Huaneng Renewables Corporation Ltd (华能新能源股份有限公司)"
*Huaneng Renewables Corporation Ltd (华能新能源股份有限公司)
replace Developers = "Shenhua Group Company" if Developers == "Shenhua Guohua (Jiangsu) Wind Power Co., Ltd. (华国华（江苏）风电有限公司)"
*Shenhua Guohua (Jiangsu) Wind Power Co., Ltd. (华国华（江苏）风电有限公司)

*Denmark
replace Developers = "Orsted" if Developers == "Ørsted A/S (formerly DONG Energy AS)"
*Ørsted A/S (formerly DONG Energy AS)
replace Developers = "Orsted, Vattenfall" if WindFarmId == "DK03"
*Horns Rev 1 developer
replace Developers = "Orsted" if Developers == "Ørsted Horns Rev 2 A/S"
*Ørsted Horns Rev 2 A/S
replace Developers = "E.ON" if Developers == "E.ON Vind Sverige AB"
*E.ON Vind Sverige AB
replace Developers = "Orsted" if Developers == "Ørsted - Anholt Offshore A/S"
*Ørsted - Anholt Offshore A/S
replace Developers = "Nissum Brednings Vindmøllelaug, Jysk Energi" if Developers == "Nissum Brednings Vindmøllelaug I/S,Jysk Energi A/S"
*Nissum Brednings Vindmøllelaug I/S,Jysk Energi A/S
replace Developers = "Vattenfall" if Developers == "Vattenfall AB"
*Vattenfall AB

*Germany
replace Developers = "E.ON, Vattenfall, EWE" if Developers == "Deutsche Offshore-Testfeld- und Infrastruktur GmbH &amp; Co. KG (DOTI)"
*Deutsche Offshore-Testfeld- und Infrastruktur GmbH &amp; Co. KG (DOTI)
replace Developers = "EnBW" if Developers == "EnBW Baltic 1 GmbH"
*EnBW Baltic 1 GmbH
replace Developers = "EWE, Enova" if Developers == "Offshore Windpark RIFFGAT GmbH &amp; Co. KG"
*Offshore Windpark RIFFGAT GmbH &amp; Co. KG
replace Developers = "Windland Energieerzeugungs GmbH" if Developers == "WindMW GmbH"
*WindMW GmbH
replace Developers = "Stadtwerke München GmbH, Vattenfall" if Developers == "DanTysk Offshore Wind GmbH"
*DanTysk Offshore Wind GmbH
replace Developers = "RWE" if Developers == "Essent Wind Nordsee Ost Planungsund Betriebsgesellschaft mbH"
*Essent Wind Nordsee Ost Planungsund Betriebsgesellschaft mbH
replace Developers = "WPD" if Developers == "WPD offshore GmbH"
*WPD offshore GmbH
replace Developers = "Stadtwerke München GmbH, ENTEGA AG, Axpo, Esportes Offshore Beteiligungs GmbH, Norderland Projekt GmbH, Windreich" if Developers == "Global Tech I Offshore Wind GmbH (formerly Wetfeet Offshore Wind Energy GmbH)"
*Global Tech I Offshore Wind GmbH (formerly Wetfeet Offshore Wind Energy GmbH)
replace Developers = "Orsted" if Developers == "Borkum Riffgrund I Offshore Windpark A/S GmbH &amp; Co. oHG"
*Borkum Riffgrund I Offshore Windpark A/S GmbH &amp; Co. oHG
replace Developers = "E.ON" if Developers == "Amrumbank West GmbH"
*Amrumbank West GmbH
replace Developers = "EnBW" if Developers == "EnBW Baltic 2 GmbH"
*EnBW Baltic 2 GmbH
replace Developers = "Stadtwerke München GmbH, Vattenfall" if Developers == "Sandbank Offshore Wind GmbH"
*Sandbank Offshore Wind GmbH
replace Developers = "Highland Group" if WindFarmId == "DE36"
*Veja Mate developer
replace Developers = "WPD" if Developers == "OWP Nordergründe GmbH &amp; Co"
*OWP Nordergründe GmbH &amp; Co
replace Developers = "Northland Power, RWE, Enova" if Developers == "Nordsee One GmbH"
*Nordsee One GmbH
replace Developers = "Iberdrola" if Developers == "Iberdrola Renovables Deutschland GmbH"
*Iberdrola Renovables Deutschland GmbH
replace Developers = "E.ON" if Developers == "E.ON AG"
*E.ON AG
replace Developers = "DEME, Coriolis" if Developers == "Merkur Offshore GmbH"
*Merkur Offshore GmbH
replace Developers = "Northland Power" if Developers == "Northland Power, Inc."
*Northland Power, Inc.
replace Developers = "EnBW" if Developers == "EnBW Hohe See GmbH,"
*EnBW Hohe See GmbH,
replace Developers = "EnBW" if Developers == "EnBW Albatros GmbH"
*EnBW Albatros GmbH

*Ireland
replace Developers = "ACCIONA Energía, GE Energy, Airtricity" if Developers == "ACCIONA Energía,GE Energy,SSE Renewables (formerly Airtricity)"
*ACCIONA Energía,GE Energy,SSE Renewables (formerly Airtricity)

*Japan
replace Developers = "Komatsuzaki Group" if Developers == "Wind Power Co., Ltd. (株式会社　ウィンド・パワー)"
*Wind Power Co., Ltd. (株式会社　ウィンド・パワー)
replace Developers = "Komatsuzaki Group" if Developers == "Wind Power Ibaraki Ltd (株式会社　ウィンド・パワー・いばらき)"
*Wind Power Ibaraki Ltd (株式会社　ウィンド・パワー・いばらき)

*Netherlands
replace Developers = "Nuon, Shell" if Developers == "NoordzeeWind"
*NoordzeeWind
replace Developers = "Northland Power" if WindFarmId == "NL18"
*Gemini developer
replace Developers = "Eneco" if WindFarmId == "NL01"
*Prinses Amaliawindpark developer
replace Developers = "Eneco" if Developers == "Eneco Wind B.V."
*Eneco Wind B.V.

*Korea
replace Developers = "Doosan Group" if Developers == "Tamra Offshore Wind Power Co. Ltd. (탐라해상풍력발전㈜),Energieonderzoek Centrum Nederland (ECN)"
*Tamra Offshore Wind Power Co. Ltd. (탐라해상풍력발전㈜),Energieonderzoek Centrum Nederland (ECN)

*Sweden
replace Developers = "Vattenfall" if Developers == "Vattenfall Europe Windkraft GmbH"
*Vattenfall Europe Windkraft GmbH
replace Developers = "Innovent GmbH, Vindkraft Gässlingen Ekonomisk förening" if Developers == "Vindpark Vänern"
*Vindpark Vänern

*Taiwan
replace Developers = "Swancor" if Developers == "Formosa I Wind Power Co., Ltd (海洋風力發電 )"
*Formosa I Wind Power Co., Ltd (海洋風力發電 )

*United Kingdom
replace Developers = "RWE" if Developers == "NWP Offshore Ltd"
*NWP Offshore Ltd
replace Developers = "E.ON" if Developers == "E.ON Climate &amp; Renewables UK Ltd"
*E.ON Climate &amp; Renewables UK Ltd
replace Developers = "Neg Micon" if Developers == "GREP UK Marine Ltd"
*GREP UK Marine Ltd
replace Developers = "Orsted" if Developers == "Barrow Offshore Wind Limited"
*Barrow Offshore Wind Limited
replace Developers = "Orsted" if Developers == "Ørsted Burbo Extension Holding Ltd."
*Ørsted Burbo Extension Holding Ltd.
replace Developers = "Renewable Energy Systems, AMEC" if Developers == "GLID Wind Farms Topco Ltd"
*GLID Wind Farms Topco Ltd
replace Developers = "RWE" if Developers == "Innogy SE"
*Innogy SE
replace Developers = "Orsted" if Developers == "Gunfleet Sands Ltd,Gunfleet Sands II Ltd"
*Gunfleet Sands Ltd,Gunfleet Sands II Ltd
replace Developers = "E.ON" if Developers == "E.ON Climate &amp; Renewables UK Robin Rigg West Ltd"
*E.ON Climate &amp; Renewables UK Robin Rigg West Ltd
replace Developers = "Vattenfall" if Developers == "Thanet Offshore Wind Ltd"
*Thanet Offshore Wind Ltd
replace Developers = "Orsted, SSE Renewables" if Developers == "Walney (UK) Offshore Windfarms Ltd"
*Walney (UK) Offshore Windfarms Ltd
replace Developers = "Vattenfall" if Developers == "Ormonde Energy Limited"
*Ormonde Energy Limited
replace Developers = "E.ON, Orsted" if Developers == "London Array Limited"
*London Array Limited
replace Developers = "Statoil, Statkraft" if Developers == "Scira Offshore Energy Ltd"
*Scira Offshore Energy Ltd
replace Developers = "Airtricity, Fluor" if Developers == "Greater Gabbard Offshore Winds Ltd"
*Greater Gabbard Offshore Winds Ltd
replace Developers = "Renewable Energy Systems, Orsted" if Developers == "RES (Renewable Energy Systems Ltd),Lincs Wind Farm Limited"
*RES (Renewable Energy Systems Ltd),Lincs Wind Farm Limited
replace Developers = "EDF" if Developers == "EDF Energy (Northern Offshore Wind) Ltd"
*EDF Energy (Northern Offshore Wind) Ltd
replace Developers = "Orsted, ScottishPower" if Developers == "West of Duddon Sands"
*West of Duddon Sands
replace Developers = "Orsted" if Developers == "Westermost Rough Ltd."
*Westermost Rough Ltd.
replace Developers = "E.ON" if Developers == "Humber Wind Limited"
*Humber Wind Limited
replace Developers = "RWE" if Developers == "Gwynt y Mor Offshore Wind Farm Limited"
*Gwynt y Mor Offshore Wind Farm Limited
replace Developers = "Orsted" if Developers == "Ørsted (UK) Limited"
*Ørsted (UK) Limited
replace Developers = "Equinor" if Developers == "Dudgeon Offshore Wind Ltd"
*Dudgeon Offshore Wind Ltd
replace Developers = "Orsted" if Developers == "Ørsted Power (UK) Ltd."
*Ørsted Power (UK) Ltd.
replace Developers = "RWE" if Developers == "Galloper Wind Farm Limited"
*Galloper Wind Farm Limited
replace Developers = "EDF" if Developers == "EDF Energy Renewables"
*EDF Energy Renewables
replace Developers = "Vattenfall" if Developers == "Aberdeen Offshore Wind Ltd"
*Aberdeen Offshore Wind Ltd
replace Developers = "Orsted" if Developers == "Ørsted Walney Extension Holdings Limited"
*Ørsted Walney Extension Holdings Limited
replace Developers = "E.ON" if Developers == "E.ON Climate &amp; Renewables UK Rampion Offshore Wind Limited"
*E.ON Climate &amp; Renewables UK Rampion Offshore Wind Limited
replace Developers = "SSE Renewables, Red Rock Power" if Developers == "Beatrice Offshore Windfarm Limited"
*Beatrice Offshore Windfarm Limited
replace Developers = "Orsted" if Developers == "HORNSEA 1 LIMITED (formerly Heron Wind Limited)"
*HORNSEA 1 LIMITED (formerly Heron Wind Limited)

*United States
replace Developers = "Deepwater Wind" if Developers == "Deepwater Wind Block Island, LLC (to become Ørsted US Offshore Wind)"
*Deepwater Wind Block Island, LLC (to become Ørsted US Offshore Wind)

*Vietnam
replace Developers = "Cong Ly Construction-Trading-Tourism Company" if Developers == "Cong Ly Construction-Trading-Tourism Co., Ltd. (Công Ty TNHH XD - TM -DL Công Lý)"
*Cong Ly Construction-Trading-Tourism Co., Ltd. (Công Ty TNHH XD - TM -DL Công Lý)

*Turbine manufacturer experience- Identifying accrued experience values for turbine manufacturers for projects that used turbines from multiple turbine manufacturers.
replace TurbineOEM = "Siemens" if TurbineOEM == "Siemens Gamesa"
gen Senvion1 = 0
replace Senvion1 = 30 if WindFarmId == "DE01"
gen Adwen1 = 0
replace Adwen1 = 30 if WindFarmId == "DE01"
*Alpha Ventus
gen UnitedPower1 = 0
replace UnitedPower1 = 3 if WindFarmId == "CN07"
gen MingYang1 = 0
replace MingYang1 = 6 if WindFarmId == "CN07"
gen Envision1 = 0
replace Envision1 = 3 if WindFarmId == "CN07"
gen SEwind1 = 0
replace SEwind1 = 4 if WindFarmId == "CN07"
gen Sany1 = 0
replace Sany1 = 2 if WindFarmId == "CN07"
gen Sinovel1 = 0
replace Sinovel1 = 6 if WindFarmId == "CN07"
gen Goldwind1 = 0
replace Goldwind1 = 4 if WindFarmId == "CN07"
gen Haizhuang1 = 0
replace Haizhuang1 = 2 if WindFarmId == "CN07"
gen BaoNan1 = 0
replace BaoNan1 = 2 if WindFarmId == "CN07"
*Longyuan Rudong Intertidal Trial Wind Farm
gen Siemens1 = 0
replace Siemens1 = 48.3 if WindFarmId == "CN59"
replace Sinovel1 = 51 if WindFarmId == "CN59"
*Jiangsu Rudong 150MW Offshore (Intertidal) Demonstration Wind Farm - phase I
replace TurbineOEM = "Hitachi" if TurbineOEM == "Hitachi Ltd"
replace TurbineOEM = "Vestas" if TurbineOEM == "MHI Vestas Offshore Wind"
replace TurbineOEM = "Haizhuang" if TurbineOEM == "CSIC Haizhuang Windpower Equipment"
replace Haizhuang1 = 10 if WindFarmId == "CN2E"
replace MingYang1 = 6.5 if WindFarmId == "CN2E"
replace Envision1 = 28 if WindFarmId == "CN2E"
gen DEC1 = 0
replace DEC1 = 5.5 if WindFarmId == "CN2E"
replace TurbineOEM = "DEC" if TurbineOEM == "Dongfang Electric"
*Longyuan Rudong Intertidal Trial Wind Farm -Extension
replace TurbineOEM = "Adwen" if TurbineOEM == "Areva Wind"
replace TurbineOEM = "SEwind" if TurbineOEM == "Shanghai Electric Wind Power Equipment Co., Ltd. (Sewind)"
replace Envision1 = 100 if WindFarmId == "CN2Z"
replace Siemens1 = 100 if WindFarmId == "CN2Z"
*Rudong Offshore Wind Farm Demonstration Project -  Expansion Project (200MW)
replace TurbineOEM = "Darwind" if TurbineOEM == "XEMC - Darwind"
replace Goldwind1 = 54 if WindFarmId == "CN51"
replace Siemens1 = 148 if WindFarmId == "CN51"
*Xiangshui Demonstration
replace Envision1 = 50.4 if WindFarmId == "CN3Y"
replace Siemens1 = 96 if WindFarmId == "CN3Y"
*Huaneng Rudong 300MW - South
replace Haizhuang1 = 100 if WindFarmId == "CN82"
replace Siemens1 = 56 if WindFarmId == "CN82"
*Huaneng Rudong 300MW - North
replace TurbineOEM = "Envision" if TurbineOEM == "Envision Energy"
gen Vestas1 = 0
replace Vestas1 = 320 if WindFarmId == "UK63"
replace Siemens1 = 329 if WindFarmId == "UK63"
*Walney Extension
replace TurbineOEM = "MingYang" if TurbineOEM == "Mingyang"
replace Envision1 = 50.4 if WindFarmId == "CN06"
replace Siemens1 = 252 if WindFarmId == "CN06"
*Dongtai Four (H2) 300MW
gen Nordtank1 = 0	
gen Bonus1 = 0	
gen GEEnergy1 = 0	
gen WinWinD1 = 0
gen FujiHeavyIndustries1 = 0	
gen Hitachi1 = 0	
gen DoosanHeavyIndustries1 = 0

*Copy and paste all of "developer_experience_raw.xlsx" Excel into cell A1 of developer_experience.xlsx (also in Github repository) in order to easily calculate developer and turbine manufacturer experience
sort date_full_commissioning
export excel using "developer_experience_raw.xlsx", firstrow(variables) replace
clear
import excel using "developer_experience.xlsx", firstrow sheet("Sheet1")

*Merge onshore-based exogenous technological change proxy
merge m:1 yr using "IRENA_Onshore_Wind"
drop if _merge == 2
rename _merge _merge5
replace weightedaverage = 0.001*weightedaverage

*Global/Country/Developer/OEM Experience- Analysis
replace cum_developer_capacity = 1 if cum_developer_capacity == 0
gen ln_cum_developer_capacity = log(cum_developer_capacity)
replace cum_OEM_capacity = 1 if cum_OEM_capacity == 0
gen ln_cum_OEM_capacity = log(cum_OEM_capacity)
gen UK = 0
replace UK = 1 if CountryName == "United Kingdom"
gen DE = 0
replace DE = 1 if CountryName == "Germany"
gen CN = 0
replace CN = 1 if CountryName == "China"
gen BE = 0
replace BE = 1 if CountryName == "Belgium"
gen NL = 0
replace NL = 1 if CountryName == "Netherlands"
gen DK = 0
replace DK = 1 if CountryName == "Denmark"
gen yr1 = 0
replace yr1 = 1 if (yr >= 1995 & yr <2000)
gen yr2 = 0
replace yr2 = 1 if (yr >= 2000 & yr <2005)
gen yr3 = 0
replace yr3 = 1 if (yr >= 2005 & yr <2010)
gen yr4 = 0
replace yr4 = 1 if (yr >= 2010 & yr <2015)
gen yr5 = 0
replace yr5 = 1 if (yr >= 2015 & yr <2020)
gen SupplyChain = 0
replace SupplyChain = 1 if (yr >= 2005 & yr <= 2015)
gen date_full_commissioning_2 = (date_full_commissioning)^2
gen yr_2 = (yr)^2
gen competitive = 0
replace competitive = 1 if WindFarmId == "UK63" | WindFarmId == "UK59" | WindFarmId == "UK81" | WindFarmId == "UK04" | WindFarmId == "UK53" | WindFarmId == "DE51" | WindFarmId == "NL0B" | WindFarmId == "NL0J" | WindFarmId == "UK80" | WindFarmId == "UK64" | WindFarmId == "NL0F" | WindFarmId == "DK37" | WindFarmId == "UK40" | WindFarmId == "UK56" | WindFarmId == "UK44" | WindFarmId == "US2T" | WindFarmId == "UK30"
reg ln_capex_mw ln_cum_capacity ln_copper ln_steel ln_oil ln_wages ln_cement WaterDepthMaxm DistanceFromShoreAutokm i.countrynum i.yr, r
reg ln_capex_mw ln_cum_country_capacity ln_copper ln_steel ln_oil ln_wages ln_cement WaterDepthMaxm DistanceFromShoreAutokm i.countrynum i.yr, r
reg ln_capex_mw ln_cum_developer_capacity ln_copper ln_steel ln_oil ln_wages ln_cement WaterDepthMaxm DistanceFromShoreAutokm i.countrynum i.yr, r
reg ln_capex_mw ln_cum_OEM_capacity ln_copper ln_steel ln_oil ln_wages ln_cement WaterDepthMaxm DistanceFromShoreAutokm i.countrynum i.yr, r

*Data Section Figures
twoway (qfit capex_mw yr) (scatter capex_mw yr) if yr < 2020, ytitle(CAPEX/W (2019$)) xtitle(Year) ylabel (0 2 4 6 8 10) legend(off) graphregion(color(white)) bgcolor(white)
graph export TimePlot.png, replace
twoway (lfit capex_mw WaterDepthMaxm) (scatter capex_mw WaterDepthMaxm) if yr < 2020, ytitle(CAPEX/W (2019$)) xtitle(Water Depth (m)) title(Panel d: Depth) legend(off)graphregion(color(white)) bgcolor(white)
graph export DepthPlot.png, replace
twoway (lfit capex_mw cum_OEM_capacity) (scatter capex_mw cum_OEM_capacity) if yr < 2020, ytitle(CAPEX/W (2019$)) xtitle(OEM Experience (MW)) title(Panel b: OEM Experience) legend(off) graphregion(color(white)) bgcolor(white)
graph export OEMPlot.png, replace
twoway (lfit capex_mw cum_developer_capacity) (scatter capex_mw cum_developer_capacity) if yr < 2020, ytitle(CAPEX/W (2019$)) xtitle(Developer Experience (MW)) title(Panel a: Developer Experience) legend(off) graphregion(color(white)) bgcolor(white)
graph export DevPlot.png, replace
twoway (lfit capex_mw TurbineMWMax) (scatter capex_mw TurbineMWMax) if yr < 2020, ytitle(CAPEX/W (2019$)) xtitle(Turbine Capacity (MW)) title(Panel c: Turbine Capacity) legend(off) graphregion(color(white)) bgcolor(white)
graph export TurbineCapPlot.png, replace

*Primary OLS Results Section
gen ln_TurbineMWMax = log(TurbineMWMax)
gen ln_capex = log(USDCAPEX)
gen ln_capacity = log(CapacityMWMax)
label variable ln_TurbineMWMax "log(Average Turbine Rating)"
label variable ln_capacity "log(Project Capacity)"
label variable ln_capex "log(CAPEX)"
label variable ln_capex_mw "log(CAPEX/W)"
label variable ln_cum_developer_capacity "log(Developer Experience)"
label variable ln_cum_OEM_capacity "log(OEM Experience)"
label variable CapacityMWMax "Project Capacity"
label variable ln_steel "log(Steel Price)"
label variable ln_copper "log(Copper Price)"
label variable ln_wages "log(Wage)"
label variable ln_oil "log(Oil Price)"
label variable ln_cement "log(Cement Price)"
label variable TurbineMWMax "Average Turbine Rating"
label variable WaterDepthMaxm "Water Depth"
label variable competitive "Competitive Procurement"
label variable weightedaverage "Average Onshore CAPEX/W"
reg ln_capex_mw ln_cum_developer_capacity ln_cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5 if yr < 2020, r
outreg2 using RegTable.doc, tex replace label addtext(Country Fixed Effects, Y, Time Fixed Effects, Y) ctitle(" ") dec(3) title("Table 2: OLS Results") adjr2 nonotes drop(UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5)
reg ln_capex_mw ln_cum_developer_capacity ln_cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_wages WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5 if yr < 2020, r
outreg2 using RegTable.doc, tex append label addtext(Country Fixed Effects, Y, Time Fixed Effects, Y) ctitle(" ") dec(3) adjr2 drop(UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5)
reg ln_capex_mw ln_cum_developer_capacity ln_cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_wages WaterDepthMaxm competitive weightedaverage UK DE CN BE NL DK if yr < 2020, r
outreg2 using RegTable.doc, tex append label addtext(Country Fixed Effects, Y, Time Fixed Effects, N) ctitle(" ") dec(3) adjr2 drop(UK DE CN BE NL DK)

*Total (Non-unitized) CAPEX Alternative OLS Results (Appendix A.2)
reg ln_capex ln_cum_developer_capacity ln_cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5 if yr < 2020, r
outreg2 using CAPEXRegTable.doc, tex replace label addtext(Country Fixed Effects, Y, Time Fixed Effects, Y) ctitle(" ") dec(3) title("Table 6: Total CAPEX OLS Results") adjr2 nonotes drop(UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5)
reg ln_capex ln_cum_developer_capacity ln_cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_wages WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5 if yr < 2020, r
outreg2 using CAPEXRegTable.doc, tex append label addtext(Country Fixed Effects, Y, Time Fixed Effects, Y) ctitle(" ") dec(3) adjr2 drop(UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5)
reg ln_capex ln_cum_developer_capacity ln_cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_wages WaterDepthMaxm competitive weightedaverage UK DE CN BE NL DK if yr < 2020, r
outreg2 using CAPEXRegTable.doc, tex append label addtext(Country Fixed Effects, Y, Time Fixed Effects, N) ctitle(" ") dec(3) adjr2 drop(UK DE CN BE NL DK)

*Robustness analysis (Selection) with turbine manufacturer fixed effects
gen Siemens_Dummy = 0
replace Siemens_Dummy = 1 if Siemens != 0
gen Vestas_Dummy = 0
replace Vestas_Dummy = 1 if Vestas != 0
gen Senvion_Dummy = 0
replace Senvion_Dummy = 1 if Senvion != 0
gen Adwen_Dummy = 0
replace Adwen_Dummy = 1 if Adwen != 0
gen Envision_Dummy = 0
replace Envision_Dummy = 1 if Envision != 0
gen Goldwind_Dummy = 0
replace Goldwind_Dummy = 1 if Goldwind != 0
gen United_Dummy = 0
replace United_Dummy = 1 if UnitedPower != 0
gen MingYang_Dummy = 0
replace MingYang_Dummy = 1 if MingYang != 0
gen SEwind_Dummy = 0
replace SEwind_Dummy = 1 if SEwind != 0
gen Sany_Dummy = 0
replace Sany_Dummy = 1 if Sany != 0
gen Sinovel_Dummy = 0
replace Sinovel_Dummy = 1 if Sinovel != 0
gen Haizhuang_Dummy = 0
replace Haizhuang_Dummy = 1 if Haizhuang != 0
gen BaoNan_Dummy = 0
replace BaoNan_Dummy = 1 if BaoNan != 0
gen DEC_Dummy = 0
replace DEC_Dummy = 1 if DEC != 0
gen Nordtank_Dummy = 0
replace Nordtank_Dummy = 1 if Nordtank != 0
gen Bonus_Dummy = 0
replace Bonus_Dummy = 1 if Bonus != 0
gen GEEnergy_Dummy = 0
replace GEEnergy_Dummy = 1 if GEEnergy != 0
gen WinWinD_Dummy = 0
replace WinWinD_Dummy = 1 if WinWinD != 0
gen FujiHeavyIndustries_Dummy = 0
replace FujiHeavyIndustries_Dummy = 1 if FujiHeavyIndustries != 0
gen Hitachi_Dummy = 0
replace Hitachi_Dummy = 1 if Hitachi != 0
gen DoosanHeavyIndustries_Dummy = 0
replace DoosanHeavyIndustries_Dummy = 1 if DoosanHeavyIndustries != 0
reg ln_capex_mw ln_cum_developer_capacity ln_cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5 Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy if yr < 2020, r
outreg2 using SimultaneityTable.doc, tex replace label addtext(Country Fixed Effects, Y, Time Fixed Effects, Y, Turbine Manufacturer Fixed Effects, Y) ctitle(" ") dec(3) title("Table 4: Selection Test Results") adjr2 nonotes drop(ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5 Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy)
reg ln_capex_mw ln_cum_developer_capacity ln_cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_wages WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5 Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy if yr < 2020, r
outreg2 using SimultaneityTable.doc, tex append label addtext(Country Fixed Effects, Y, Time Fixed Effects, Y, Turbine Manufacturer Fixed Effects, Y) ctitle(" ") dec(3) adjr2 drop(ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5 Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy)
reg ln_capex_mw ln_cum_developer_capacity ln_cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_wages WaterDepthMaxm competitive weightedaverage UK DE CN BE NL DK Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy if yr < 2020, r
outreg2 using SimultaneityTable.doc, tex append label addtext(Country Fixed Effects, Y, Time Fixed Effects, N, Turbine Manufacturer Fixed Effects, Y) ctitle(" ") dec(3) adjr2 drop(ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive weightedaverage UK DE CN BE NL DK Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy)

*Total (Non-unitized) CAPEX Alternative Selection Test Results (Appendix A.2)
reg ln_capex ln_cum_developer_capacity ln_cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5 Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy if yr < 2020, r
outreg2 using CAPEXSimultaneityTable.doc, tex replace label addtext(Country Fixed Effects, Y, Time Fixed Effects, Y, Turbine Manufacturer Fixed Effects, Y) ctitle(" ") dec(3) title("Table 7: Total CAPEX Selection Test Results") adjr2 nonotes drop(ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5 Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy)
reg ln_capex ln_cum_developer_capacity ln_cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_wages WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5 Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy if yr < 2020, r
outreg2 using CAPEXSimultaneityTable.doc, tex append label addtext(Country Fixed Effects, Y, Time Fixed Effects, Y, Turbine Manufacturer Fixed Effects, Y) ctitle(" ") dec(3) adjr2 drop(ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5 Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy)
reg ln_capex ln_cum_developer_capacity ln_cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_wages WaterDepthMaxm competitive weightedaverage UK DE CN BE NL DK Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy if yr < 2020, r
outreg2 using CAPEXSimultaneityTable.doc, tex append label addtext(Country Fixed Effects, Y, Time Fixed Effects, N, Turbine Manufacturer Fixed Effects, Y) ctitle(" ") dec(3) adjr2 drop(ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive weightedaverage UK DE CN BE NL DK Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy)

/*
*With all turbine manufacturer fixed effects
reg ln_capex_mw ln_cum_developer_capacity ln_cum_OEM_capacity ln_TurbineMWMax CapacityMWMax ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5 Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy United_Dummy MingYang_Dummy SEwind_Dummy Sany_Dummy Sinovel_Dummy Haizhuang_Dummy BaoNan_Dummy DEC_Dummy Nordtank_Dummy Bonus_Dummy GEEnergy_Dummy WinWinD_Dummy FujiHeavyIndustries_Dummy Hitachi_Dummy DoosanHeavyIndustries_Dummy if yr < 2020, r
outreg2 using SimultaneityTable2.doc, word replace label addtext(Country Fixed Effects, Y, Time Fixed Effects, Y, Turbine Manufacturer Fixed Effects, Y) ctitle(" ") dec(3) title("Table 4: Selection Test Results") adjr2 nonotes drop(CapacityMWMax ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5 Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy United_Dummy MingYang_Dummy SEwind_Dummy Sany_Dummy Sinovel_Dummy Haizhuang_Dummy BaoNan_Dummy DEC_Dummy Nordtank_Dummy Bonus_Dummy GEEnergy_Dummy WinWinD_Dummy FujiHeavyIndustries_Dummy Hitachi_Dummy DoosanHeavyIndustries_Dummy)
reg ln_capex_mw ln_cum_developer_capacity ln_cum_OEM_capacity ln_TurbineMWMax CapacityMWMax ln_steel ln_wages WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5 Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy United_Dummy MingYang_Dummy SEwind_Dummy Sany_Dummy Sinovel_Dummy Haizhuang_Dummy BaoNan_Dummy DEC_Dummy Nordtank_Dummy Bonus_Dummy GEEnergy_Dummy WinWinD_Dummy FujiHeavyIndustries_Dummy Hitachi_Dummy DoosanHeavyIndustries_Dummy if yr < 2020, r
outreg2 using SimultaneityTable2.doc, word append label addtext(Country Fixed Effects, Y, Time Fixed Effects, Y, Turbine Manufacturer Fixed Effects, Y) ctitle(" ") dec(3) adjr2 drop(CapacityMWMax ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5 Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy United_Dummy MingYang_Dummy SEwind_Dummy Sany_Dummy Sinovel_Dummy Haizhuang_Dummy BaoNan_Dummy DEC_Dummy Nordtank_Dummy Bonus_Dummy GEEnergy_Dummy WinWinD_Dummy FujiHeavyIndustries_Dummy Hitachi_Dummy DoosanHeavyIndustries_Dummy)
reg ln_capex_mw ln_cum_developer_capacity ln_cum_OEM_capacity ln_TurbineMWMax CapacityMWMax ln_steel ln_wages WaterDepthMaxm competitive weightedaverage UK DE CN BE NL DK Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy United_Dummy MingYang_Dummy SEwind_Dummy Sany_Dummy Sinovel_Dummy Haizhuang_Dummy BaoNan_Dummy DEC_Dummy Nordtank_Dummy Bonus_Dummy GEEnergy_Dummy WinWinD_Dummy FujiHeavyIndustries_Dummy Hitachi_Dummy DoosanHeavyIndustries_Dummy if yr < 2020, r
outreg2 using SimultaneityTable2.doc, word append label addtext(Country Fixed Effects, Y, Time Fixed Effects, N, Turbine Manufacturer Fixed Effects, Y) ctitle(" ") dec(3) adjr2 drop(CapacityMWMax ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive weightedaverage UK DE CN BE NL DK Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy United_Dummy MingYang_Dummy SEwind_Dummy Sany_Dummy Sinovel_Dummy Haizhuang_Dummy BaoNan_Dummy DEC_Dummy Nordtank_Dummy Bonus_Dummy GEEnergy_Dummy WinWinD_Dummy FujiHeavyIndustries_Dummy Hitachi_Dummy DoosanHeavyIndustries_Dummy)
*/

*Extension Future CAPEX Prediction Section
label variable capex_mw "Developer Quoted CAPEX/W"
reg ln_capex_mw ln_cum_OEM_capacity ln_TurbineMWMax ln_capacity WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5 Siemens_Dummy Vestas_Dummy Senvion_Dummy Adwen_Dummy Envision_Dummy Goldwind_Dummy if yr < 2020, r
predict capex_estimate
format date_full_commissioning %tdCY
twoway (scatter capex_estimate ln_capex_mw if yr < 2020, msymbol(O)) (scatter capex_estimate ln_capex_mw if yr > 2019, msymbol(Oh)) (line ln_capex_mw ln_capex_mw), ytitle(CAPEX Estimates) xtitle(Actual CAPEX Values and Quotes) legend(order(1 "Before 2020 (In-sample)" 2 "After and Including 2020 (Out-of-sample)"))  graphregion(color(white)) bgcolor(white)
graph export ExtensionPlot.png, replace
ssc install asdoc, replace
gen capex_delta = 100*abs(capex_estimate - ln_capex_mw)/ln_capex_mw
asdoc summarize capex_delta if yr > 2019

*Robustness analysis (project size exogeneity) where experience measured in number of projects instead of capacity
clear
import excel using "developer_experience_v2.xlsx", firstrow sheet("Sheet1")
merge m:1 yr using "IRENA_Onshore_Wind"
drop if _merge == 2
rename _merge _merge5
replace weightedaverage = 0.001*weightedaverage

gen UK = 0
replace UK = 1 if CountryName == "United Kingdom"
gen DE = 0
replace DE = 1 if CountryName == "Germany"
gen CN = 0
replace CN = 1 if CountryName == "China"
gen BE = 0
replace BE = 1 if CountryName == "Belgium"
gen NL = 0
replace NL = 1 if CountryName == "Netherlands"
gen DK = 0
replace DK = 1 if CountryName == "Denmark"
gen yr1 = 0
replace yr1 = 1 if (yr >= 1995 & yr <2000)
gen yr2 = 0
replace yr2 = 1 if (yr >= 2000 & yr <2005)
gen yr3 = 0
replace yr3 = 1 if (yr >= 2005 & yr <2010)
gen yr4 = 0
replace yr4 = 1 if (yr >= 2010 & yr <2015)
gen yr5 = 0
replace yr5 = 1 if (yr >= 2015 & yr <2020)
gen competitive = 0
replace competitive = 1 if WindFarmId == "UK63" | WindFarmId == "UK59" | WindFarmId == "UK81" | WindFarmId == "UK04" | WindFarmId == "UK53"

gen ln_TurbineMWMax = log(TurbineMWMax)
gen ln_capex = log(USDCAPEX)
gen ln_capacity = log(CapacityMWMax)
label variable ln_TurbineMWMax "log(Average Turbine Rating)"
label variable ln_capacity "log(Project Capacity)"
label variable ln_capex "log(CAPEX)"
label variable capex_mw "CAPEX/W"
label variable cum_developer_capacity "Developer Experience"
label variable cum_OEM_capacity "OEM Experience"
label variable CapacityMWMax "Project Capacity"
label variable ln_steel "log(Steel Price)"
label variable ln_copper "log(Copper Price)"
label variable ln_wages "log(Wage)"
label variable ln_oil "log(Oil Price)"
label variable ln_cement "log(Cement Price)"
label variable TurbineMWMax "Average Turbine Rating"
label variable WaterDepthMaxm "Water Depth"
label variable competitive "Competitive Procurement"
label variable weightedaverage "Average Onshore CAPEX/W"
drop if yr == 2020
reg ln_capex_mw cum_developer_capacity cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5, r
outreg2 using RobustnessTable.doc, tex replace label addtext(Country Fixed Effects, Y, Time Fixed Effects, Y) ctitle(" ") dec(3) title("Table 3: Project Size Exogeneity Test Results") adjr2 nonotes drop(ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5)
reg ln_capex_mw cum_developer_capacity cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_wages WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5, r
outreg2 using RobustnessTable.doc, tex append label addtext(Country Fixed Effects, Y, Time Fixed Effects, Y) ctitle(" ") dec(3) adjr2 drop(ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5)
reg ln_capex_mw cum_developer_capacity cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_wages WaterDepthMaxm competitive weightedaverage UK DE CN BE NL DK, r
outreg2 using RobustnessTable.doc, tex append label addtext(Country Fixed Effects, Y, Time Fixed Effects, N) ctitle(" ") dec(3) adjr2 drop(ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive weightedaverage UK DE CN BE NL DK)

*Total (Non-unitized) CAPEX Alternative Project Size Exogeneity Test Results (Appendix A.2)
reg ln_capex cum_developer_capacity cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5, r
outreg2 using CAPEXRobustnessTable.doc, tex replace label addtext(Country Fixed Effects, Y, Time Fixed Effects, Y) ctitle(" ") dec(3) title("Table 8: Total CAPEX Project Size Exogeneity Test Results") adjr2 nonotes drop(ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5)
reg ln_capex cum_developer_capacity cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_wages WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5, r
outreg2 using CAPEXRobustnessTable.doc, tex append label addtext(Country Fixed Effects, Y, Time Fixed Effects, Y) ctitle(" ") dec(3) adjr2 drop(ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5)
reg ln_capex cum_developer_capacity cum_OEM_capacity ln_TurbineMWMax ln_capacity ln_steel ln_wages WaterDepthMaxm competitive weightedaverage UK DE CN BE NL DK, r
outreg2 using CAPEXRobustnessTable.doc, tex append label addtext(Country Fixed Effects, Y, Time Fixed Effects, N) ctitle(" ") dec(3) adjr2 drop(ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive weightedaverage UK DE CN BE NL DK)

*Global cumulative capacity analysis
label variable ln_cum_capacity "log(Cumulative Experience)"
reg ln_capex_mw ln_cum_capacity ln_capacity ln_steel ln_copper ln_wages ln_oil ln_cement WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5, r
outreg2 using SpilloverTable.doc, word replace label addtext(Country Fixed Effects, Y, Time Fixed Effects, Y) ctitle(" ") dec(3) title("Cumulative Capacity Analysis") adjr2 nonotes drop(UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5)
reg ln_capex_mw ln_cum_capacity ln_capacity ln_steel ln_wages WaterDepthMaxm competitive UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5, r
outreg2 using SpilloverTable.doc, word append label addtext(Country Fixed Effects, Y, Time Fixed Effects, Y) ctitle(" ") dec(3) adjr2 drop(UK DE CN BE NL DK yr1 yr2 yr3 yr4 yr5)
reg ln_capex_mw ln_cum_capacity ln_capacity ln_steel ln_wages WaterDepthMaxm competitive weightedaverage UK DE CN BE NL DK, r
outreg2 using SpilloverTable.doc, word append label addtext(Country Fixed Effects, Y, Time Fixed Effects, N) ctitle(" ") dec(3) adjr2 drop(UK DE CN BE NL DK)

*Turbine capacity over time plot
label variable yr "Year of Full Commissioning"
twoway (lfit TurbineMWMax yr) (scatter TurbineMWMax yr),  ytitle(Turbine Rating (MW)) graphregion(color(white)) bgcolor(white) legend(off)
graph export TurbineCapTime.png, replace

log close
