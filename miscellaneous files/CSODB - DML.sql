ROLLBACK;

START TRANSACTION;
INSERT INTO public."Building"(
            id, name)
    VALUES (0, 'Br. Andrew Gonzales Building');

INSERT INTO public."Building"(
            id, name)
    VALUES (1, 'Br. Gabriel Conon (SPS) Building');

INSERT INTO public."Building"(
            id, name)
    VALUES (2, 'Don Enrique Yuchengco Building');

INSERT INTO public."Building"(
            id, name)
    VALUES (3, 'Enrique Razon Building');

INSERT INTO public."Building"(
            id, name)
    VALUES (4, 'Velasco Building');

INSERT INTO public."Building"(
            id, name)
    VALUES (5, 'Gokongwei Building');

INSERT INTO public."Building"(
            id, name)
    VALUES (6, 'La Salle Building');

INSERT INTO public."Building"(
            id, name)
    VALUES (7, 'St. Joseph Building');

INSERT INTO public."Building"(
            id, name)
    VALUES (8, 'St. Miguel Building');

INSERT INTO public."Building"(
            id, name)
    VALUES (9, 'St. Mutien Marie Building');

INSERT INTO public."Building"(
            id, name)
    VALUES (10, 'University Library Building');

INSERT INTO public."Building"(
            id, name)
    VALUES (11, 'William Shaw Building');

INSERT INTO public."Building"(
            id, name)
    VALUES (12, 'Others');

INSERT INTO public."Building"(
            id, name)
    VALUES (13, 'Henry Sy Building');

INSERT INTO public."ActivityVenue"(id, name, capacity, size, rate, "rateType", building)
                           VALUES ( 0, 'A 1502-A Conference Room', 20, 0, 360, 0, 0),
                                  ( 1, 'A 1502-B Conference Room', 10, 0, 230, 0, 0),
                                  ( 2, 'A 1505-A Conference Room', 12, 0, 240, 0, 0),
                                  ( 3, 'A 1505-B Conference Room', 8, 0, 110, 0, 0),
                                  ( 4, 'A 1506 Conference Room', 30, 0, 850, 0, 0),
                                  ( 5, 'A 1602 Conference Room', 20, 0, 680, 0, 0),
                                  ( 6, 'A 703 Lecture Room', 120, 1, 1200, 0, 0),
                                  ( 7, 'A 903 Lecture Room', 120, 1, 1200, 0, 0),
                                  ( 8, 'A 1103 Lecture Room', 120, 1, 1200, 0, 0),
                                  ( 9, 'A 1403 Lecture Room', 120, 1, 1200, 0, 0),
                                  (10, 'A 1703 Lecture Room', 120, 1, 1200, 0, 0),
                                  (11, 'A1402 Micro Teaching Laboratory', 45, 0, 700, 0, 0),
                                  (12, 'A1805 Micro Teaching Laboratory', 45, 0, 700, 0, 0),
                                  (13, '20th Floor Board Room', 20, 0, 900, 0, 0),
                                  (14, '20th Floor Conference Room', 8, 0, 400, 0, 0),
                                  (15, '20th Floor Multipurpose Room', 200, 2, 2500, 0, 0),
                                  (16, 'Classroom (Full-size)', 45, 0, 620, 0, 0),
                                  (17, 'Classroom (Half-size', 25, 0, 340, 0, 0),
                                  (18, 'Natividad Fajardo-Rosario Gonzalez Auditorium, 18th Flr.', 238, 2, 3000, 0, 0),
                                  ( 19, 'Neil Room', 12,  3, 700.43,       4,        0);

/* Organization Data */
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (1, 'Chemsoc', 'Chemistry Society', 1, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (2, 'MC', 'Math Circle', 1, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (3, 'Physoc', 'Physics Society', 1, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (4, 'SV', 'Societas Vitae', 1, NULL);

INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (5, 'LSCS', 'La Salle Computer Society', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (6, 'UNITED', 'Union of Students Inspired Towards Education', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (7, 'ENGLICOM', 'DLSU Filipino & Chinese Organization', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (8, 'ROTARACT', 'ROTARACT Club of DLSU', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (9, 'UNISTO', 'United International Student Organization', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (10, 'AIESEC', 'AIESEC DLSU', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (11, NULL, 'Moo Media', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (12, 'OC', 'Outdoor Club', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (13, 'WG', 'Writer’s Guild', 2, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (14, 'ECO', 'De La Salle University - Environmental Conservation Organization', 1, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (15, 'GAS', 'Gakuen Anime Shoshiki', 2, NULL);

INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (16, 'AMSTUD', 'The Organization for American Studies', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (17, 'BSS', 'Behavioral Sciences Society', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (18, NULL, 'Cultura', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (19, 'DANUM', 'Dalubhasaan ng mga Umuusbong na Mag-aaral ng Araling Pilipino', 1, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (20, 'ESA', 'European Studies Association', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (21, 'Kaunlaran', 'Kapatiran ng Kabataan para sa Kaunlaran', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (22, 'NKK', 'Nihon Kenkyu Kai', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (23, 'Poliscy', 'Political Science Society', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (24, 'DLSU Pilosopo', 'Samahan ng Lasalyanong Pilosopo', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (25, 'SMS', 'Samahan ng mga Mag-aaral sa Sikolohiya', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (26, 'SDH', 'Sociedad De Historia', 3, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (27, 'TeamComm', 'Team Communications', 3, NULL);

INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (28, 'ACCESS', 'Association of Computer Engineering Students', 4, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (29, 'ChEn', 'Chemical Engineering Society', 4, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (30, 'CES', 'Civil Engineering Society', 4, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (31, 'ECES', 'Electronic and Communications Engineering Society', 4, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (32, 'IMES', 'Industrial Management Engineering Society', 4, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (33, 'SME', 'Society of Manufacturing Engineering', 4, NULL);

INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (34, 'AdCreate', 'AdCreate Society', 5, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (35, 'BMS', 'Business Management Society', 5, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (36, 'EconOrg', 'Economics Organization', 5, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (37, 'MaFia', 'Management of Financial Institutions Association', 5, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (38, 'YES', 'Young Entrepreneurs Society', 5, NULL);


/* Sample Data */
INSERT INTO Account (email, idNumber, password, firstname, middlename, lastname, contactNumber, publicKey, privateKey, type)
             VALUES ('juliano_laguio@dlsu.edu.ph', 11445955, '1234', 'Lian', 'Blanco', 'Laguio', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAt
lcqnpBSUE/uP1V1xrOybXpkNba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6
iXsLbjhpfG3BQBNdlUFT/uoeOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwr
wgXZLPlVyHxGuufO9QIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXgIBAAKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAtlcqnpBSUE/uP1V1xrOybXpkN
ba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6iXsLbjhpfG3BQBNdlUFT/uoe
OFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwrwgXZLPlVyHxGuufO9QIDAQAB
AoGBAI51ub56ZrRtczf5QWjlysgIjvMbZmXEEYvZjmn6ckdK2otQgkj1nm2gJrTM
JIWv/1W6HpJEZT6hSrIlZIwi15y1ndX+37qH9NwcZqLhRl4xAtlDbzQErHgIAZNP
9PlOR9eti6suvJkOj887wj1J6jZzfbANJXhOyYBaWFDePt9RAkEA5oBtpa/xDJIf
5+O6/SzPDEP2qyMcJqruf+RwbuqMSMAGjS+/iwrWmwH2XPFiaHxTzXJVL4uJrYwj
m6qW8kMnGwJBAM0aZgcHJr0Kyo5jV2wxmnfjsLReuBQ9yKf3Jom2CRvyhrRaQwTZ
Dpwwe283oG8b+O+dciJ7QVFwZo3/gcWv8y8CQQC3eWbNydxviyjGZikDOVWdh8Oi
uZHA3bJ2LpmoUB5WEjOk0mr+/COSwt8dYC5ayQvTrrxL2iA++hul3wXD1NwdAkEA
kkH266AP4dKmKu9wUfj1W/UD9ztsLRL52b0GwEENMd66bDXJgNV/86UnAGI8h778
v3IZB7m5FGgA2dWQJvaXhQJAffuC6I3UurV+ZUEPPmrNkq86AKUHCIdSIqVP1iF3
3n4DR+xpWj0DItgiGWV+vdfqFxghu+4HpeVhpTY1jtVjMQ==
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (11445955,   10, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
             VALUES ('markus_flores@dlsu.edu.ph', 11445954, '1234', 'Markus', 'Flores', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+8
1sEGse39TOM0+m5yOCVf7NoWJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5f
DKeatUg278bqJqPf+Wgdh2+0D9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDA
pmy+d4D7v1WgUb79LwIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICWwIBAAKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+81sEGse39TOM0+m5yOCVf7NoW
JcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5fDKeatUg278bqJqPf+Wgdh2+0
D9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDApmy+d4D7v1WgUb79LwIDAQAB
AoGAIHQeh2bIk47gMDpH0nZribycGIjUCSVbp8wJqOUz8Gzr7ShpE+uwMGjS+Rp4
r2gjOovMgLolvGIw9CK+P32D6gKgDREwWP+NvOY977HHKMtAPA4SRwAPJU4boAJw
KiysLR9X3S/FiYXp21i1araXV2tscLdEkmEIEsOYrAPJIgECQQDwA2RK2FdkCYXd
2JHJH70OUAQIW5ZbEJXXqQ7pO3Xp/n0mnCJz9o5nixwrI3KTWLITOpE4Em0lJH5b
rnwC11nPAkEAjiQ/Y4kJUWS7RZlNNLqAz30ZZS89G3HYHIPBLS3Rc0Zc4/yctjPx
Jwm4ysWPciEcNbEdR0IqvFCfl5FVYjLeoQJAZdjqnCAFpXutBKC77F69eO9XZryG
pwn4q9UfcLU8qhjFvraOoCrF7wZG479dBU2j8yjtKqAXFKXRwNHf6cy8XQJAYzTf
XSwu6bUhk9EMdsnYz3hjuiB/SOFrUXOP52V8MzWf7avJAM49+N4rMLM0jBaZ5suI
QMzooOiwiovwCQqyIQJAUmw0ZcnzmAECb1x8umovIi65tdsI00FBDPU+nz/dJQ2j
Kpn+OFihMZYue8HK51G2AMj8ufFhxvKoeIRPRq3+Ug==
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (11445954,  30039, system_get_current_year_id());
INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (11445954,  20031, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
             VALUES ('dominique_dagunton@dlsu.edu.ph', 11445953, '1234', 'Dominique', 'Dagunton', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCn04c01GwNuiVOY2ggQjOPTsxg
XGC/FFbmXvoCGGAm+M3sJnVh2s/Qqb/QlvzAZueznA06AeaoAVXpHCstdN/O0wOU
+9j2B/VQtVangWJyTsf2NomqKjynJyeobwqWyuuJvxpoV58XUkw9ojcf2vQxt7MD
xq8uGXNfMWFpYf0oIQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQCn04c01GwNuiVOY2ggQjOPTsxgXGC/FFbmXvoCGGAm+M3sJnVh
2s/Qqb/QlvzAZueznA06AeaoAVXpHCstdN/O0wOU+9j2B/VQtVangWJyTsf2Nomq
KjynJyeobwqWyuuJvxpoV58XUkw9ojcf2vQxt7MDxq8uGXNfMWFpYf0oIQIDAQAB
AoGBAKeWj5mt1gkPLVnN4pj0AtDEe0pudR3ajbyWc0nMVZgVNGzxKp6BBqz0FduS
Kutm11GAL6URaOe0Dbouqt9FqocW2R50zDEL/mdkDRjXK1wyBQUjfIIahDtkR0Ej
wx64R01yB5zGIrysmG9HgwhUXRsItUCC+as3LFnN2A3DrSjRAkEA81ls8OBCkiYd
njxaIY/gZNYjnWnfL4B613qSB3Vt0ShPRXKZ7So0BLCt3oNHfIVCobYXS7SL9kFJ
+X0uOLo+gwJBALCNBEQynm4Q91cs1yURQRODi88tkldbH4aSK1AUdD1phILuFN4G
6PhPzKmkKuSxv7MlHbRxGoWd4vukuLqoPYsCQC4+YitsEnp/b8VwJpiWJMhEwUPa
qKT4P1/PVQzBzfqfNGE4I/QjvvrdME1GmUEaec0NM2QZjTdgtNQKa8wv6E0CQHdS
R1DkOSlAdDpJxvp5Z9cNb/9M2HwLzQnBXl6YBFvBJdrrl9TbLLcuD6+TkZ3Q+DPW
YPYj/v3RUKgskuEsdbMCQQCWW277qGp5CqmYzb6DCDkZEY08miojdHqiebK2bfrN
5a4o1xkYuqzLS26OUJUSHyeWaERiq/J+CukFK78ML4Bz
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (11445953,    1, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
             VALUES ('neil_capistrano@dlsu.edu.ph', 11445952, '1234', 'Neil', 'Capistrano', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIyvifYGHNb54ZF8wUankon5d6
cAKy3eXhiS4GdCcpWPMnzfU2Dj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXb
BGzRYeXtgNYMlpUYk5b+9XhQ25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7
mTuU9jnyflD7mRlopQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDIyvifYGHNb54ZF8wUankon5d6cAKy3eXhiS4GdCcpWPMnzfU2
Dj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXbBGzRYeXtgNYMlpUYk5b+9XhQ
25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7mTuU9jnyflD7mRlopQIDAQAB
AoGACzH15rzy9wdQI0oGYOUG2FL9mSABpoNku8xwOn/jZxTEieWb1GW6++UWNzy3
YGKEy+glF30TgRBLaKz+JD6cGp8R0+o/kFT9pPazWy5fuKoTxEmsXlqm+IO6gBxz
rQKIhiI2Bwzwu2B2MDzfzhM9O/z4ZuP7Iyb16HQ8aNokgQkCQQDjRDO+uPrpGU4d
zukEth/TgsF6u9SU/s7iKdNeqYmRFwey6Dh1JRLZb/5zU3cVB+nqh6ROt0MGA20e
ZRYuy2dzAkEA4i3qPpfF5hhKcx6MHlk5XCSb0dheFBN+mnuyi0UoA9yXltUl83ZR
vFqd2a7wdJnFFqe6XUqC1WAtglShRy35hwJBANayH5AVgDOlTD6ssUVaKEbQR6eC
uhjnftn5WU0cLHF8qDFDX9KK63uuaVrZhq2/hCOjcH1Mc2zC39rO9F3QmjECQDDb
tEczJ/fNdX+qsJ/5rC9gZRyOfbweffHHGMmG9d7nrwNRJfKSs5NZi9GzPZQih3We
Y961Ms//B7WorHIg108CQF+Drrof608PluO6xjEW9GqG9bWmXY3lj7JVxrdRzaIT
gtrnlHS0iq2WG9fcmONPTzL43dP1MABmrL49+nSIcwI=
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
             VALUES ('org_pres@dlsu.edu.ph', 1111111, '1234', 'Organization', 'President', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV+WSPPbpj1JFi/mGLrBBG33zP
rC3x8ZH1/uyqJTwZ29eQ+P3Z6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ
61LOPZfwNgBw3m0WBzURlBbltFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV
+6oAoC4KMw6ZSBJfvwIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQCV+WSPPbpj1JFi/mGLrBBG33zPrC3x8ZH1/uyqJTwZ29eQ+P3Z
6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ61LOPZfwNgBw3m0WBzURlBbl
tFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV+6oAoC4KMw6ZSBJfvwIDAQAB
AoGAL0FXyDKhCleuP8z7m3Dp6Ar/XshX6cY+QY7Dr5Dv8Q3uTIXIJuMmivxwnF5u
3SG/0Mwtv8P0CDV4a5E1tyi3esS06icHviHfCPd6akVPxRrPRFcIMdp0GODzAwFh
STtwZ2K60KMOr9Ho39yDBqMZDFRQhLRsqf2CeWb7FRND2xECQQDYP/UV5Ypchl+r
igPbGreIXAQyEsUF9XJ1j5b+oom7W1OgFh9r5NE7WSTAs+jVaPtAByzzLnjRHFsw
KHUYkmJjAkEAsYq13keWn0ZwsuKBvorLqDmJeV2ZUloFVHErkJe2rhhplnVQrM4p
PKWG7ybYEaKkb102SU1ofdzC894h02cd9QJBAL4n938KupFEBAqWsW9Q3gTFTVcu
1Bu6Sqz/1/oPuWeMFkwWSAkbS7WRXNUrHtnSl+Ukqi0pN0pCUhlV6inyRxsCQHyz
D6BrKcj/QcLzQuvhMsAagYuECV+FKP8xacbqOH45WVg7WAm319Dn9kldQB/K27H4
h1ufCgh1GV0OJTYF1E0CQQCrbEqZDEz60to9yz7B5ZIsjTxZZ5vel7tglcs9WeFR
kFcuI3xRNAlNyTRFJs+aNXceKlUeJlI3Ayyp/q+d4vWI
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (1111111, 10023, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
             VALUES ('org_vp@dlsu.edu.ph', 2222222, '1234', 'Organization', 'VP - Finance', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYNkv/DXLS7fhRRLcG7heWNHKD
/ye9abmaI9nQYfn42EEMihiIC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaF
be4uf1UNPf1/D4ORz0+18gIhDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3a
UgY0Yfen0N0vn+n4qwIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDYNkv/DXLS7fhRRLcG7heWNHKD/ye9abmaI9nQYfn42EEMihiI
C+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaFbe4uf1UNPf1/D4ORz0+18gIh
DD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3aUgY0Yfen0N0vn+n4qwIDAQAB
AoGAP/CGtu2OOGyhk78DdWwx03y9JOXvJae/eKMDhgmDeCDT09Z+/LSuzrmQRyeQ
Kwdspeat00LSmt9s/muqs+8LYgrW3DsOx2IO/Vs4+sfAoBMD2cHkmUWgKNeaW1ph
vrFNcpf97uxjjZu+9kIk5BvUwgJI5nv6tg4yB9JVrdy5UDkCQQD2A5DFawzQlC8R
pmPtZsS2xen0ocO96NnDVekb7eIc5UI7/YYRLtYN7wj/8vAzYHQvmPHrCvKvUsnV
ylrA1XZ/AkEA4P0MRtU7UrWfJrIWl8w0CXEL6RwBto6OdanEFUghc302lhEkRWGj
CMDSseJnKoG+L8b0CnN++YjZ2tMBAosf1QJAFZK8eENp7USBWCfiLWhMqcZzPKuO
0bGAnxuChJt4r5X/F+mkfw8/YBttC5zPKYI0zhO4aycbnvpAjsne6XgOmwJBAKEB
9isqpY2HFCHpCGoRZJvtHozv0foHAsQJfZ2NRQMU9F9oXQCZ4sZ810sdrp6owqYG
RtbD2HZTDTSgE/TyAxECQE7Run0VOT6BNBsP9RlLX6/CBGWb0X7/nb2BpoKJOiry
/cf+JtbPWuQMzJI2DtBOJDFqZvS4d3Dd/xi2J2vXKR0=
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (2222222, 10029, system_get_current_year_id());


INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
              VALUES ('org_avp@dlsu.edu.ph', 3333333, '1234', 'Organization', 'AVP - Finance', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9
f8OR3cA0LEsgH1zq61xOVcNPPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJ
iWCky6edWuBclYDAyWNpwL9kAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSn
fZibfHtWczJ3qtPsVwIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9f8OR3cA0LEsgH1zq61xOVcNP
PokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJiWCky6edWuBclYDAyWNpwL9k
AAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSnfZibfHtWczJ3qtPsVwIDAQAB
AoGAXORVVALWgoifY0yr179yexEI9WFPCcOC+h13kJMNz94tk9EGKgBPjY+ulQmp
nWayeSL74Hfw3/f7NcNzjldlgeQwtik0cmcyltKAdnO86tZwj9liax0/QGSxxM6u
ryj9bw18KSQaqVguqT9ukr69zpN7/ZnrpGi68LezFIn07AECQQDEQv7r1MdFQKXm
lVIo23fh3M6VcVFXlvYrliKrlfDLAwvWB0QMOje5PJo7kTEZuoq1oaSBYIV4ccHA
PrmUB3pRAkEAqALjvK/wyaAARCf7D/xNIfYFBDVDXSvWLSh5l7sVczg4hvjnTZYj
LyjFK/nnNq+YO3tQhA4mi2hAXMoUEu8qJwJAUD+Ilos5M5Lcguz5XCVo3lx3x9k+
xk6+t1G7OWekvo2vUENGSq2fTUl/Uu3qIrgIsX23kwMRcA8rhtze6q0oEQJBAKAR
uLXhjnAaX4aP7NPLFhXAFgFvWZHgHPsDL+2OkZ4ntzto0r6Jx1W76za9rjrcyxYI
o6pc7P4uwftlkACGGksCQCSv7IVwaKqcLYglwNgZRSFnkUlfU4bnFntlgNAbH/3x
sxoqKQTWVqw038LwcLCp7OmZKjwwjc72lzxwKdM//dU=
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (3333333, 10026, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
            VALUES ('faculty_adviser1@dlsu.edu.ph', 4444444, '1234', 'Faculty', 'Adviser', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCct6871QS2qtDxi5T12eSk/znm
DFDIuLH1Q2V3owXqV7WldLsoDrFukaHKOs3ob8a9mVb4589K3GQ3i+rVnmaUTXHE
Ge1n6litU/6CUnKUjlKEF9nwB+87rbqsINoowymtbCjvw3Ny0TXBYhoJaKRywgIl
NxDPm6J/sYxt8ymirQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQCct6871QS2qtDxi5T12eSk/znmDFDIuLH1Q2V3owXqV7WldLso
DrFukaHKOs3ob8a9mVb4589K3GQ3i+rVnmaUTXHEGe1n6litU/6CUnKUjlKEF9nw
B+87rbqsINoowymtbCjvw3Ny0TXBYhoJaKRywgIlNxDPm6J/sYxt8ymirQIDAQAB
AoGAZi/LfjsHCMjW1zlJlwlN8lxNd3h+UHNF7oPUrK7LE6O/WLSFuLfj8BHbqg6v
5qjDsStEL6aPXuPYIPQF2uafQXwU9WSG7Iw4fybkOachHtEhxZB4KUSxVKqJynqA
yzBSG8rAU7OOJr9dRUlVt8vIw6KXzol4A6ZQ8CH2BdAzuo0CQQDaRDWGOp4nLAV9
MlVwM2QvHSJifS40F77VC7v6FMrqdp/GXXHtXxqltyp+5BZfkn2WldzcbOD7Gnj7
G20l7rz7AkEAt8+DJlk3BpHDoi3Zpy4V+z6RNQgP+IyQ5eVksUethyV8mhs5kSzs
IXpbKCIw+FpPiXfWf9noUqkwHvKw3FE+dwJAT0OmDHENLjyWYbj9vhlrsJBsBEhh
lxlofAYe5drXNf6OV4Nn9EQtcTDrhdlfJqYUZbNW2dXQfmBGvypeoP/qMQJBAJg1
0MbqzfQ0tKoSCdC1CyLYtuoRWRhbXonhobZkQsBNPJdowA0GBCvc5KuhVKf0MTUG
9as9yXLaA609D1QCOxUCQD/rjvaV80gcG1AXJFc6y9w13hYUCpfBRATBHvoz3pAN
wYsx9+22oRsrfmBQFuxo0o7Z1u+RJC7S5bRkKTL89Uc=
-----END RSA PRIVATE KEY-----', 2);

INSERT INTO OrganizationFacultyAdviser (organization, faculty, yearID)
                                VALUES (           1, 4444444, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
            VALUES ('docu_vp@dlsu.edu.ph', 5555555, '1234', 'Organization', 'VP - Docu', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCBXXm3efVEN4sQ+vfDyhlhuDq/
K3G9u1nV2qd7k3lfCoRCKbcGtVDo+Q8L17glOnlg7jCp0LRzs1r1DojB3R/bYHv9
dMMVuozDgfLn7dxe+O3TjI1gCmkcAj9m3orM27CExGutEiRAyLecSzT/r+kJ5cMt
C5Baj3ihb9Y0RKKhgQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQCBXXm3efVEN4sQ+vfDyhlhuDq/K3G9u1nV2qd7k3lfCoRCKbcG
tVDo+Q8L17glOnlg7jCp0LRzs1r1DojB3R/bYHv9dMMVuozDgfLn7dxe+O3TjI1g
CmkcAj9m3orM27CExGutEiRAyLecSzT/r+kJ5cMtC5Baj3ihb9Y0RKKhgQIDAQAB
AoGAc8jXJPmaJQlVhcgqM+nR192NbwcSUU+7MyX12yv+aKs//vvZHb7xAOPRrLbR
0ThJ5RCrK4Jp0FiKI2Vzz5f7Zxdhvuwl6wYhcMZ8zk42fX8bzUF1uBjPsRk84gWK
7I3faSvXqeuEiDNjXkjKfIMWyBL//vUowl7dc4rRiZHew1UCQQC473GHpVn9WRg7
I36Ts6QGJVB6/AgZaBSwatj0eXSJLOToILxIjmtf/oe9j8Pfx9VoxGvuuxikrjJu
X83xxk5TAkEAsxNzrImX4Z2xV+cg2xVDG/ojMhhsGRrJk9HF65UZoRX3KNyY/SlI
3BZ99MayvTsTgxv6bvMaXnbjrCgNr6rOWwJBAJWjCNWc8WeRQ432dmDEph9i6e/Z
JiSIltT4X3vRGn40GTPJ6Q88TZ1qsiKrxO25H/CZnkuYj6QQXzX3xweuUYkCQG4o
iiDaJ2cvtVdoo8qBgt3j+uCnK2AqHVRkV8c62iBAveESCr65NcvFvkfkLzG+9JrT
jDPSMidoJVfS79BfVz8CQBMKt18LgvWQsd76NUPgnFDWkS8O5h7kIJrU3nHuKDjT
BZcLymoRZJvM/52CSshJ3iJ/80HDD/3DEN2KhMlnBpc=
-----END RSA PRIVATE KEY-----', 1);
INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (5555555, 10027, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
         VALUES ('aps_vc@dlsu.edu.ph', 6666666, '1234', 'CSO', 'VC - APS', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDS96X7dtaSFpn9k/7mo17P/Wwz
+kK2pTbveE105mCkPA2OHVSc9bzPKmCvvISeMFzm8XjIvpXlqRdBIANFQGAtRT3K
URL0ImjPDLg99TN+KncSz9Xp33joslOIOAXdg/CE0j5ijhWvSRIf/WN0NE31Kjxm
byR7gNI+iN7eSxNKbwIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQDS96X7dtaSFpn9k/7mo17P/Wwz+kK2pTbveE105mCkPA2OHVSc
9bzPKmCvvISeMFzm8XjIvpXlqRdBIANFQGAtRT3KURL0ImjPDLg99TN+KncSz9Xp
33joslOIOAXdg/CE0j5ijhWvSRIf/WN0NE31KjxmbyR7gNI+iN7eSxNKbwIDAQAB
AoGBAM079tFnjt6X9j7mlvewvzAADh+SuwwMNiFJG7E53ZJoiZdTmVkJByFSzLSp
5SovSnGxQBuqrRC7KtBEYGoicmxSWrPa28YstZw3VyK5zay9wWuyogHyx535bUuI
gIu2rkGqCnlVO93PEPHZisCN3DWnxSmrwSleJXLyXEebW9ThAkEA/EmCw3zyeQGs
05i8RI92q7gumnvbVrBrf2i3SEPA+4H63Asg/NU9hDrWyNS0+MiU3/ov7N5h/7v4
kNwAteKkVQJBANYSdzuL8rDS8vN78l8xT0qFnHqNg777yR28RFAwiBUCAwOYQG2f
g8MD1g1l3Nzu7riewIDZXE5CCSlnEE4717MCQHjv5DdB1hobq3VjahyTiReYGv8D
EInl2CIjWHjTwdbO4CpLS2zn661PZ1auYHJB9NvJWt/5WpD00preW5jVJGECQDio
1ooaNnf6vXcYfUQYxwXQa2Q8hHxOJCMMq4AV+E6nI6kV6SeaqsM5BrSxG04Wp3SS
AB2aakYEUGx27OfoCuUCQQDqnjl4xK+d7yMpfz58gGOQIuKgPQlSFx7BDlBBcX46
PeRqcg6LDDmiTQeAW0N8ywoyAsTe8lLyomiujzoa0nNC
-----END RSA PRIVATE KEY-----', 1);
INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (6666666, 12, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
      VALUES ('aps_avc@dlsu.edu.ph', 7777777, '1234', 'CSO', 'AVC - APS', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCOipOmH7ymZy3hQ41GlpFn6bgN
PtEuQmvSDnZWbkfC0HWG7ho5uqoy90bh89eUxQ2VNyoh1WuiF9YF6KIfxTxIQ1uR
9G+81YH6T8Qp8MyaN/5uggc6A7czxgddbSs94iQCDnGTA0YiBpLT9fCrmSEDalzq
tiKPUEpbCtFuQc+SUQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQCOipOmH7ymZy3hQ41GlpFn6bgNPtEuQmvSDnZWbkfC0HWG7ho5
uqoy90bh89eUxQ2VNyoh1WuiF9YF6KIfxTxIQ1uR9G+81YH6T8Qp8MyaN/5uggc6
A7czxgddbSs94iQCDnGTA0YiBpLT9fCrmSEDalzqtiKPUEpbCtFuQc+SUQIDAQAB
AoGANbnp2Q3RT29IjcWmdFrAR8iCRQvOUH9coHovBHjgt39XLRqF7Ah9qmQl5XjB
YyO68OkwCjylKx2M4AFFSnBPPeWC4N4e3hok/82rtyhzUkL6TmSNmY0utqjdhC7f
QFgRutu6mcyi4kRIiVgr68ZSOioQcELoct1T8vTFJqfUj5kCQQDFEKgnnAJaVTrF
z9yVH5SNiEk683nqI2zHI4paeq48MRyKPb9Wtv56zmKzY3lZ+X9eflYDd763kA6T
7oG4MHSjAkEAuSuR7X7j53ELX02QqDyXVSScostkIDUJGUDA+WiVirEkA54Jh+gX
DmGJZlA3wfEvZN1/6lp/8ywWW/tIw0rYewJAX0WCRkQCTzHNTD0F44J1C0fMP5fe
ZPfjaxMfnEabXbZQmfToQEAQH8cPqLJ6xKj+jux9IQgPSCd5JMO2KxoiCQJAKpRI
RBJvmaK2+L0/TFBShDOdCRo39ef8JaBsP227JV9CZsqKaoQF+TqYe7xqdeBeA5Wj
emJBFcvHgHMx8iZdzQJBAMAa4CCAqM8FIlF50LMi/Mh07RVL7bpGTTZNgNmyoj3S
Wo4x/9CFpNLrR3Za7Q4Vxmb8DGdfJIgb9fu7FGMf97I=
-----END RSA PRIVATE KEY-----', 1);
INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                      VALUES (7777777, 13, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
    VALUES ('pnp_avc@dlsu.edu.ph', 8888888, '1234', 'CSO', 'AVP - PNP', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQChUp/jlMxfxNpHoOrGA5DaT+2y
fWLbXwM+PApszBLX74I8oRneK7G5h2Os9HGu/loM8YiPuamhegcu44V5eR/bg1T+
N0HVnjGXoiFrQ3H4ATKr7hiOKyGkPL8pVB1Ytl+ABVMBsssvI2Srd9Lwi4rmHxkG
1qclxQml4ztiHAcgEQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICWwIBAAKBgQChUp/jlMxfxNpHoOrGA5DaT+2yfWLbXwM+PApszBLX74I8oRne
K7G5h2Os9HGu/loM8YiPuamhegcu44V5eR/bg1T+N0HVnjGXoiFrQ3H4ATKr7hiO
KyGkPL8pVB1Ytl+ABVMBsssvI2Srd9Lwi4rmHxkG1qclxQml4ztiHAcgEQIDAQAB
AoGAQsoPckx/lMLOUEt6B8MgLJJc6cHptMMQd6qp8kNHJel+NRXJvObALPy1srx9
eKLLq4IwNLj8VuNLqAkAkLsqCbJ9Es0OVcD4Ubx+oWy6mF+5Os8o+zvA/VaL9yM3
MquCHgepg+NnjKmP8//6/u/DCVNix+NENRW6VCxpwJlVTTECQQDNH8PnP5ppUQed
AXeWOWR7dSCVAoYIhyAQt8Hgu9a1UsXs9TG/1zVZNqP1mLHR8GdShD0mVozI8MED
FYYQfWeVAkEAyVW4Hh/jJZKrgYWa+Ypi314E8VJkqrEmZt9HrmwHaI3BRv02Jldk
SoJJvjmJxfkZaoDZXogD+AlKGy70bKAHjQJAItkosRrPIuFPR889/9mURp0pgedB
2iUKv4xYddOzsG51jcJCR3NKbvOne0wLubz78LrioKbHmEO+psV7V0XW2QJAa9Id
FPzsr115vZZoZUUIKCj4qqf+Qy81qpfeknlGCmcH39WQ3z2j9wcJKPc1YjFBvDie
sDJVNcr7xc0Clv2orQJAch33cTkbl1v+TvSKyXUJhCv5hj8OMSFQKy2YRHsS0Yis
W4PuwQiPdp1Xt33nDD31qVfZhcpTWb5HO9yJXGP9Dw==
-----END RSA PRIVATE KEY-----', 1);
INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (8888888, 18, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
    VALUES ('amt_vc@dlsu.edu.ph', 9999999, '1234', 'CSO', 'VC - AMT', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDC1X8I3fweNqM3ah6SQA6f0zx8
l00xgpEOByevUeWqXd1Ftp7+qPzFHvk5E1+3EAgU09vPjsK6P81s2kIdPDZLpOC/
4dm6pR4pnw09lJ0E0Gtl/2aVJvuZesw+se+FSCUu+s6BvTgs+tt/TiDTEENDefUm
JES+qmH3K7QToeN4yQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXgIBAAKBgQDC1X8I3fweNqM3ah6SQA6f0zx8l00xgpEOByevUeWqXd1Ftp7+
qPzFHvk5E1+3EAgU09vPjsK6P81s2kIdPDZLpOC/4dm6pR4pnw09lJ0E0Gtl/2aV
JvuZesw+se+FSCUu+s6BvTgs+tt/TiDTEENDefUmJES+qmH3K7QToeN4yQIDAQAB
AoGBAJzOy8FNOD7w5ogRBq3alGqZzlLQSzaPyUMrCwuVtGxbw1z6UBjR1S6pcRg4
uY5Sfs6UfJMeaScRdronJ5L0BRWQ+lb/iCo+NGO9zZ36QNJbjD9iMtKneSgKkLcW
8NW0VBsODMH9kgihzTwpB3ZoLh8wlKPJcOzuGX/1p2p5LnIBAkEA4+ac+byWeP8a
Tu8oHVhc6SUbQGIzenMxXdQOjoyUwmxnbGy1nvou210vwb/ZaUKkDeDh4U/ZwEE0
0sAW4oE9qQJBANrbK+VZ9z89p/3nOLZW+EZUzxj4TVExHWuBGwILLSVfPv+xCNfH
mL63XjlRl66wDv1m5lFbsrmU6V+RBl0+FiECQGLaZh6hYbeMF9JDRGguKubqNH7h
2ah0jOZBFCta6S/IK7hJEyKpLGf0bMGiwOA6isSGVhQQOch9wDbmIUcQfjkCQQDF
K33RhArnM8H8Umrag2Hr4w4tPc5SXoBV0Rum7LDAoZ2dOD5yQEURVRwTYbnYzI7E
pwbKt2U+IrVZvstQB9ZhAkEAvAIe2B8spxnFDG0KIUxsd9H5HUidfiqHNQ5Vd7Uc
NP4KPvDCOkN/W7llKwUwYjyqBtYasC9/Vbkm2VyLY67V7g==
-----END RSA PRIVATE KEY-----', 1);
INSERT INTO OrganizationOfficer (idNumber, role, yearID)
     VALUES (9999999,  8, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
    VALUES ('john.lingatong@dlsu.edu.ph', 20111111, '1234', 'John', 'Lingatong', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCIqhYRfVFMwLhS/WPMcmxtKfRW
gGJYmmuqCl6pO/CiaIp3ThmHts72vDwiHW1+4c0LK+SdZiqQQMth6eRaaEMJhVc3
LZQunSjMuNGk8xkAGPFGu3im2+1wZxIew2wsZiA/EUPwEq5GEoKPw+s3joY2EdiG
y2FUn6BFoW7mun7GGwIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQCIqhYRfVFMwLhS/WPMcmxtKfRWgGJYmmuqCl6pO/CiaIp3ThmH
ts72vDwiHW1+4c0LK+SdZiqQQMth6eRaaEMJhVc3LZQunSjMuNGk8xkAGPFGu3im
2+1wZxIew2wsZiA/EUPwEq5GEoKPw+s3joY2EdiGy2FUn6BFoW7mun7GGwIDAQAB
AoGAN6gdKK5Cp+Fsr8+mDyMiaSrG6VuLsc3hvvROLNnOXDX6/i9+Ujju/KkYTERz
zVKkMMKFblynROw+Z/fbGb6QXf0rTOnKbkQieK8YdNEd68J1BWhbD+UOrz9lhEBm
0uMS41anqSGaAP2tFevVnl9/8U/pSmc80wXqDpH5cHBnnoECQQDOXZDonw6/GNn8
iWeDvWXG07zVGntKNCDe3RyrQZtYfbUKW2OwaAqITDMfV5Kr2i1X8xa8xDIEL2wm
KsSKrfa7AkEAqYjZ9SlhBwLqOOeTnC6SR4TNn2KtBDQoNKgmMq+0d2nPeX/USiZw
uAVpAdmVhzQS2zYyL6ebUfCHQw8qKyJoIQJBAKnTjEYzZ2JSJEpUFXDv84rtgw/o
rB+DyK0/T7GL2zi2sr8kOGTbKhfChau8WMK+WORw83xDBVo2YI0EUxxBT7MCQFi/
RfGblqo38WqWd2QD0RlVQNqVqiKQNxfRiiVwaxUzs6NTskqastjyJBUO1MKxFMni
JgViROFw+y20i4uG+GECQBJ4/YRtaJrxMInKJa7bILbxMm0XMJXsiYvwtrhZwPVl
2/F88VroQYVzIsUYOYK3vg6ldYHMQgEPhdplhc/vZpY=
-----END RSA PRIVATE KEY-----', 3);

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
    VALUES ('nelca.balisado_villarin@dlsu.edu.ph', 20111112, '1234', 'Nelca', 'Balisado-Villarin', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCVHtq2eH91z0KzdE8k0Aai7F/Q
tKcl4cxhQJwUgu7lRJRXqRGQPjKSsNtYfbWwcvrbujX2raAgGBrR+3r74Sh5PzVT
ZAZK3k8IPAYPsgy2vPaRwC/BTY0XnHxjuZ45tpQLARMbE6ekDR+IzryLWivcctCI
CdCtimFkHk1bDfKAhQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQCVHtq2eH91z0KzdE8k0Aai7F/QtKcl4cxhQJwUgu7lRJRXqRGQ
PjKSsNtYfbWwcvrbujX2raAgGBrR+3r74Sh5PzVTZAZK3k8IPAYPsgy2vPaRwC/B
TY0XnHxjuZ45tpQLARMbE6ekDR+IzryLWivcctCICdCtimFkHk1bDfKAhQIDAQAB
AoGALU4FduCfIOTKSAkzLmUBTyhvZ9Iq4ih61qUxhk3NVNyEESntixxKcyTGT1lK
BQS50F3/nSVc+8M3CsrTr4jVqZ80llON+lNr935mnzBJOqUXrTlbI7KJMm2qRch8
hK1VxsaW8euABl/Jd+WDWwArYd1lfQbGHrwlcvzzz1hy9hUCQQDxeAzpdNsFufho
GRf4KwHA4QW2mY5xmwyEGpc/6zFgyvsRqmVNooU5C3SZE7AZvcPriGWKAIrBPsXj
WD0Sqz5rAkEAnhghYkbkbhugY762c4I+N+4slcbwjwWp9fRJvw9ljUIptY4eNPp9
NzWnOB/8G6QBc9zjJf2a9WnBXSkH3SMYzwJBAKzgDh52EvielEGy9X4vDCpS8Awz
E9Ax+Vv6zZ5tfASYTffvzmcum8KjeO6/May8N7BBDrEmgjCoCHUjj1X2U9ECQQCT
Y3XENMmEKbdnJobcu2EcLa1dWaIuBJ7GkaArQsRvZG6UN9HLnHgef6PNPGyCrG06
QoV2hq/v+k9udfFB5hWbAkAdjPOT7CZ2i2kYNQLWADlX/b+o4bo4Jw51rPSty+r/
ssySvgGl9ggP11vrORaMIa/domqWw7ONL48qTM6TW//v
-----END RSA PRIVATE KEY-----', 4);

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
    VALUES ('michael_broughton@dlsu.edu.ph', 20111113, '1234', 'Michael', 'Broughton', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCDMPPM2aRhI/BbEV1YTNKV1e0J
fBoWVJj3Z24izrnSk0G3EItVYx0wh9xviFDM022EjDs5KFNA7UMgq4k7M1ytq/oM
iOeTzCjJQ/a9mel0exGk/1t2fz1tHieUt6JSjxbq1Fn8m5gLPGO+oejo1N7Wuxcm
3/xyb6TWONUr0/rn1QIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICWwIBAAKBgQCDMPPM2aRhI/BbEV1YTNKV1e0JfBoWVJj3Z24izrnSk0G3EItV
Yx0wh9xviFDM022EjDs5KFNA7UMgq4k7M1ytq/oMiOeTzCjJQ/a9mel0exGk/1t2
fz1tHieUt6JSjxbq1Fn8m5gLPGO+oejo1N7Wuxcm3/xyb6TWONUr0/rn1QIDAQAB
AoGAQPfSFIVHkU+h7QdpaZwJwWgCjermZF6arhKLiTNE9NI1/fl0duGxh+IQOS+R
jA28M6LahVDCAeo9jwVD3Yxu/V7C4jRQCO2h89OEbBUUMw2Rz9+BBxqFeQLuMPLL
cGOltN5FPh0VTJ8/7SRJrh7GByV9U/rrRICPMbpQ4PRZagECQQDXeeBbBYKn/Fay
1AXeTVtoceUNdQE2RPUNxcTVuvvvEY46fTBrHqc1JuVzu/ms+nkOrSaJnlNyDW0u
F2v6QGuBAkEAm90rqDa5rPUqd+R+YFpiHbMaYmvOJSnBhTMPzj59XpcsH10G+5c/
oSIS7PPMoI0efN7K/WwgZV/MeuC+4uo2VQJAZWW85hhZu6NLSSvs9weAFE5Ec2i0
AU3B45FFZy5uj7m7LFrtBfuOw7xiDWxPuc7EWNuyXuBadDlNP3tWHJVkAQJADdHv
lAu+LPLUICtXdU2uU3nVBhMPBUaNjTT42s25qhB3bhR+kQJZNv1hdjcr1rSMln/e
udfDi5mR9PdGlbI0vQJAA3H1Jo2Y7rgFmUbH1DVSAY9bq/VcQGY38RAMH2ZhnhAb
ZfcWDwvDmQo1dVyyGo2SuOkhkGwvv6zjAy5jj0jWiA==
-----END RSA PRIVATE KEY-----', 5);

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
    VALUES ('raymundo.suplido@dlsu.edu.ph', 20111114, '1234', 'Raymundo', 'Suplido', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC30FZyZj8mXFG3+PhdCjUuq3XZ
A/tgETJF2MWykVDA9PtGHBUpGW6SX9XjZvzQ8yiZEuJ6omdgvXB3l4UszbYqpcS+
8qfMvku8z5djxon9iFBdboy20z9SaTh7R1HaPPiDGI/ekRRVjrjiRtz+1OwB2tmV
O19bxmutmUVCreXNlwIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQC30FZyZj8mXFG3+PhdCjUuq3XZA/tgETJF2MWykVDA9PtGHBUp
GW6SX9XjZvzQ8yiZEuJ6omdgvXB3l4UszbYqpcS+8qfMvku8z5djxon9iFBdboy2
0z9SaTh7R1HaPPiDGI/ekRRVjrjiRtz+1OwB2tmVO19bxmutmUVCreXNlwIDAQAB
AoGAeH0RXXXWaT/UtUJ3Ew3Q5KGx4yowCb3b9Vrt5GpKw+ESINfhqwonp704SBLH
H/R0JTryyC5Sk2A6K7pfqonBoT2it9DmeRcbHAeuIR4j7ktee0PYySlC7tJkDCwT
xIjHNR8ERKJkLE5rbVSSiOFJm0+6t9/0RY8nK2jaPBclKLkCQQD6m/LsAkWSYMy4
yvcclKmJas1C4drQ0UMmNKyVYnio07tz53pomawgunnxCM7jkAa0HCV7l1cwF+ld
EdtPdLf1AkEAu8SPoEc666cgrOi5zDw0Mh38nRUBDSltZx9MtoAK1vcjoKs0v73u
Rb29eVQUjjaz7+7uBqKONjOSXmJ8zshT2wJAKQIDyiLFB6LXXRW5QfABnf7f/6W9
jJXxivrrkrY+UEH1Vo32Nc+PnvtkoNB0KkCTGD3S1Fp7Zd9DzHrzjBjpUQJAdE02
rQ8Rpr75FUB9PMyZg+Vg/6bv5MghNHuFl5DNpgKj9bO104IAIQB6aLk0ljW51EaI
9mEfduEQqxeTuL0KewJBAL1hayWIehvj1zGvJYmyc77IwQ2BFgdSw+b44ONE3Ocv
QPioERQTABNTUF3gFSCPhpnzv0RTU1aNTASBWMgT8L8=
-----END RSA PRIVATE KEY-----', 6);

INSERT INTO GOSM (termID, studentOrganization)
           VALUES (system_get_current_term_id(), 1);
UPDATE GOSM
   SET status = 3
 WHERE id%100000 = 1;


INSERT INTO GOSMActivity (gosm, goals, objectives, strategies, description, measures, targetDateStart, targetDateEnd, ActivityNature, ActivityType, isRelatedToOrganizationNature, budget)
                    VALUES ((SELECT id FROM GOSM WHERE id%100000 = 1 LIMIT 1), 'Goal Mo to', '{"Objectives", "Mo", "To"}', 'Strategies Mo to', 'Descibe kita', 'Measure mo to :)', '2017-9-6', '2017-9-6', 1, 2, false, 999.99);
INSERT INTO GOSMActivityProjectHead (idNumber, activityID)
                             VALUES (3333333, (SELECT id FROM GOSMActivity WHERE gosm%100000 = 1 LIMIT 1));

INSERT INTO ProjectProposal (actualDateStart, actualDateEnd, facultyAdviser, preparedBy, GOSMActivity, ENP, ENMP, venue, context1, context2, context3, sourceFundOther, sourceFundParticipantFee, sourceFundOrganizational, accumulatedOperationalFunds, accumulatedDepositoryFunds, comments)
                     VALUES ((CURRENT_TIMESTAMP - INTERVAL '2 day'), (CURRENT_TIMESTAMP - INTERVAL '1 day'), 4444444, 3333333, (SELECT id FROM GOSMActivity WHERE gosm%100000 = 1 LIMIT 1), 1, 1, 0, 'Context kita', 'Context parin kita', 'Context ulit kita',69.69, 69.69, 69.69, 69.69, 69.69, 'Comments ko toh');

INSERT INTO GOSMActivity (gosm, goals, objectives, strategies, description, measures, targetDateStart, targetDateEnd, ActivityNature, ActivityType, isRelatedToOrganizationNature, budget)
                 VALUES ((SELECT id FROM GOSM WHERE id%100000 = 1 LIMIT 1), 'Goal Mo to 2', '{"Objectives 2", "Mo 2", "To 2"}', 'Strategies Mo to 2', 'Descibe kita 2', 'Measure mo to :) 2', '2017-10-13', '2017-10-14', 1, 2, false, 999.99);

UPDATE ProjectProposal
   SET status = 3
WHERE id = 1;

INSERT INTO ProjectProposalExpenses (projectProposal, material, quantity, unitCost)
                              VALUES(1, 'Boyfriend Material 1', 7, 60.0000);
INSERT INTO ProjectProposalExpenses (projectProposal, material, quantity, unitCost)
                              VALUES(1, 'Boyfriend Material 2', 80, 60.0000);
INSERT INTO ProjectProposalExpenses (projectProposal, material, quantity, unitCost)
                              VALUES(1, 'Boyfriend Material 3', 80, 60.0000);

INSERT INTO ProjectProposalProgramDesign (projectProposal, dayID, date, startTime, endTime, activity, activityDescription, personInCharge)
                                  VALUES (1,    1, '2017-10-14', '21:34:03', '23:00:00', 'Aguy', 'Gansa', 3333333);

DELETE FROM ProjectProposalExpenses
 WHERE projectProposal = 1
   AND sequence = 1;


COMMIT;
