--create database havaalaniRezervasyon
use havaalaniRezervasyon

--her execute yapýldýðýnda tablolarý siler
drop table if exists rezervasyon;
drop table if exists ucak;
drop table if exists havalimani;
drop table if exists sehir;
drop table if exists ulke;
drop table if exists sinif;
drop table if exists pilot;
drop table if exists yolcu;

--ucak adli bir tablo olusturur
create table ucak(
	ucakID int not null primary key,
	firma nvarchar(40) not null,
	kapasite int  not null check(kapasite >= 0 and kapasite <= 175)
);

--ulke adli bir tablo olusturur
create table ulke(
	ulkeID int not null primary key,
	ulke_adi varchar(30) not null
);

--sehir adli bir tablo olusturur
create table sehir(
	sehirID int not null primary key,
	sehir_adi varchar(30) not null,
	ulkeID int not null,
	constraint fk_ulkeID2 foreign key (ulkeID)
	references ulke(ulkeID)
);

--havalimani adli bir tablo olusturur
create table havalimani(
	havalimaniID int not null primary key,
	havalimani_adi varchar(40) not null,
	sehirID int not null,
	ulkeID int not null,
	constraint fk_sehirID foreign key (sehirID)
	references sehir(sehirID),
	constraint fk_ulkeID foreign key (ulkeID)
	references ulke(ulkeID)
);

--sinif adli bir tablo olusturur
create table sinif(
	sinifID int not null primary key,
	tip char(20) not null
);

--pilot adli bir tablo olusturur
create table pilot(
	pilotID int not null primary key,
	tc bigint unique not null check(tc >= 10000000000 and tc <= 99999999999),
	cinsiyet nvarchar(10) not null,
	adi nvarchar(20) not null,
	soyadi nvarchar(30) not null,
	maas decimal(12, 2) NOT NULL check(maas >= 0)
);

--yolcu adli bir tablo olusturur
create table yolcu(
	yolcuID int not null primary key,
	tc bigint unique not null check(tc >= 10000000000 and tc <= 99999999999),
	cinsiyet nvarchar(10) not null,
	ad nvarchar(20) not null,
	soyad nvarchar(30) not null,
	telefon bigint unique not null check(telefon >= 1000000000 and telefon <= 9999999999),
	mail nvarchar(50) unique not null
);

--rezervasyon adli bir tablo olusturur
create table rezervasyon(
	rezervasyonID int not null primary key,
	yolcuID int not null,
	sinifID int not null,
	ucakID int not null,
	pilotID int not null,
	fiyat money not null check(fiyat >= 0),
	kalkisHavID int not null,
	varisHavID int not null,
	kalkisTarih date not null check(kalkisTarih >= '2022-01-06'),
	kalkisZaman time not null check(kalkisZaman >= '12:00:00'),
	varisTarih date not null check(varisTarih >= '2022-01-06'),
	varisZaman time not null check(varisZaman >= '12:00:00'),
	constraint fk_yolcuID foreign key (yolcuID)
	references yolcu(yolcuID),
	constraint fk_sinifID foreign key (sinifID)
	references sinif(sinifID),
	constraint fk_ucakID foreign key (ucakID)
	references ucak(ucakID),
	constraint fk_pilotID foreign key (pilotID)
	references pilot(pilotID),
	constraint fk_kalkisHavID foreign key (kalkisHavID)
	references havalimani(havalimaniID),
	constraint fk_varisHavID foreign key (varisHavID)
	references havalimani(havalimaniID)
);

--ucak tablosunun verileri
insert into ucak(ucakID, firma, kapasite) values 
(01,'Pegasus','170'),
(02,'KatarAirways','160'),
(03,'EVAAir','175'),
(04,'TurkishAirlines','170'),
(05,'SingaporeAirlines','155'),
(06,'Emirates','165'),
(07,'BritishAirways','145'),
(08,'AirAsia','140'),
(09,'AirFrance','159'),
(10,'Aeroflot','164'),
(11,'AirCanada','173')
go

--ulke tablosunun verileri
insert into ulke(ulkeID, ulke_adi) values 
(01,'Turkiye'),
(02,'Katar'),
(03,'Tayvan'),
(04,'Singapur'),
(05,'BAE'),
(06,'BirlesikKrallýk'),
(07,'Malezya'),
(08,'Fransa'),
(09,'Rusya'),
(10,'Kanada')
go

--sinif tablosunun verileri
insert into sinif(sinifID, tip) values 
(01,'ECOFLY'),
(02,'EXTRAFLY'),
(03,'PRIMEFLY'),
(04,'BUSINESS')
go

--pilot tablosunun verileri
insert into pilot(pilotID, tc, cinsiyet, adi, soyadi, maas) values 
(01,12345678910,'E','Anil','Bora',25000),
(02,31000700009,'E','Aaron','Hansen',22500),
(03,41000800008,'K','Mia','Gui',18000),
(04,51000090008,'E','Barin','Telli',18500),
(05,61000060007,'K','Emma','Novak',22000),
(06,71000010006,'E','Alvin','Rossi',28000),
(07,81000020005,'K','Isla','Smith',26000),
(08,91000030004,'E','Derek','Wilson',21000),
(09,10000040003,'K','Lina','Martin',22500),
(10,11000050002,'K','Kavya','Ivanov',20000),
(11,28596547530,'E','Vicky','Lavato',19500)
go

--sehir tablosunun verileri
insert into sehir(sehirID, ulkeID, sehir_adi) values 
(01,01,'Istanbul'),
(02,01,'Ankara'),
(03,01,'Izmir'),
(04,01,'Antalya'),
(05,01,'Trabzon'),
(06,01,'Gaziantep'),
(07,01,'Diyarbakýr'),
(08,01,'Mugla'),
(09,01,'Adana'),
(10,01,'Kars'),
(11,02,'Doha'),
(12,03,'Taipei'),
(13,03,'Taoyuan'),
(14,04,'Singapur'),
(15,05,'Dubai'),
(16,05,'AbuDabi'),
(17,06,'Londra'),
(18,06,'Manchester'),
(19,06,'Luton'),
(20,06,'Edinburgh'),
(21,06,'Essex'),
(22,06,'Liverpool'),
(23,06,'Belfast'),
(24,07,'KotaKinabalu'),
(25,07,'KualaLumpur'),
(26,08,'Paris'),
(27,08,'Nice'),
(28,08,'Marsilya'),
(29,08,'Lyon'),
(30,08,'Strazburg'),
(31,09,'Moskova'),
(32,09,'Yakutsk'),
(33,09,'Soci'),
(34,10,'Toronto'),
(35,10,'Nunavut'),
(36,10,'Alberta')
go

--yolcu tablosunun verileri
insert into yolcu(yolcuID, tc, cinsiyet, ad, soyad, telefon, mail) values 
(001,22456106255,'K','Euphemia','London',05404042325,'euphemiaglazier@gmail.com'),
(002,50753337659,'K','Danica','London',05431904116,'danicalondon@yandex.com'),
(003,38735528574,'E','Bryn','Robert',05399990448,'brynrobert@yandex.com'),
(004,94736119879,'E','Kennith','Lynn',05455040038,'kennithlynn@outlook.com'),
(005,22066026836,'K','Githa','Dexter',05456860384,'githadexter@yandex.com'),
(006,60000897460,'E','Breanne','Emerson',05446491068,'breanneemerson@icloud.com'),
(007,53261171718,'E','Ayden','Hershey',05356319365,'aydenhershey@yahoo.com'),
(008,25128248174,'K','Issy','Womack',05456086619,'issywomack@yandex.com'),
(009,16379541046,'E','Karter','Smalls',05427712386,'kartersmalls@outlook.com'),
(010,78433645510,'K','Darren','Otis',05447599585,'darrenotis@icloud.com'),
(011,77578927809,'K','Ophelia','Ellisson',05426916069,'opheliaellisson@gmail.com'),
(012,15140988807,'E','Vern','Hayes',05434536038,'vernhayes@yahoo.com'),
(013,73594750989,'E','Fitzroy','Weaver',05429722573,'fitzroyweaver@hotmail.com'),
(014,73842299418,'E','Jarvis','Rickard',05375291484,'jarvisrickard@icloud.com'),
(015,99468355112,'E','Everard','Samson',05437734441,'everardsamson@yahoo.com'),
(016,71776973504,'E','Read','Atteberry',05382084692,'readatteberry@gmail.com'),
(017,36485383526,'E','Ben','Humphrey',05441350637,'benhumphrey@outlook.com'),
(018,49179958113,'K','Slade','Gilliam',05414550554,'sladegilliam@gmail.com'),
(019,64718002257,'K','Jonah','King',05351225924,'jonahking@hotmail.com'),
(020,83207585186,'K','Zeph','Lynwood',05459151850,'zephlynwood@outlook.com'),
(021,52246696804,'E','Amber','Beck',05312564588,'amberbeck@yandex.com'),
(022,32185055434,'E','Kali','Colton',05348520603,'kalicolton@icloud.com'),
(023,86382442108,'K','Mariah','Mark',05452496953,'mariahmark@yandex.com'),
(024,88339772134,'K','Iris','Hext',05412629744,'irishext@yahoo.com'),
(025,73562070633,'E','Rodger','Emmet',05305072881,'rodgeremmet@icloud.com'),
(026,11611750038,'K','Melba','Gabriels',05416104340,'melbagabriels@hotmail.com'),
(027,61426925095,'K','Jennica','Bray',05329105597,'jennicabray@outlook.com'),
(028,28563843146,'E','Sonny','Herbertson',05413862993,'sonnyherbertson@outlook.com'),
(029,46396667285,'K','Aidan','Ruskin',05434326055,'aidanruskin@gmail.com'),
(030,25683373240,'E','Shannon','Lewin',05418274128,'shannonlewin@yahoo.com'),
(031,23136523709,'E','Bethanie','Cook',05371394298,'bethaniecook@hotmail.com'),
(032,99982059130,'K','Haylee','Nowell',05438234071,'hayleenowell@hotmail.com'),
(033,42616572453,'E','Marcus','Tyrrell',05393074441,'marcustyrrell@hotmail.com'),
(034,69455909768,'K','Tonya','Hext',05366059983,'tonyahext@gmail.com'),
(035,85523322172,'K','Lally','Pierce',05404227519,'lallypierce@yandex.com'),
(036,91998360901,'K','Larissa','Linton',05424323141,'larissalinton@icloud.com'),
(037,57675303445,'E','Freddie','Traviss',05323876952,'freddietraviss@icloud.com'),
(038,80879167592,'E','Bart','Kersey',05393890839,'bartkersey@outlook.com'),
(039,40559491288,'K','Madelina','Reeves',05389745385,'madelinareeves@yandex.com'),
(040,56327519997,'E','Nyree','Jacobson',05303769566,'nyreejacobson@hotmail.com'),
(041,49446596132,'K','Duana','Norton',05353862949,'duananorton@icloud.com'),
(042,74391234554,'K','Sybil','Todd',05351155160,'sybiltodd@hotmail.com'),
(043,81841928240,'E','Joye','Frank',05455348604,'joyefrank@hotmail.com'),
(044,25625419037,'E','Christie','Hayley',05347451449,'christiehayley@hotmail.com'),
(045,85756802675,'K','Melissa','Bunker',05348424283,'melissabunker@yahoo.com'),
(046,97039027845,'K','Sophy','Atwood',05451187129,'sophyatwood@icloud.com'),
(047,72857941202,'K','Barbara','Sawyer',05383754259,'barbarasawyer@outlook.com'),
(048,63848938991,'K','Kathi','Lincoln',05458262677,'kathilincoln@hotmail.com'),
(049,63541220044,'K','Jeanie','Snyder',05333362208,'jeaniesnyder@icloud.com'),
(050,86174734205,'E','Hortense','Waterman',05385435441,'hortensewaterman@yahoo.com'),
(051,60191888066,'E','Joby','Butts',05359698508,'jobybutts@gmail.com'),
(052,64505734701,'K','Laurie','Way',05311898131,'laurieway@outlook.com'),
(053,67666550614,'K','Lesia','Quincy',05385654722,'lesiaquincy@yahoo.com'),
(054,91304192316,'K','Jazlyn','Evered',05336203879,'jazlynevered@outlook.com'),
(055,82250537581,'K','Merrick','Solomon',05424680529,'merricksolomon@icloud.com'),
(056,41957690569,'E','Piety','Gore',05365885415,'pietygore@gmail.com'),
(057,50031887467,'K','Elvin','Hermanson',05315590700,'elvinhermanson@hotmail.com'),
(058,21693725595,'K','Nelle','Breckenridge',05437417345,'nellebreckenridge@hotmail.com'),
(059,79108325220,'E','Jonathan','Hampton',05318754262,'jonathanhampton@icloud.com'),
(060,99271258597,'E','Everard','Elliston',05393111343,'everardelliston@yahoo.com'),
(061,93498643318,'E','Briscoe','Swindlehurst',05374675618,'briscoeswindlehurst@yandex.com'),
(062,84789981754,'E','Walter','Humphrey',05328290294,'walterhumphrey@icloud.com'),
(063,65957009121,'E','Winton','Bonham',05341683610,'wintonbonham@yahoo.com'),
(064,68801888649,'K','Manny','Sims',05352001884,'mannysims@gmail.com'),
(065,72707020297,'K','Milo','Anthonyson',05357298086,'miloanthonyson@outlook.com'),
(066,76216982694,'K','Kyro','Cocks',05399935726,'kyrococks@gmail.com'),
(067,10222458699,'K','Jaiden','Ackerman',05324466298,'jaidenackerman@yahoo.com'),
(068,57625300697,'E','Ken','Mayes',05401591296,'kenmayes@gmail.com'),
(069,83384412538,'K','Darrell','Sams',05373070975,'darrellsams@yandex.com'),
(070,85361163335,'K','Roosevelt','Kendal',05354489498,'rooseveltkendal@yahoo.com'),
(071,22257137660,'K','Kiera','Yates',05345355172,'kierayates@outlook.com'),
(072,20540934759,'E','Barb','Irwin',05457148647,'barbirwin@outlook.com'),
(073,33853100115,'E','Colton','Samuels',05317406136,'coltonsamuels@yahoo.com'),
(074,72750539201,'K','Rafferty','Edison',05408471334,'raffertyedison@yandex.com'),
(075,10051743116,'K','Kylie','Falconer',05418397351,'kyliefalconer@yandex.com'),
(076,57537608707,'K','Edgar','Denzil',05424543686,'edgardenzil@outlook.com'),
(077,40495942737,'E','Denny','Belanger',05363787069,'dennybelanger@yandex.com'),
(078,60652560798,'E','Ryan','Christophers',05303645978,'ryanchristophers@yandex.com'),
(079,60295281280,'K','Sorrel','Low',05366141504,'sorrellow@icloud.com'),
(080,31458784733,'E','Jax','Richardson',05421985916,'jaxrichardson@yandex.com'),
(081,53451298731,'E','Roscoe','Sergeant',05335599945,'roscoesergeant@yandex.com'),
(082,92813502957,'K','Ian','Irvin',05431322051,'ianirvin@hotmail.com'),
(083,99988120903,'E','Reilly','Eliott',05414004907,'reillyeliott@hotmail.com'),
(084,11567054493,'K','Sharla','Blue',05314814602,'sharlablue@gmail.com'),
(085,82429226132,'K','Ness','Jefferson',05346358552,'nessjefferson@icloud.com'),
(086,57327538233,'K','Elicia','Wilson',05323627074,'eliciawilson@outlook.com'),
(087,59036329357,'E','Robin','Beck',05428840190,'robinbeck@hotmail.com'),
(088,22040894621,'K','Alva','Leonard',05367773869,'alvaleonard@yahoo.com'),
(089,86829618888,'E','Cosmo','Marshall',05304796766,'cosmomarshall@yandex.com'),
(090,59091371225,'E','Nick','Ryley',05365262737,'nickryley@yahoo.com'),
(091,33550662996,'K','Thelma','Chase',05401298959,'thelmachase@gmail.com'),
(092,17264200099,'K','Edythe','Carlyle',05415014635,'edythecarlyle@gmail.com'),
(093,16669294015,'K','Cy','Huddleson',05443009734,'cyhuddleson@outlook.com'),
(094,18088130805,'K','Emmalyn','Lindsey',05451181709,'emmalynlindsey@icloud.com'),
(095,35424792429,'E','Ryann','Wiley',05426297481,'ryannwiley@gmail.com'),
(096,25581003711,'K','Elsabeth','Stanton',05436832083,'elsabethstanton@icloud.com'),
(097,79424637201,'E','Norton','London',05319639587,'nortonlondon@yahoo.com'),
(098,12466899195,'K','Gale','Milford',05395725214,'galemilford@hotmail.com'),
(099,17822380432,'E','Ronnie','Hodges',05425444935,'ronniehodges@outlook.com'),
(100,23341649179,'K','June','Rodgers',05336204262,'junerodgers@gmail.com')
go

--havalimani tablosunun verileri
insert into havalimani(havalimaniID, sehirID, ulkeID, havalimani_adi) values 
(01,01,01,'Istanbul_Havalimani'),
(02,01,01,'Sabiha_Gokcen_Havalimani'),
(03,02,01,'Esenboga_Havalimani'),
(04,03,01,'Adnan_Menderes_Havalimani'),
(05,04,01,'Antalya_Havalimani'),
(06,04,01,'Gazipasa_Havalimani'),
(07,05,01,'Trabzon_Havalimani'),
(08,06,01,'Gaziantep_Havalimani'),
(09,07,01,'Diyarbakýr_Havalimani'),
(10,08,01,'Dalaman_Havalimani'),
(11,08,01,'Milas-Bodrum_Havalimani'),
(12,09,01,'Sakirpasa_Havalimani'),
(13,10,01,'Kars_Harakani_Havalimani'),
(14,11,02,'Doha_Havalimani'),
(15,12,03,'Taipei_Songshan_Havalimani'),
(16,13,03,'Tayvan_Taoyuan_Havalimani'),
(17,14,04,'Singapur_Changi_Havalimani'),
(18,15,05,'Dubai_Havalimani'),
(19,15,05,'Dubai_World_Central'),
(20,16,05,'Abu_Dabi_Havalimani'),
(21,17,06,'Londra_City_Havalimani'),
(22,18,06,'Manchester_Havalimani'),
(23,19,06,'Luton_Havalimani'),
(24,20,06,'Edinburgh_Havalimani'),
(25,21,06,'Londra_Southend_Havalimani'),
(26,22,06,'Liverpool_John_Lennon_Havalimani'),
(27,23,06,'George_Best_Belfast_City_Havalimani'),
(28,24,07,'Kota_Kinabalu_Havalimani'),
(29,25,07,'Kuala_Lumpur_Havalimani'),
(30,26,08,'Paris_Charles_de_Gaulle_Havalimani'),
(31,26,08,'Paris_Orly_Havalimani'),
(32,27,08,'Nice_Havalimani'),
(33,28,08,'Marseille_Provence_Havalimani'),
(34,29,08,'Lyon–Saint-Exupéry_Havalimani'),
(35,30,08,'Strazburg_Havalimani'),
(36,31,09,'Moskova_Sheremetyevo_Havalimani'),
(37,31,09,'Moskova_Domodedovo_Havalimani'),
(38,31,09,'Moskova_Vnukovo_Havalimani'),
(39,32,09,'Yakutsk_Havalimani'),
(40,33,09,'Soci_Havalimani'),
(41,34,10,'Toronto_Pearson_Havalimani'),
(42,34,10,'Iglulik_Havalimani'),
(43,34,10,'Swans_Havalimani')
go

--rezervasyon tablosunun verileri
insert into rezervasyon(rezervasyonID, yolcuID, sinifID, ucakID, pilotID, fiyat, kalkisHavID, varisHavID, kalkisTarih, kalkisZaman, varisTarih, varisZaman) values 
(001,001,01,01,01,300,01,09,'2022-01-06','12:30:00','2022-01-06','13:30:00'),
(002,002,02,01,03,350,01,09,'2022-01-06','12:30:00','2022-01-06','13:30:00'),
(003,003,03,01,01,400,01,09,'2022-01-06','12:30:00','2022-01-06','13:30:00'),
(004,004,04,01,02,500,01,09,'2022-01-06','12:30:00','2022-01-06','13:30:00'),
(005,005,04,02,01,300,02,05,'2023-01-06','13:00:00','2023-01-06','14:00:00'),
(006,006,02,02,02,350,02,05,'2023-01-06','13:00:00','2023-01-06','14:00:00'),
(007,007,03,02,04,400,02,05,'2023-01-06','13:00:00','2023-01-06','14:00:00'),
(008,008,04,02,02,500,02,05,'2023-01-06','13:00:00','2023-01-06','14:00:00'),
(009,009,01,03,03,300,03,04,'2024-01-06','15:30:00','2024-01-06','16:30:00'),
(010,010,02,03,01,350,03,04,'2024-01-06','15:30:00','2024-01-06','16:30:00'),
(011,011,04,03,03,400,06,09,'2024-01-06','15:30:00','2024-01-06','16:30:00'),
(012,012,04,03,05,500,03,04,'2024-01-06','15:30:00','2024-01-06','16:30:00'),
(013,013,01,04,04,300,07,08,'2025-01-07','12:30:00','2025-01-07','13:30:00'),
(014,014,02,04,05,350,03,04,'2025-01-07','12:30:00','2025-01-07','13:30:00'),
(015,015,03,04,04,400,07,08,'2025-01-07','12:30:00','2025-01-07','13:30:00'),
(016,016,04,04,06,500,07,08,'2025-01-07','12:30:00','2025-01-07','13:30:00'),
(017,017,01,05,05,300,09,10,'2026-01-07','13:00:00','2026-01-07','14:00:00'),
(018,018,04,05,06,350,09,10,'2026-01-07','13:00:00','2026-01-07','14:00:00'),
(019,019,03,05,05,400,09,10,'2026-01-07','13:00:00','2026-01-07','14:00:00'),
(020,020,04,05,07,500,09,10,'2026-01-07','13:00:00','2026-01-07','14:00:00'),
(021,021,01,06,06,300,11,12,'2025-01-07','15:30:00','2022-01-07','16:30:00'),
(022,022,02,06,07,350,11,12,'2024-01-07','15:30:00','2024-01-07','16:30:00'),
(023,023,03,06,06,400,11,12,'2024-01-07','15:30:00','2024-01-07','16:30:00'),
(024,024,04,06,08,500,11,12,'2024-01-07','15:30:00','2024-01-07','16:30:00'),
(025,025,01,07,07,1300,13,14,'2022-01-08','12:30:00','2022-01-08','13:30:00'),
(026,026,02,07,09,1450,13,14,'2022-01-08','12:30:00','2022-01-08','13:30:00'),
(027,027,03,07,07,1600,13,14,'2022-01-08','12:30:00','2022-01-08','13:30:00'),
(028,028,04,07,05,1800,13,14,'2022-01-08','12:30:00','2022-01-08','13:30:00'),
(029,029,01,08,08,1300,14,15,'2022-01-08','13:00:00','2022-01-08','14:00:00'),
(030,030,02,08,09,1450,14,15,'2022-01-08','13:00:00','2022-01-08','14:00:00'),
(031,031,03,08,08,1600,14,15,'2022-01-08','13:00:00','2022-01-08','14:00:00'),
(032,032,04,08,10,1800,14,15,'2022-01-08','13:00:00','2022-01-08','14:00:00'),
(033,033,04,09,09,1300,16,17,'2022-01-08','15:30:00','2022-01-08','16:30:00'),
(034,034,02,09,11,1450,16,17,'2022-01-08','15:30:00','2022-01-08','16:30:00'),
(035,035,03,09,09,1600,16,17,'2022-01-08','15:30:00','2022-01-08','16:30:00'),
(036,036,04,09,01,1800,16,17,'2022-01-08','15:30:00','2022-01-08','16:30:00'),
(037,037,01,10,09,1300,18,21,'2022-01-09','12:30:00','2022-01-09','13:30:00'),
(038,038,02,10,10,1450,18,21,'2022-01-09','12:30:00','2022-01-09','13:30:00'),
(039,039,04,10,11,1600,18,21,'2022-01-09','12:30:00','2022-01-09','13:30:00'),
(040,040,04,10,10,1800,18,21,'2022-01-09','12:30:00','2022-01-09','13:30:00'),
(041,041,01,11,11,1300,19,22,'2022-01-09','13:00:00','2022-01-09','14:00:00'),
(042,042,02,11,10,1450,19,22,'2022-01-09','13:00:00','2022-01-09','14:00:00'),
(043,043,03,11,11,1600,19,22,'2022-01-09','13:00:00','2022-01-09','14:00:00'),
(044,044,04,11,05,1800,19,22,'2022-01-09','13:00:00','2022-01-09','14:00:00'),
(045,045,01,01,01,1300,20,23,'2022-01-09','15:30:00','2022-01-09','16:30:00'),
(046,046,02,01,09,1450,20,23,'2022-01-09','15:30:00','2022-01-09','16:30:00'),
(047,047,03,01,01,1600,20,23,'2022-01-09','15:30:00','2022-01-09','16:30:00'),
(048,048,04,01,08,1800,20,23,'2022-01-09','15:30:00','2022-01-09','16:30:00'),
(049,049,01,02,02,1300,24,28,'2022-01-10','12:30:00','2022-01-10','13:30:00'),
(050,050,02,02,07,1450,24,28,'2022-01-10','12:30:00','2022-01-10','13:30:00'),
(051,051,03,02,02,1600,24,28,'2022-01-10','12:30:00','2022-01-10','13:30:00'),
(052,052,04,02,06,1800,24,28,'2022-01-10','12:30:00','2022-01-10','13:30:00'),
(053,053,01,03,03,1300,25,29,'2022-01-10','13:00:00','2022-01-10','14:00:00'),
(054,054,02,03,05,1450,25,29,'2022-01-10','13:00:00','2022-01-10','14:00:00'),
(055,055,01,03,03,1600,25,29,'2022-01-10','13:00:00','2022-01-10','14:00:00'),
(056,056,04,03,04,1800,25,29,'2022-01-10','13:00:00','2022-01-10','14:00:00'),
(057,057,01,04,04,1300,26,30,'2022-01-10','15:30:00','2022-01-10','16:30:00'),
(058,058,02,04,03,1450,26,30,'2022-01-10','15:30:00','2022-01-10','16:30:00'),
(059,059,03,04,04,1600,26,30,'2022-01-10','15:30:00','2022-01-10','16:30:00'),
(060,060,04,04,02,1800,26,30,'2022-01-10','15:30:00','2022-01-10','16:30:00'),
(061,061,01,05,05,1300,27,31,'2022-01-11','12:30:00','2022-01-11','13:30:00'),
(062,062,02,05,01,1450,27,31,'2022-01-11','12:30:00','2022-01-11','13:30:00'),
(063,063,03,05,05,1600,27,31,'2022-01-11','12:30:00','2022-01-11','13:30:00'),
(064,064,04,05,10,1800,27,31,'2022-01-11','12:30:00','2022-01-11','13:30:00'),
(065,065,01,06,06,1300,32,36,'2022-01-11','13:00:00','2022-01-11','14:00:00'),
(066,066,02,06,11,1450,32,36,'2022-01-11','13:00:00','2022-01-11','14:00:00'),
(067,067,03,06,06,1600,32,36,'2022-01-11','13:00:00','2022-01-11','14:00:00'),
(068,068,04,06,09,1800,32,36,'2022-01-11','13:00:00','2022-01-11','14:00:00'),
(069,069,01,07,07,1300,33,37,'2022-01-11','15:30:00','2022-01-11','16:30:00'),
(070,070,03,07,08,1450,33,37,'2022-01-11','15:30:00','2022-01-11','16:30:00'),
(071,071,03,07,07,1600,33,37,'2022-01-11','15:30:00','2022-01-11','16:30:00'),
(072,072,04,07,01,1800,33,37,'2022-01-11','15:30:00','2022-01-11','16:30:00'),
(073,073,01,08,08,1300,34,38,'2022-01-12','12:30:00','2022-01-12','13:30:00'),
(074,074,02,08,07,1450,34,38,'2022-01-12','12:30:00','2022-01-12','13:30:00'),
(075,075,03,08,08,1600,34,38,'2022-01-12','12:30:00','2022-01-12','13:30:00'),
(076,076,04,08,03,1800,34,38,'2022-01-12','12:30:00','2022-01-12','13:30:00'),
(077,077,01,09,09,1300,35,39,'2022-01-12','13:00:00','2022-01-12','14:00:00'),
(078,078,02,09,05,1450,35,39,'2022-01-12','13:00:00','2022-01-12','14:00:00'),
(079,079,03,09,09,1600,35,39,'2022-01-12','13:00:00','2022-01-12','14:00:00'),
(080,080,04,09,02,1800,35,39,'2022-01-12','13:00:00','2022-01-12','14:00:00'),
(081,081,01,10,10,1300,40,41,'2022-01-12','15:30:00','2022-01-12','16:30:00'),
(082,082,03,10,11,1450,40,41,'2022-01-12','15:30:00','2022-01-12','16:30:00'),
(083,083,03,10,10,1600,40,41,'2022-01-12','15:30:00','2022-01-12','16:30:00'),
(084,084,04,10,06,1800,40,41,'2022-01-12','15:30:00','2022-01-12','16:30:00'),
(085,085,01,11,11,1300,42,01,'2022-01-13','12:30:00','2022-01-13','13:30:00'),
(086,086,02,11,07,1450,42,01,'2022-01-13','12:30:00','2022-01-13','13:30:00'),
(087,087,03,11,11,1600,42,01,'2022-01-13','12:30:00','2022-01-13','13:30:00'),
(088,088,04,11,08,1800,42,01,'2022-01-13','12:30:00','2022-01-13','13:30:00'),
(089,089,02,01,01,1300,43,21,'2022-01-13','13:00:00','2022-01-13','14:00:00'),
(090,090,02,01,03,1450,43,21,'2022-01-13','13:00:00','2022-01-13','14:00:00'),
(091,091,03,01,01,1600,43,21,'2022-01-13','13:00:00','2022-01-13','14:00:00'),
(092,092,04,01,05,1800,43,21,'2022-01-13','13:00:00','2022-01-13','14:00:00'),
(093,093,01,02,02,1300,30,17,'2022-01-13','15:30:00','2022-01-13','16:30:00'),
(094,094,02,02,01,1450,30,17,'2022-01-13','15:30:00','2022-01-13','16:30:00'),
(095,095,03,02,02,1600,30,17,'2022-01-13','15:30:00','2022-01-13','16:30:00'),
(096,096,04,02,06,1800,30,17,'2022-01-13','15:30:00','2022-01-13','16:30:00'),
(097,097,01,03,03,1300,36,18,'2022-01-14','15:30:00','2022-01-14','16:30:00'),
(098,098,02,03,09,1450,36,18,'2022-01-14','15:30:00','2022-01-14','16:30:00'),
(099,099,03,03,03,1600,36,18,'2022-01-14','15:30:00','2022-01-14','16:30:00'),
(100,100,04,03,04,1800,36,18,'2022-01-14','15:30:00','2022-01-14','16:30:00')
go

--trigger kodlari
--sinif tablosunda ki turlari silmez
create trigger turSilinmez on sinif
	instead of delete
as
begin
	raiserror('sinif Tablosu icinden kayit silmez',1,1)
	rollback transaction
end
 
delete from sinif
 
select *from sinif
go

--maasi 30000 den fazla olan pilot kaydetmez
create trigger pilotMaas on pilot
	after insert
as
	if(exists(select *from inserted
	where maas>30000))
begin
  raiserror('Maasi 30000 TL den fazla olan pilot kaydedilemez!!',1,1);
  rollback transaction
end

select *from pilot
go

--yolcu eklerken bunun daha once kullanilan bir id olup olmadigi bakilir
create trigger listele on yolcu
	after insert
as
	if(exists(select *from inserted, yolcu
	where yolcu.yolcuID != inserted.yolcuID))
begin
	raiserror ('Daha once kullanilan bir id girildi.!!', 16, 1);
	rollback transaction
end

insert into yolcu(yolcuID, tc, ad, soyad, telefon, mail) values
(101, 35975289654, 'Craig', 'García', 08549652014, 'craiggarcia@hotmail.com')
go

--rezervasyon tablosunda ki ucakID'yi 4 yapar
update rezervasyon set ucakID = 2
	where ucakID = 4
go

--1.ilk 4 pilotu listeler
select top(4) pilotID, tc, adi, soyadi, maas from pilot
go

--2.tc'sine gore siralar
select yolcuID, tc, ad, soyad, telefon, mail from yolcu
	order by [tc] ASC
go

--3.adý w ile baslayanlari listeler
select *from yolcu
	where ad like 'W%'
go

--4.belirli mail cinsini bulur
select tc, ad, soyad, telefon, mail from yolcu
	where mail like '%hotmail%'
go

--5.belirli ID'deki yolcular
select *from yolcu
	where yolcuID in (1,25,36,88,65,92,71)
go

--6.belirli kapasitede ki ucaklari siralar
select *from ucak
	where ucak.kapasite = 170
go

--7.belirli soyadalari siralar
select *from yolcu
	where yolcu.soyad = 'London'
go

--8.maasi ortalamanin ustunde olan pilotlar
select pilotID, tc, adi, soyadi, maas from pilot 
	where maas > (select AVG(maas) from pilot)
go

--9.ortalama maasin altinda  maas alan pilotlar
select pilotID, tc, adi, soyadi, maas from pilot 
	group by pilotID, tc, adi, soyadi, maas
	having avg(maas) < 21000.00
go
 
--10..belirli bir aralýktaki rezervsyon numaralari 
select rezervasyonID, tc, ad, soyad, mail from rezervasyon
	inner join yolcu on yolcu.yolcuID = rezervasyon.yolcuID
	where rezervasyonID between 55 and 72
go

--11.belirli bir firmayla ucanlar
select tc, ad, soyad, telefon, mail from yolcu
	inner join rezervasyon on yolcu.yolcuID = rezervasyon.yolcuID
	inner join ucak on rezervasyon.ucakID = ucak.ucakID
	where ucak.firma = 'Emirates'
go

--12.belirli bir sinifta ucanlar
select tc, ad, soyad, telefon, mail from yolcu
	inner join rezervasyon on yolcu.yolcuID = rezervasyon.yolcuID
	inner join sinif on rezervasyon.sinifID = sinif.sinifID
	where sinif.tip = 'ECOFLY'
go

--13.belirli bir ucagýn pilotlarini verir
select tc, adi, soyadi from pilot 
	inner join rezervasyon on pilot.pilotID = rezervasyon.pilotID
	inner join ucak on rezervasyon.ucakID = ucak.ucakID
	where ucak.firma = 'Pegasus'
go  

--14.belirli bir fiyatin altinda ki biletler
select rezervasyonID ,yolcuID, fiyat, kalkisTarih, kalkisZaman, varisTarih, varisZaman from rezervasyon
	where fiyat < 1000.00
go

--15.ucus kapasitesinin 1 bolu 10 u
select *from rezervasyon
	inner join ucak on rezervasyon.ucakID = ucak.ucakID
	where (kapasite * 1)/10 >= yolcuID
go 

--16.iki konum arasinda ucus sayma
select count(sehir.sehir_adi) as 'sayma' from rezervasyon
	inner join havalimani on rezervasyon.kalkisHavID = havalimani.havalimaniID and rezervasyon.varisHavID = havalimani.havalimaniID 
	inner join sehir on havalimani.sehirID = sehir.sehirID
	where sehir.sehir_adi = 'Ankara' and sehir.sehir_adi = 'Izmir'
go

--17.belirli bir ad ve yýla göre arama
select tc, ad, soyad, telefon, mail, kalkisTarih from rezervasyon
	inner join yolcu on yolcu.yolcuID = rezervasyon.yolcuID 
	where yolcu.ad = 'Breanne' and year (kalkisTarih) = '2023';
go

--18.belirli bir ulkenin sehirleri
select sehir_adi from sehir
	inner join ulke on ulke.ulkeID = sehir.ulkeID
	where ulke_adi = 'Turkiye'
go

--19.belirli bir ulkenin sehirlerini sayma
select u.ulke_adi , count(s.sehirID) as 'sehir sayisi' from sehir s, ulke u 
	where s.ulkeID = u.ulkeID
	group by u.ulke_adi
go

--20.belirli tarih araliginda ucacak yolcular
select tc, ad, soyad, telefon, mail, kalkisTarih from rezervasyon
	inner join yolcu on yolcu.yolcuID = rezervasyon.yolcuID 
	where kalkisTarih between '2023-01-06' and '2024-01-06'
go

--21.gecmis tarihli yolcularin hangi havalimanindan ve sehirden kalkis yaptigini listeler
select r.rezervasyonID, y.ad, y.soyad, h.havalimani_adi, s.sehir_adi from yolcu y, rezervasyon r, havalimani h, sehir s
	where y.yolcuID = r.yolcuID and 
	r.kalkisHavID = h.havalimaniID and 
	h.sehirID = s.sehirID and 
	r.kalkisTarih < CURRENT_TIMESTAMP
go

--22.toplamda secilen sinif sayisi
select s.tip, count(r.sinifID) as 'toplam sinif' from rezervasyon r, yolcu y, sinif s
	where r.sinifID = s.sinifID and
	r.yolcuID = y.yolcuID
	group by s.tip
go

--23.yolcularin harcadigi toplam bilet parasi
select y.ad, y.soyad, sum(r.fiyat) as 'harcanan para' from yolcu y, rezervasyon r
	where y.yolcuID = r.yolcuID
	group by y.ad, y.soyad
go

--24.pilotlarin toplamda ucus sayisi
select p.adi, p.soyadi, count(r.pilotID) as 'ucus adedi' from rezervasyon r, pilot p
	where r.pilotID = p.pilotID
	group by p.adi, p.soyadi
go

--25.kalkis saati ile varis saati arasindaki farkla pilotun ortalama ucusu
select adi, soyadi, avg(abs(datediff(minute ,kalkisZaman, varisZaman))) as 'ortalama ucus' from rezervasyon
	inner join pilot on rezervasyon.pilotID = pilot.pilotID
	group by adi, soyadi
go

--26.en cok maas alan pilotu verir
select *from pilot
	where maas = (select max(maas) from pilot)
go

--27.pilotlarin aldigi maaslari buyukten kucuge siralama
select *from pilot
	order by pilot.maas desc
go

--28.her ulkeden kac sehre ucus
select u.ulke_adi, count(s.ulkeID) as 'ucus sayisi' from sehir s, ulke u
	where s.ulkeID = u.ulkeID
	group by u.ulke_adi
go

--29.hangi ulkede kac sehir var
select u.ulke_adi, count(s.sehir_adi) havalimaniID from ulke u ,sehir s
	where u.ulkeID = s.ulkeID
	group by u.ulke_adi
go

--30.hangi sehirde kac havalimani var
select s.sehir_adi, count(h.havalimaniID) havalimaniID from havalimani h ,sehir s
	where h.sehirID = s.sehirID
	group by s.sehir_adi
go

--31.sehirden havalimanina buyukten kucuge ucuslar
select s.sehir_adi, count(h.sehirID) as 'b>k ucuslar' from havalimani h, sehir s
	where s.sehirID = h.sehirID
	group by s.sehir_adi
	order by count(h.sehirID) desc
go

--32.ucak firmalarinin buyukten kucuge ucus yapma sayisi
select u.ucakID, u.firma, count(r.ucakID) as 'b>k ucus sayisi' from rezervasyon r, ucak u
	where r.ucakID = u.ucakID
	group by u.ucakID, u.firma
	order by COUNT(r.ucakID) desc
go

--33.ucusa kalan ayi artan yonde listeler
select y.ad, y.soyad, h.havalimani_adi, datediff(month, r.kalkisTarih, CURRENT_TIMESTAMP) as 'kalan ay' from rezervasyon r, yolcu y, havalimani h
	where r.yolcuID = y.yolcuID and
	r.kalkisHavID = h.havalimaniID and
	r.kalkisTarih > CURRENT_TIMESTAMP
	order by datediff(month, r.kalkisTarih, CURRENT_TIMESTAMP) asc
go

--34.belirli bir sehire varan yolcular
select ad, soyad, sehir_adi, varisTarih, varisZaman from rezervasyon 
	inner join havalimani on havalimani.havalimaniID = rezervasyon.varisHavID
	inner join yolcu on yolcu.yolcuID = rezervasyon.rezervasyonID
	inner join sehir on sehir.sehirID = havalimani.sehirID
	where sehir_adi = 'Moskova'
go

--35.belirli bir sehre gidisi sayma
select s.sehir_adi, count(r.varisHavID) as 'gidis sayisi' from rezervasyon r, havalimani h, sehir s
	where r.varisHavID = h.havalimaniID and
	s.sehirID = h.sehirID
	group by s.sehir_adi
	having (s.sehir_adi) = 'Mugla'
go

--36.en cok tercih edilen sehirler
select s.sehir_adi, count(r.varisHavID) as 'gidis sayisi' from rezervasyon r, havalimani h, sehir s
	where r.varisHavID = h.havalimaniID and
	h.sehirID = s.sehirID
	group by s.sehir_adi
	order by COUNT(r.varisHavID) desc
go

--37.gecmis ucuslar
select firma, kalkisTarih, kalkisZaman, varisTarih, varisZaman, sehir_adi from rezervasyon
	inner join ucak on rezervasyon.ucakID = ucak.ucakID
	inner join sehir on sehir.sehirID = rezervasyon.rezervasyonID
	inner join havalimani on havalimani.sehirID = sehir.sehirID
	where kalkisTarih <= CURRENT_TIMESTAMP 
go

--38.en cok tercih edilen sinif tipleri
select s.tip, count(s.sinifID) as 'sinif sayisi' from rezervasyon r, sinif s
	where r.sinifID = s.sinifID
	group by s.tip
	order by COUNT(r.varisHavID) desc
go

--39.kac sinif tipi var
select COUNT(tip) as 'sinif tipi' from sinif
go

--40.belirli tarihli varislar
select tc, ad, soyad, telefon, mail, varisTarih, sehir_adi from rezervasyon
	inner join yolcu on yolcu.yolcuID = rezervasyon.yolcuID 
	inner join sehir on sehir.sehirID = rezervasyon.rezervasyonID
	inner join havalimani on havalimani.sehirID = sehir.sehirID
	where year (varisTarih) = '2023' 
go

--41.adlarin alfabetik siralamasi
select *from yolcu
	order by ad asc
go

--42.belirli tarih aralýðýndaki yolcu sayisi
select count(rezervasyon.yolcuID) as 'yolcu sayisi' from rezervasyon 
	inner join yolcu on yolcu.yolcuID = rezervasyon.yolcuID 
	where kalkisTarih between '2023-01-07' and '2024-01-07'
go

--43.yolcularin ID'sine gore tek sayilari listeler eger ki 0'a esitleseydik cift sayilari listelerdi
select * from yolcu 
	where yolcuID % 2 = 1
go

--44.telfonu 0530 ile baslayan yolcular
select *from yolcu 
	where (len(telefon) >= len(0530) and 
	telefon / power(10, len(telefon) - len(0530)) = 0530)
go

--45.pilotlarin maas ortalamasi
select AVG(maas) as 'ortalama' from pilot
go

--46.belirli bir maasýn altýnda kalan pilotlar
select pilotID, tc, adi, soyadi, maas from pilot 
	where maas < 21000.00
go

--47.kadin yolcu sayisi
select COUNT(cinsiyet) as 'kadinSayi' from yolcu
	where cinsiyet = 'K'
go

--48.erkek yolculari listeleme
select *from yolcu
	where cinsiyet = 'E'
go

--49.erkek pilot sayisi
select COUNT(cinsiyet) as 'erkekSayi' from pilot
	where cinsiyet = 'E'
go

--50.kadin pilot listesi
select *from pilot
	where cinsiyet = 'K'
go

--51.en cok tercih edilen firmalar
select u.firma, COUNT(r.ucakID) as 'tercih sayisi' from rezervasyon r, ucak u
	where r.ucakID = u.ucakID
	group by u.firma
	order by COUNT(r.ucakID) desc
go

--52.kadin yolcularin en cok tercih ettigi firmalar
select u.firma, COUNT(r.ucakID) as 'Kadinlarin tercih sayisi' from yolcu y, rezervasyon r, ucak u
	where r.ucakID = u.ucakID and
	y.yolcuID = r.yolcuID and
	y.cinsiyet = 'K'
	group by u.firma
	order by COUNT(r.ucakID) desc
go

--53.erkek yolcularin en cok tercih ettigi sehirler
select s.sehir_adi, COUNT(r.varisHavID) as 'Erkeklerin tercih sayisi' from rezervasyon r, yolcu y, sehir s, havalimani h
	where r.varisHavID = h.havalimaniID and
	h.sehirID = s.sehirID and
	r.yolcuID = y.yolcuID and
	y.cinsiyet = 'E'
	group by s.sehir_adi
	order by COUNT(r.varisHavID) desc
go

--54.kadin pilotlarin maaslari
select adi, cinsiyet, soyadi, maas from pilot
	where cinsiyet = 'K'
go

--55.ortalama maasin altinda kalan kadin pilotlar
select avg(maas) as 'Kadin ortalama maas' from pilot
	where cinsiyet = 'K'
go

--56.belirli firmanin pilotlarinin ortalama maasi
select u.firma, avg(p.maas) as 'ort. maas' from ucak u, pilot p, rezervasyon r
	where r.ucakID = u.ucakID and
	r.pilotID = p.pilotID and
	u.firma = 'KatarAirways'
	group by u.firma
go

--57.belirli bir firmada kadin pilot sayisi
select u.firma, COUNT(p.maas) as 'Calisan kadin sayisi' from pilot p, rezervasyon r, ucak u
	where r.pilotID = p.pilotID and
	r.ucakID = u.ucakID and
	p.cinsiyet = 'K' and
	u.firma = 'AirCanada'
	group by u.firma
go

--58.belirli bir firmadaki kadin pilot ortalama maasi
select u.firma, avg(p.maas) as 'Calisan kadin ort. maas' from pilot p, rezervasyon r, ucak u
	where r.pilotID = p.pilotID and
	r.ucakID = u.ucakID and
	p.cinsiyet = 'K' and
	u.firma = 'BritishAirways'
	group by u.firma
go

--59.belirli bir ulkeye ucan erkek yolcu sayisi
select u.ulke_adi, COUNT(u.ulkeID) as 'ullkeye ucan erkek sayisi' from rezervasyon r, yolcu y, ulke u, havalimani h
	where r.yolcuID = y.yolcuID and
	r.kalkisHavID = h.havalimaniID and
	h.ulkeID = u.ulkeID and
	y.cinsiyet = 'E' and
	u.ulke_adi = 'BAE'
	group by u.ulke_adi
go

--60.belirli bir pilotun yaptýgý ucuslar
select p.tc ,p.adi, p.soyadi, p.cinsiyet, p.maas, r.rezervasyonID, r.yolcuID, r.sinifID, u.firma, r.fiyat, h.havalimani_adi, r.varisTarih, r.varisZaman 
from rezervasyon r, pilot p, ucak u, havalimani h
	where r.pilotID = p.pilotID and
	r.ucakID = u.ucakID and
	r.varisHavID = h.havalimaniID and
	p.adi = 'Anil'
go

--61.belirli bir pilotun calistigi firmalar
select p.tc ,p.adi, p.soyadi, p.cinsiyet, p.maas, u.firma from rezervasyon r, pilot p, ucak u
	where r.pilotID = p.pilotID and
	r.ucakID = u.ucakID and
	p.adi = 'Mia'
go

--62.belirli bir yolcunun ucus bilgileri
select y.tc, y.ad, y.soyad, y.cinsiyet, y.telefon, y.mail, u.firma, r.varisTarih, r.varisZaman, h.havalimani_adi from rezervasyon r, yolcu y, havalimani h, ucak u
	where r.yolcuID = y.yolcuID and
	r.ucakID = u.ucakID and
	r.varisHavID = h.havalimaniID and
	y.ad = 'Marcus'
go
