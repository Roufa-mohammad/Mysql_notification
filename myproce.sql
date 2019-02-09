
DELIMITER //
DROP PROCEDURE IF EXISTS day;
CREATE PROCEDURE day()
BEGIN 
insert into dob1 select name,
if (day(date)=day(now())
and month(date)=month(now()),'IS CELEBRATING BIRTHDAY TODAY',
if (day(date)=day(adddate(now(),-1))
and month(date)=month(adddate(now(),-1)),'yesterday',
if (day(date) =day(adddate(now(),+1))
and month(date)=month(adddate(now(),+1)),'tomorrow','future')))
from dob;
END //
DELIMITER ;

