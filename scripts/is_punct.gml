///is_punct(char)

var c;
    c = ord(argument0);
    
return ((c>=0 && c<=47) || (c>=58 && c<=64) || (c>=91 && c<=96) || (c>=123 && c<=127))
