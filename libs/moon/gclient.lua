local param_data = {
  fields = 'username',
  limit = 3,
  query = '*',
  from = '2017-01-05 00:00:00',
  to = '2017-01-06 00:00:00',
  filter = 'streams' .. ':' .. '673b1666ca624a6231a460fa'
}
local url = GMoonSDK:auth('supervisor', 'password', '127.0.0.1', '12600')
local ret = GMoonSDK:dealStream('s_ua', param_data)
return ret
