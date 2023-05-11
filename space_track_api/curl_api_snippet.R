library(curl)


st_username <- "mcooney@describedata.com"
st_password <- "GBzicIc1RbTybI1u"

base_url <- "https://www.space-track.org/ajaxauth/login"

request_url <- "https://www.space-track.org/basicspacedata/query/class/gp_history/NORAD_CAT_ID/28472/orderby/EPOCH asc/format/csv/emptyresult/show"



h <- new_handle()

handle_setform(h,
  identity = st_username,
  password = st_password,
  query    = request_url
  )

req <- curl_fetch_memory(base_url, handle = h)

req$content |> rawToChar() |> write_lines("tmp.csv")



