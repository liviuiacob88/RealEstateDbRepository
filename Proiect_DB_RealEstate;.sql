create database Real_Estate_Project;
use Real_Estate_project;
-- 2.1  Crearea Tabelelor (am creat 5 tabele)

create table Project_phase (
id int auto_increment primary key,
phase_name varchar(30),
duration varchar(10),
unit_number int,
estimated_value int
);
create table Buyer (
id int auto_increment primary key,
FirstName varchar (30),
SecondName varchar (30),
Telephone char(10),
Job varchar(30),
Reason enum('for_rent','as_investment','as_a_home'),
Adress varchar(255)
);
create table apartment (
id int auto_increment primary key,
ap_type enum('ap_1camera','ap_2camere','ap_3camere','ápartament_4camere'),
ap_level int,
build_area int,
util_area int,
price int,
available enum('DA','NU'),
id_project_phase int,
foreign key fk_apartment(id_project_phase) references project_phase(id)
);
create table reservation(
id int auto_increment primary key,
reservation_date date,
amount enum('1000'),
rest_of_payment int,
id_buyer int,
foreign key fk_reservation_buyer(id_buyer) references buyer(id),
id_apartment int unique not null,
foreign key fk_reservation_buyer(id_apartment) references apartment(id)
);
alter table reservation drop foreign key reservation_ibfk_2;
alter table reservation add foreign key fk_reservation_apartment(id_apartment) references apartment(id);

create table payment(
id_payment int primary key auto_increment,
amount int,
payment_date date,
rest_of_payment int,
id_buyer int,
foreign key fk_payment_buyer(id_buyer) references buyer(id),
id_apartment int,
foreign key fk_payment_apartment(id_apartment) references apartment(id)
);

-- 2.1 Modificarea structurii tabelelor:

alter table payment drop foreign key payment_ibfk_1; 
alter table reservation drop foreign key reservation_ibfk_1;
alter table apartment add id_buyer int;
alter table apartment add foreign key fk_apartment_buyer(id_buyer) references buyer(id);
alter table reservation drop id_buyer;
alter table payment drop id_buyer;
alter table reservation drop id_apartment;
alter table reservation add id_apartment int unique not null;
alter table reservation change id_apartment id_apartment int not null;
alter table buyer change adress city varchar(255);
alter table apartment change ap_type ap_type enum('studio','2_room_ap','3_room_ap','4_room_ap','penthouse');
alter table apartment change available available enum('yes','no');
alter table project_phase add year_of_completion int;

-- 3. Actualizarea datelor ( am populat tabelele cu minim 10 inregistrari mai putin tabelul cu fazele de constructie, unde am doar 4 randuri)
-- 3.1 Comanda INSERT

insert into project_phase values 
(null,'Phase1','12months',5,250000,2018),
(2,'Phase2','11months',8,640000,2019),
(3,'Phase3','13months',10,1000000,2020),
(4,'Phase4','11months',12,1200000,2021);
select * from project_phase;
insert into buyer values (1,'Andrei ','Buzatu',740124578,'Civil_Engineer','as_investment','Ploiesti'),
(2,'Daniel','Cojocaru',714876395,'C#Developer','for_rent','Frankfurt'),
(3,'Andrei ','Neagu',784361235,'Python_Developer','as_investment','Bucharest'),
(4,'Ciprian','Domnica',734565125,'Real_Estate_Evaluator','as_a_home','Bucharest'),
(5,'Iacob','Liviu',741249873,'Civil_Project_Manager','for_rent','Pitesti'),
(6,'Marius','Sandu',721876538,'Database_Developer','as_investment','Curtea_De_Arges'),
(7,'Spiridon','Paula',734561621,'Doctor','as_a_home','Bucharest'),
(8,'Lacureanu','Alexandru',723875245,'Loyer','as_a_home','Curtea_De_Arges'),
(9,'Emandi ','Teodor',736414763,'Entreprenor','as_investment','Bucharest'),
(10,'Ermin','Alexandru',732686884,'Entreprenor','for_rent','Calarasi');

insert into apartment values (1,'studio','0',40,'36','46800','no',1,1),
(2,'studio','0',40,'36','46800','no',1,9),
(3,'2_room_ap','0',60,'54','70200','no',1,4),
(4,'2_room_ap','1',60,'54','70200','no',1,7),
(5,'3_room_ap','1',80,'72','93600','no',1,8),
(6,'studio','0',40,'36','46800','no',2,2),
(7,'studio','1',40,'36','46800','no',2,3),
(8,'2_room_ap','2',60,'54','70200','no',2,3),
(9,'2_room_ap','1',60,'54','70200','no',2,6),
(10,'3_room_ap','2',80,'72','93600','no',2,null),
(11,'3_room_ap','1',80,'72','93600','no',2,null),
(12,'4_room_ap','0',110,'99','128700','no',2,null),
(13,'penthouse','3',140,'126','163800','no',2,6),
(14,'studio','0',40,'36','46800','no',3,5),
(15,'studio','1',40,'36','46800','no',3,5),
(16,'studio','2',40,'36','46800','no',3,10),
(17,'2_room_ap','0',60,'54','70200','yes',3,null),
(18,'2_room_ap','1',60,'54','70200','no',3,10),
(19,'3_room_ap','1',80,'72','93600','yes',3,null),
(20,'3_room_ap','0',80,'72','93600','yes',3,null),
(21,'4_room_ap','1',110,'99','128700','no',3,5),
(22,'4_room_ap','2',110,'99','128700','no',3,5),
(23,'penthouse','3',140,'126','163800','no',3,1),
(24,'studio','2',40,'36','46800','yes',4,null),
(25,'studio','3',40,'36','46800','yes',4,null),
(26,'studio','4',40,'36','46800','yes',4,null),
(27,'2_room_ap','0',60,'54','70200','yes',4,null),
(28,'2_room_ap','0',60,'54','70200','yes',4,null),
(29,'2_room_ap','0',60,'54','70200','yes',4,null),
(30,'3_room_ap','1',80,'72','93600','yes',4,null),
(31,'3_room_ap','1',80,'72','93600','yes',4,null),
(32,'4_room_ap','2',110,'99','128700','yes',4,null),
(33,'4_room_ap','3',110,'99','128700','yes',4,null),
(34,'4_room_ap','4',110,'99','128700','yes',4,null),
(35,'penthouse','5',140,'126','163800','yes',4,null);

insert into reservation values (null,'2017-09-11','1000',92600,5),
(null,'2017-11-23','1000',45800,1),
(null,'2018-03-20','1000',69200,3),
(null,'2018-08-14','1000',127700,12),
(null,'2018-11-21','1000',162800,13),
(null,'2019-01-11','1000',92600,11),
(null,'2019-03-20','1000',69200,8),
(null,'2019-05-08','1000',92600,10),
(null,'2019-06-19','1000',162800,23),
(null,'2019-07-20','1000',127700,21),
(null,'2019-08-02','1000',127700,22),
(null,'2019-08-16','1000',45800,14),
(null,'2019-09-27','1000',45800,16),
(null,'2019-10-24','1000',45800,15),
(null,'2019-11-04','1000',69200,18);
alter table payment change amount date_of_payment date;
alter table payment change payment_date amount int;
insert into payment values (null,'2018-04-13',70200,0,4),
(null,'2018-04-14',46800,0,2),
(null,'2018-05-03',45800,0,1),
(null,'2018-05-16',92600,0,5),
(null,'2018-05-17',69200,0,3),
(null,'2019-03-18',70200,0,9),
(null,'2019-04-02',92600,0,10),
(null,'2019-04-02',69200,0,8),
(null,'2019-04-12',127700,0,12),
(null,'2019-04-15',162800,0,13),
(null,'2019-04-23',92600,0,11),
(null,'2019-05-03',46800,0,6),
(null,'2019-06-17',46800,0,7),
(null,'2019-08-02',50000,112800,23),
(null,'2019-10-06',25000,102700,22),
(null,'2019-11-05',50000,62800,23);

-- 3.2 Comanda UPDATE

select * from apartment;
select * from buyer;
select * from payment;

-- 3.2.a)
-- apartamentele cu id 10,11,12 au fost cumparate de catre cumparatorii cu id 1,3,5;

update apartment set id_buyer=1 where id=10;
update apartment set id_buyer=3 where id=11;
update apartment set id_buyer=5 where id=12;

-- 3.2.b)

-- doresc sa cresc pretul studiourilor din faza 4 ramase nevandute cu 10 %
-- mai intai doresc sa vad cate astfel de cazuri am. 
select * from apartment 
where id_buyer is null and id_project_phase = 4 and ap_type = 'studio';
-- (vad ca am 3 studio-uri la pretul de 46800 - id 24,25,26)
-- ulterior doresc sa vad cat ar insemna marirea si sa verific ca o indroduc corect;

select id, ap_type, price*1.1 as price_raised, id_project_phase 
from apartment
where id_buyer is null and id_project_phase = 4 and ap_type = 'studio';

-- mi se afiseaza ca si pret marit (3 studio-uri in coloana price_raised cu pretul de 51800)
-- voi executa comanda de update

update apartment
set price=price*1.1
where id_buyer is null and id_project_phase = 4 and ap_type = 'studio';


-- 3.2.c)
-- doresc sa modific durata fazei de constructie 4 cu inca 7 luni, prin urmare si anul finalizarii devine 2022;


select * from project_phase;
update project_phase
set duration='18months',
	year_of_completion = '2022'
where id=4;


-- 3.3 Comanda DELETE

-- 3.3.a)
-- Sa se stearga plata cu id-ul 15

select * from payment;
DELETE from payment
where id_payment = '15';

-- 3.3.b)
-- sa se stearga cumparatorul cu id-ul 2;

select * from buyer;
DELETE from buyer
where id = 2;

-- nu pot sa o sterg direct, trebuie sa scot constraint-urile;
select * from apartment
where id_buyer = 2;
-- voi schimba id_buyer cu null pentru id = 6 in tabel apartment;
update apartment
set id_buyer = null, 
	available = 'yes'
where id = 6;
-- am executat comanda cu succes, cumparator cu id 2 a fost sters;

select * from payment;

-- 3.3.c)
-- sa se stearga toate platile mai mari de 150000;

delete from payment
where amount>150000;

-- nu-mi permite safemode, il voi dezactiva;

SET SQL_SAFE_UPDATES = 0;
-- am finalizat comanda, nu mai am plati peste 150000 ;
SET SQL_SAFE_UPDATES = 1;
-- am reintrodus safemode;

-- 4. INTEROGARI VARIATE CU SELECT --

-- 4.1 SUBINTEROGARI 
-- 4.1.a)
-- sa se afiseze toti cumparatorii din acelasi oras cu Sandu Marius

-- pas 1 selectez orasul din care este Sandu Marius

select * from buyer;

select city
from buyer
where FirstName = 'Marius'
and SecondName = 'Sandu';

-- pas 2 selectez cumparatorii din acelasi oras cu Sandu Marius

select FirstName, SecondName
from buyer
where city = (select city
				from buyer
				where FirstName = 'Marius'
				and SecondName = 'Sandu');

-- 4.1.b)
-- sa se afiseze toate apartamentele de acelasi fel cu cel generat de un apartament random
-- pas 1 selectez un apartament random 

select ap_type 
from apartment
order by rand()
limit 1;

-- pas 2 afisez toate apartamentele la fel cu apartamentul respectiv

select A.* from apartment as A
inner join ( 	select ap_type from apartment
				order by rand()
				limit 1
			) as R on R.ap_type = A.ap_type;

-- INTREBARE!!!! De ce nu functioneaza codul de mai jos (imi afiseaza doar apartamente random, nu de acelasi tip)

select * from apartment
where ap_type = ( 	select ap_type from apartment
				order by rand()
				limit 1
				);

-- 4.1.c)
-- sa se afiseze toti nume si prenume de la toti cumparatorii ce au cumparat locuinte din acelasi motiv ca si Ciprian Domnica
-- pas 1 selectez ce motiv Domnica Ciprian
select reason from buyer
where FirstName = 'Ciprian'
and SecondName = 'Domnica';
-- pas 2 selectez toti cumparatorii ce au cumparat din acelasi motiv
select * from buyer
where reason = (select reason from buyer
				where FirstName = 'Ciprian'
				and SecondName = 'Domnica');

-- 4.2 JOIN
-- 4.2.a)

-- sa se afiseze numele clientilor si platile efectuate pentru fiecare tip de apartament vandut (Atentie, nu si rezervat)

select * from apartment;

select b.FirstName, b.SecondName, p.amount, a.ap_type, p.rest_of_payment
	from apartment as a
		inner join buyer as b
			on b.id = a.id_buyer 
		inner join payment as p
			on a.id= p.id_apartment
		having p.rest_of_payment = '0';
	
-- 4.2.b) 
-- sa se afiseze toate apartmentele detinute de toti clientii (aplic conceptul de JOIN - inner)

select a.ap_type, b.FirstName, b.SecondName 
	from apartment as a
		join buyer as b
where a.id_buyer = b.id;

-- 4.3.c)
-- sa se afiseze numele clientilor care au cumparat apartamente mai scumpe de 60000;

select b.FirstName, b.SecondName,a.ap_type,a.price
	from apartment as a
		join buyer as b
			on b.id = a.id_buyer
	where price > 60000;


-- 4.3 FUNCTII DE GRUP/HAVING

-- 4.3.a) sa se afiseze cea mai scumpa si cea mai ieftina proprietate

select max(price) as pretmaxim, 
		min(price) as pretminim
        from apartment
where available='no';

-- 4.3.b)
-- sa se afiseze toate apartamentele disponibile cu pret descrescator mai sub 70000 Euro

select id, available,ap_type,ap_level,id_project_phase,price
from apartment
where available like 'yes'
Group by id, price having price < '100000'
order by price desc;


-- 4.3.c)
-- sa se afiseze cate apartamente disponibile mai scumpe de 60000 Euro sunt din fiecare categorie

select count(available) as ap_disponibile, price
from apartment
where available like 'yes'
group by price having price > '60000'
order by price;

-- 4.4 Functii predefinite MySQL, matematice, de comparare, conditionale, pentru siruri de caractere, pentru date calendaristice, 

-- 4.4.a)

-- sa se faca urmatoarea afirmatie in functie de apartamentele vandute sau nu: 
-- # Da  .... Apartamentul nu a fost vandut
-- # Nu  .... Apartamentul a fost vandut

select id, ap_type, price,
IF (available = 'yes', 
'Apartamentul nu a fost vandut',
'Apartamentul a fost vandut')
as status_apartamente from apartment;

-- 4.4.b)
-- sa se afiseze toate proprietatile cumparate in anul 2018 luna Mai;

select * from payment
where year(date_of_payment)='2018' and month(date_of_payment)='05';

-- 4.4.c)
-- sa se afiseze pentru fiecare client media de pret pentru apartamentele detinute 

select id_buyer, avg(price) as medie_pret_apartament
from apartment
where id_buyer is not null
group by id_buyer;

-- 4.4 d)

-- sa se afiseze primele doua initialele ale Numelui si Prenumelui in acelasi tabel
	-- pas 1 aflu intiala Numelui
    -- pas 2 aflu initiala Prenumelui
    -- pas 3 le vom concatena
    
    select id, FirstName, SecondName,
substr(FirstName,1,2)
from buyer;

  select id, FirstName, SecondName,
substr(SecondName,1,2)
from buyer;

select id, FirstName, SecondName,
concat(substr(FirstName,1,2),substr(SecondName,1,2))
from buyer;

-- 5 View -uri

-- 5.1 a)
-- Sa se creeze un view cu nume si prenume cumparatori cu motivul cumpararii apartamentelor
create view v$motiv_achizitie_locuinte as
select FirstName, SecondName, reason
from buyer;

select * from v$motiv_achizitie_locuinte;

-- 5.2.b)
-- Sa se creeze un view cu prin care se afiseaza clientii si apartamentele achizitionate de ei cat si data cumpararii;
create view v$data_achizitie_locuinte as
select b.FirstName, b.SecondName, a.ap_type, p.date_of_payment
	from apartment as a
		join buyer as b
			on a.id_buyer = b.id
		join payment as p
			on p.id_apartment = a.id
	where p.rest_of_payment = 0;
    
select * from v$data_achizitie_locuinte;

-- 6 Functii
-- 6.1 
-- Sa se creeze o functie care primeste un ID client si returneaza valoarea proprietatilor detinute
select * from buyer;
select * from apartment;
-- pas 1 imi creez select-ul respectiv;

select sum(price) as valoare_proprietati
from apartment where id_buyer = 6	

delimiter //
create function val_proprietati_investitor(id_client int)
				returns int
begin
-- declarare variabile
declare valoare_proprietati int;
-- scriu select-ul
select sum(price) into valoare_proprietati
from apartment where id_buyer = id_client;
-- ce returnez?
return valoare_proprietati;
end;
// delimiter ;

-- apelare
select val_proprietati_investitor(4);

-- 6.2
-- sa se creeze o functie care primeste id-ul unui investitor si returneaza mesaj in felul urmator:
-- daca numarul proprietatilor este = 1 "Clientul a rezervat sau detine o singura proprietate"
-- daca numarul proprietatilor este intre 2 si 3 "Clientul a rezervat sau detine doua sau trei proprietati"
-- daca numarul proprietatilor este mai mare decat 3 "Clienul a rezervat sau detine mai mult de trei proprietati"
-- in cazul in care id-ul nu exista sau nu este asociat nici unei inregistrari de proprietati "Clientul nu a rezervat si nu detine nici o proprietate"

delimiter //
create function status_proprietati_client (id_client tinyint) returns varchar(100)
begin
-- declaram variabile
	declare nr_proprietati int;
	declare status_proprietati_client varchar(100);
-- select-ul
	select count(id_buyer) into nr_proprietati
			from apartment 
			where id_buyer = id_client;
	if nr_proprietati = 1 then
		set status_proprietati_client = "Clientul a rezervat sau detine o singura proprietate";
	elseif nr_proprietati between 2 and 3 then
		set status_proprietati_client = "Clientul a rezervat sau detine doua sau trei proprietati";
	elseif 	nr_proprietati >3 then
		set status_proprietati_client = "Clienul a rezervat sau detine mai mult de trei proprietati";
	else set status_proprietati_client ="Clientul nu a rezervat si nu detine nici o proprietate";
	end if;
-- ce returnam
	return status_proprietati_client;
end;
// delimiter ;

select status_proprietati_client(5);
drop function status_proprietati_client;
select * from apartment;

-- 6.3 
-- sa se creeze o functie care in functie de bugetul clientului imi afiseaza 
-- cel mai scump tip de proprietate desponibil pe care il pot achizitiona;

select * from apartment;
select ap_type 
from apartment 
where price < 1000000 and id_buyer is null
order by price desc
limit 1;

delimiter //
create function proprietati_in_buget(buget int) returns varchar(50)
begin
	-- declaram variabile
    declare tip_proprietati varchar(50);
    -- select-ul
        select ap_type into tip_proprietati
			from apartment 
			where price < buget 
			and id_buyer is null
            order by price desc
            limit 1;
        -- ce returnez
	return tip_proprietati;
end;
// delimiter ;

select proprietati_in_buget(1000000);
SET GLOBAL log_bin_trust_function_creators = 1;
drop function proprietati_in_buget;

-- 7 PROCEDURI
-- 7.1 
-- sa se creeze  o procedura prin care se afiseaza numarul apartamentelor rezervate intr-un anumit an;

select * from reservation;
-- sa se afiseze numarul de apartamente rezervate in 2019
-- pas 1 creez selectul

select count(reservation_date) as nr_rezervari
from reservation
where year(reservation_date)=2019;

-- pas 2 creez procedura
-- sa se faca o procedura prin care se afiseaza numarul apartamentelor rezervate intr-un anumit an;

delimiter //
create procedure nr_rezervari(in an_rezervare int)
begin
select count(reservation_date) 
from reservation
where year(reservation_date)= an_rezervare;
end;
// delimiter ;
drop procedure nr_rezervari;
call nr_rezervari(2019);
select @numar_rezervari;

-- 7.2
-- sa se creeze o procedura care ofera date suplimentare(nume,prenume,nr_telefon,motiv_investitie) 
-- despre cumparatori dupa introducerea id-ul 
-- pas 1 creez selectul
select * from buyer;
select FirstName,SecondName, Telephone,Reason
from buyer
where id = 8;

-- pas 2 creez procedura

delimiter //
create procedure info_cumparator (in id_cumparator int, out nume varchar(50), out prenume varchar (50), 
									out nr_telefon int, out motiv_cumparare varchar(50))
begin
select FirstName,SecondName, Telephone, Reason
		into nume, prenume, nr_telefon, motiv_cumparare
        from buyer
where id = id_cumparator;
end;
// delimiter ;
drop procedure info_cumparator;

call info_cumparator(7, @nume, @prenume, @nr_telefon, @motiv_cumparare);
select @nume, @prenume, @nr_telefon, @motiv_cumparare;

-- 7.3
-- sa se creeze o procedura  care in functie de id-ul cumparatorului imi returneaza cati mp construiti si cati mp utili
-- sunt detinuti de clientul respectiv

-- pas 1 imi creez selectul
select sum(build_area), sum(util_area)
	 from apartment where id_buyer = 3;

-- pas 2 creez procedura
delimiter //
create procedure suprafeta_utila_client(in id_client int, suprafata_utila int)
begin
select sum(util_area) 
	into suprafata_utila
from apartment where id_buyer = id_client;
end;
// delimiter ;

call suprafeta_utila_client(5, @suprafata_utila);
select @suprafata_utila;
drop procedure suprafete_detinute_client;

-- 8 Cursori

-- 8.1 
-- sa se creeze faca o procedura prin care in fucntie de anul introdus imi afiseaza tipul de apartament vandut 
-- si data platii
-- pas 1 realizez select-ul

select a.ap_type, p.date_of_payment
	from apartment as a
		join payment as p
			on p.id_apartment = a.id
				where year(p.date_of_payment) = 2018;
-- pas 2 creez cursorul
delimiter //
create procedure cursor_an_ap_vandute(in an_vanzari year)
begin
-- declar variabilele
	declare v_data_plata date;
	declare v_tip_apartament varchar(50);
	declare semafor varchar(50) default'verde';
-- declar cursorul
	declare cursor1 cursor for select a.ap_type, p.date_of_payment 
										from apartment as a
											join payment as p
												on p.id_apartment = a.id
													where year(p.date_of_payment) = an_vanzari;
-- declar handler
declare continue handler for not found
	begin
		set semafor = 'rosu';
	end;
-- deschid cursorul
open cursor1;
bucla: loop
fetch cursor1
	into v_tip_apartament, v_data_plata;
-- conditia de oprire
		if (semafor = 'rosu') then leave bucla;
		end if;
-- prelucrare date returnate
if(year(v_data_plata) = an_vanzari) then
	select v_tip_apartament, v_data_plata;
    end if;
end loop bucla;
close cursor1;

end;
// delimiter ;
call cursor_an_ap_vandute(2019);
drop procedure cursor_an_ap_vandute;

-- 8.2 
-- sa se creeze o procedura folosind un cursor prin care introduc un id cumparator si imi afiseaza proprietatile detinute de acesta
-- pas 1 realizez selectul
select ap_type from apartment where id_buyer = 1;

delimiter //
create procedure cursor_lista_proprietati(in id_client int)
begin
-- declar variabile
declare v_id_buyer int;
declare v_proprietati_detinute varchar(50);
declare semafor varchar(50) default 'verde';
-- declar cursor
declare cursor2 cursor for select ap_type , id_buyer
							from apartment;
-- declar handler
declare continue handler for not found
-- contitia de oprire
	begin
		set semafor = 'rosu';
    end;
-- deschid cursorul
open cursor2;
	bucla: loop
		fetch cursor2 into v_proprietati_detinute, v_id_buyer;
        -- conditia de oprire
			if (semafor = 'rosu') then
            leave bucla;
            end if;
		-- afisez selectul
			if v_id_buyer = id_client then
			select v_proprietati_detinute;
			end if;
	end loop;
close cursor2;
end;

// delimiter ;

call cursor_lista_proprietati(5);
drop procedure cursor_lista_proprietati;

-- 8.3
-- sa se creeze o procedura care returneaza toate apartamentele in functie de id_ul fazei

delimiter //
create procedure apartamente_pe_faza(in id_faza int) 
begin
declare v_id_faza int;
declare v_tip_ap varchar(255);
declare semafor varchar(255) default 'verde';
declare c3 cursor for select ap_type, id_project_phase from apartment where id_project_phase = id_faza;
declare continue handler for not found 
	begin
		set semafor = 'rosu';
	end;
	open c3;
		bucla: loop
		fetch c3 into v_tip_ap, v_id_faza;
			if semafor = 'rosu' then leave bucla;
			end if;
			if v_id_faza = id_faza then
			select v_tip_ap, v_id_faza;
			end if;
		end loop;
	close c3;
end;
// delimiter ;

call apartamente_pe_faza(2);
SET GLOBAL log_bin_trust_function_creators = 1;
drop procedure apartamente_pe_faza;

-- 9 TRIGGERI
-- 9.1 - INSERT 
-- sa se creeze o tabela evidenta clienti pentru toti clientii noi introdusi in tabela buyer 
-- tabela afiseaza un mesaj ce contine id-ul, numele si prenumele clientului cat si data inregistrarii;

create table evidenta_clienti_noi(
			id int primary key auto_increment,
            text_inregistrare varchar(255),
            data_incregistrare date);

delimiter //
create trigger evidenta_clienti after insert on buyer
for each row
begin
declare v_inregistrari varchar(255);
set v_inregistrari = concat(new.ID,' ',new.FirstName,' ',new.SecondName);
insert into evidenta_clienti_noi values (null, v_inregistrari, current_date());
end;
// delimiter ;
insert into buyer values (null, 'Daniel','Cojocaru', '0740125321','developer','for_rent','Bucharest');
select * from buyer;
select * from evidenta_clienti_noi;
show triggers from real_estate_project;

-- 9.2 UPDATE

-- sa se faca un trigger pt update-ul tabelei APARTMENT in care imi tine evidenta preturilor vechi si noi si data modificarii

create table evidenta_preturi_locuinte (
id int auto_increment primary key,
evidenta_preturi varchar(255),
data_modificare_preturi date
);

delimiter //
create trigger evidenta_preturi after update on apartment
for each row
begin
declare v_pret_vechi varchar(255);
declare v_pret_nou varchar(255);
declare v_evidenta_pret_inserat varchar(255);
set v_pret_vechi = concat('***',old.id,' ',old.ap_type,' ',old.price,' ',old.id_project_phase,'***');
set v_pret_nou = concat('***',new.id,' ',new.ap_type,' ',new.price,' ',new.id_project_phase,'***');
set v_evidenta_pret_inserat = concat('Pretul pentru locuinta', v_pret_vechi, 'a devenit', v_pret_nou);
insert into evidenta_preturi_locuinte values (null, v_evidenta_pret_inserat, current_date());
end;
// delimiter ;

select * from evidenta_preturi_locuinte;
Select * from apartment;

update apartment
set price = 1.1*price 
where ap_type = '4_room_ap' and 
id_project_phase = 4;

-- 9.3 DELETE
-- -- sa se creeze o tabela evidenta fosti clienti pentru toti clientii stersi din tabela buyer
-- tabela afiseaza un mesaj ce contine id-ul, numele si prenumele clientului cat si data inregistrarii;

create table evidenta_clienti_stersi(
			id int primary key auto_increment,
            text_inregistrare varchar(255),
            data_incregistrare date);
            
delimiter //
create trigger evidenta_clienti_stersi after delete on buyer
for each row
begin
declare v_inregistrari varchar(255);
set v_inregistrari = concat(old.ID,' ',old.FirstName,' ',old.SecondName);
insert into evidenta_clienti_stersi values (null, v_inregistrari, current_date());
end;
// delimiter ;

drop trigger evidenta_clienti_stersi;
delete from buyer where id = 12;
select * from evidenta_clienti_stersi;
select * from buyer;