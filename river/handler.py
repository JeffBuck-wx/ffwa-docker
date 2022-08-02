import requests
from datetime import datetime, timedelta
from pytz import timezone



utc_end   = datetime.utcnow()
utc_start = utc_end - timedelta(hours=3)

local_tz    = timezone('America/Chicago')  
local_end   = utc_end.astimezone(local_tz)
local_start = utc_start.astimezone(local_tz)
format_DT   = '%Y-%m-%dT%H:%M:%S.%f' 

url   = "https://waterservices.usgs.gov/nwis/iv/?sites=05342000&parameterCd=00060&startDT={start_DT}&endDT={end_DT}&siteStatus=all&format=rdb"


res = requests.get(
    url.format(
        start_DT = local_start.strftime(format_DT),
        end_DT   = local_end.strftime(format_DT)
    )
)

# parse river data
river_data = []

# remove comment lines
for line in res.text.splitlines():
    if line[0] != '#':
        river_data.append(line)

# header
header = river_data.pop(0)

# data format
data_formats = []
for df in river_data.pop(0).split('\t'):
    data_formats.append(df[-1])
print(data_formats)

# extract the data
for row in river_data:
    row = row.split('\t')
    for i in range(0,len(row)):
        if data_formats[i] == 'n':
            row[i] = float(row[i])
        #elif data_formats[i] == 'd':
        #    row[i] = datetime.strptime(row[i], '%Y-%m-%d %H:%M')
    print(row)

        
