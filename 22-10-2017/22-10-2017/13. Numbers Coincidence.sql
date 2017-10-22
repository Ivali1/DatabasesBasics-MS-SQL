select DISTINCT  u.Username
  from Users as u
  join Reports as r
    on r.UserId=u.Id
   where  (left(u.Username,1) >='0' and left(u.Username,1) <='9'and
     cast( r.CategoryId as NVARCHAR)= left(u.Username,1) )
	    or
	    (RIGHT(u.Username,1) >='0' and RIGHT(u.Username,1)<='9' and
		CAST(r.CategoryId AS nvarchar)=RIGHT(u.Username,1))
order by u.Username
