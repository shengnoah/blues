class GMoonSDK
    pwd: ""
    uname: ""
    headers_info: ""
    endpoints: {
        's_uat':{'/search/universal/absolute/terms':{'field', 'query', 'from', 'to', 'limit'} }
        's_ua':{'/search/universal/absolute':{'fields', 'query', 'from', 'to', 'limit'} }
        's_urt':{'/search/universal/relative/terms':{'field', 'query', 'range'} }
        's_ut':{'/search/universal/relative':{'fields', 'query', 'range'} }
    }

    @build_headers: =>
        auth = "Basic "..encode_base64(self.uname..":"..self.pwd)
        headers= {
            'Authorization': auth, 
            'Accept': 'application/json'
        }
        return headers 

    @auth: (username, password, host, port) =>
        --Input parameter check process
        errList = {}
        if type(port) == 'nil'
            table.insert(errList, "port is nil\n")
        if type(host) == 'nil'
            table.insert(errList, "host is nil\n")
        if type(password) == 'nil'
            table.insert(errList, "password is nil\n")
        if type(username) == 'table'
            table.insert(errList, "username is nil\n")

        num = table.getn(errList) 
        if num > 0 
            return errList

       --Set auth info
        self.uname = username
        self.pwd = password 
        self.host = host
        self.port = port
        self.url = "http://"..host..":"..port
        self.headers_info = self\build_headers()
        return self.url

    @getRequest:(req_url) =>
        body, status_code, headers = http.simple {
            url: req_url 
            method: "GET"
            headers: self.headers_info 
        }
        return body

    @checkParam:(s_type, s_param) =>
        --Check configuration info
        if type(self.url) == "nil"
            return 'auth info err.'

        --Check type  
        info = self.endpoints[s_type]
        chk_flg = type(info)
        if chk_flg == "nil"
            return "Input parameter error,unknow type."

        --Get master key
        key = ''
        for k,v in pairs info
            key = k 

        --Check param
        str = ''
        for k,v in pairs info[key]
            if type(s_param[v]) == 'nil'
                return info[key][k]..":is nil"
            str = str..s_param[v]
        return "OK", str

    @call: (s_type, s_param) =>
        --Get master key
        key = ''
        for k,v in pairs self.endpoints[s_type]
            key = k 

        --encode url 
        url_data = ngx.encode_args(s_param)
        tmp_url = self.url..key.."?"
        req_url = tmp_url..url_data

        --HTTP GET request
        ret = self\getRequest req_url
        return ret

    @dealStream: (s_type, s_param) =>
        ret = ''
        status, param_list = GMoonSDK\checkParam s_type, s_param
        if status == "OK"
            ret = GMoonSDK\call s_type, s_param
        else 
            ret = status 
        return ret 
