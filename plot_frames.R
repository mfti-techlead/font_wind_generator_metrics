library(readxl)
library(sqldf)
library(plotly)
res = read_excel('country_mapping.xlsx', sheet = 'Result')
cntr = read.table('mref_country.csv', sep = ',')

map = sqldf('
select 
period,
c.v12 cont1,
c2.v12 cont2,
reporter, 
coalesce(sum(case when flow = "Import" then VAL end),0) import_val,
coalesce(sum(case when flow = "Export" then VAL end),0) export_val
from res r
left join cntr c
on r.reporter = c.v9
left join cntr c2
on map_name = c2.v9
-- where 
--r.reporter in ("Germany", "Russian Federation")
--and period in (2018,2019)
group by period, c.v13, c2.v13, reporter
      ')

map$world_part = ifelse(is.na(map$cont1), map$cont2, map$cont1)


write.csv(map, 'map.csv', row.names = F, col.names = T)


library(plotly)
library(gapminder)

df <- gapminder 
fig <- df %>%
  plot_ly(
    x = ~gdpPercap, 
    y = ~lifeExp, 
    size = ~pop, 
    color = ~continent, 
    frame = ~year, 
    text = ~country, 
    hoverinfo = "text",
    type = 'scatter',
    mode = 'markers'
  )
fig <- fig %>% layout(
  xaxis = list(
    type = "log"
  )
)

fig



