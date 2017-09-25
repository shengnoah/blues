local _M = {}


function _M:get_ngx_conf_template()

    return [[

# user www www;
pid tmp/{{FW_ENV}}-nginx.pid;

# This number should be at maxium the number of CPU on the server
worker_processes 4;

events {
    # Number of connections per worker
    worker_connections 4096;
}

http {
    # use sendfile
    sendfile on;
    # include {{NGX_PATH}}/conf/mime.types;

    # framework initialization
    {{LUA_PACKAGE_PATH}}
    {{LUA_PACKAGE_CPATH}}
    {{LUA_CODE_CACHE}}
    {{LUA_SHARED_DICT}}


    {{INIT_BY_LUA}}
    {{INIT_BY_LUA_FILE}}
    {{INIT_WORKER_BY_LUA}}
    {{INIT_WORKER_BY_LUA_FILE}}

    server {
        # List port
        listen {{PORT}};
        set $template_root '';

        location /static {
            alias {{STATIC_FILE_DIRECTORY}}; #app/static;
        }

        # Access log with buffer, or disable it completetely if unneeded
        access_log logs/{{FW_ENV}}-access.log combined buffer=16k;
        # access_log off;

        # Error log
        error_log logs/{{FW_ENV}}-error.log;

        # framework runtime
        {{CONTENT_BY_LUA_FILE}}
        {{CONTENT_BY_LUA}}
    }
}

    ]]

end

return _M
