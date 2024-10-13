
Permission Values
exec  : 1
write : 2
read  : 4


rule: ugo 
u: user  permissions
g: group permissions
o: other permissions

permission of arch role is the sum of permission values
e.g
  700 -- u : 1 + 2 + 4 (rwx)
         g : 0         (---)
         o : 0         (---)
         
  660 -- u : 0 + 2 + 4 (rw-)
         g : 0 + 2 + 4 (rs-)
         o : 0         (---)
