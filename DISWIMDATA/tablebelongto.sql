select
s.name table_name,
case when pe.name is not null then 'PDMExt_DSWIM'
WHEN PMT.NAME IS NOT NULL THEN 'PDM_DSWIM'
WHEN DW.NAME IS NOT NULL THEN 'PDMW_DSWIM'
WHEN DS.NAME IS NOT NULL THEN 'DSRTA'
ELSE 'SELF' END DES
from sys.tables s
left join pdmtable pmt
on pmt.name=s.name
left join pdmexttable pe
on pe.name=s.name
left join dsrtatable ds
on ds.name=s.name
LEFT JOIN PDMWTABLE DW
ON DW.NAME=S.NAME
order by s.name