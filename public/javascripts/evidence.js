function watchForLocalArchiveFile() {
	data = $F('item_local');
       data = data.replace(/^\s|\s$/g, ""); //trims string

       if (data.match(/([^\/\\]+)\.(zip|gz)$/i) )
		 Field.enable('item_local_unpack');
       else
		 Field.disable('item_local_unpack');
		 $("item_local_unpack").checked = false;			
}

function watchForRemoteArchiveFile() {
	data = $F('item_remote_path');
       data = data.replace(/^\s|\s$/g, ""); //trims string

       if (data.match(/([^\/\\]+)\.(zip|gz)$/i) )
		 Field.enable('remote_unpack');
       else
		 Field.disable('remote_unpack');
		 $("remote_unpack").checked = false;	
		
	Field.focus('item_remote_path');		
}