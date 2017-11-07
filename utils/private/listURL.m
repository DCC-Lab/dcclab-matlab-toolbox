function listURL(url)

'curl -i -o out.xml -u dcclab:microscope -X PROPFIND http://cafeine.crulrg.ulaval.ca/labdata/dccote/ --upload-file - -H "Depth: 1" <<end' 
'<?xml version="1.0"?>'
'<a:propfind xmlns:a="DAV:">'
'<a:prop><a:resourcetype/></a:prop>'
'</a:propfind>'
'end'

end
