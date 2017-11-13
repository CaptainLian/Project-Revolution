ROLLBACK;

START TRANSACTION;

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
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiVnKCWbYdHNGPDJbn0DN
4tIqFhWgH7V0s3rTOdG1+996QqI69kck9T3awwDxEM4ayfHKQer1Q7VKsz57q3FJ
OBMpiutqvAdUyde9XtFg5FU/Gj99ygoEcvyH2ua6KfrjEmbU6tsQHuthxgvhKPQJ
tpzLpLW8EG3BWXr3zUAS4CB+vvEO0bbVlPKKx4lYhst7QryUxqVwgqXVSnX16NnX
QMtvHPdtp4UfiAFbHmYUcJ+oHFj0vK430x99Of372Ul4Il0jpxYL87DUI/biGIZU
gsgkECAbVTk+qt7iA2eHFjW35Pq8Vv1Rj+vrXYt7KS75ZyHWBgLrIoG0dQpPXI6t
/QIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAiVnKCWbYdHNGPDJbn0DN4tIqFhWgH7V0s3rTOdG1+996QqI6
9kck9T3awwDxEM4ayfHKQer1Q7VKsz57q3FJOBMpiutqvAdUyde9XtFg5FU/Gj99
ygoEcvyH2ua6KfrjEmbU6tsQHuthxgvhKPQJtpzLpLW8EG3BWXr3zUAS4CB+vvEO
0bbVlPKKx4lYhst7QryUxqVwgqXVSnX16NnXQMtvHPdtp4UfiAFbHmYUcJ+oHFj0
vK430x99Of372Ul4Il0jpxYL87DUI/biGIZUgsgkECAbVTk+qt7iA2eHFjW35Pq8
Vv1Rj+vrXYt7KS75ZyHWBgLrIoG0dQpPXI6t/QIDAQABAoIBAAPyzNgQWNCgL7iz
Seb+Ge0XVZZk8MF4me4+7auP18dx2TXpLADActOJ/6vzbvqosiR0CvhyJLLZl1gn
x65aB1zRUDRqKBtXqpxS02LSahKmULYUdS1FtHMJx24Hi/qA994jjqNhwMjiw2DK
HqLqwQy63S/S+aEPRqun2U/RM7m1qqcdRO6gpz0q2UjAtOG4nOSAl6Gj8ks0iFkD
mL1gJBLzTtW9LqIaq+ZynqZSh+yax2gDXD1l52L7POpz3XFIajbei4lqoz2z1Pu0
JHrdVPg5fOH0kNOMOuo7iL0KvZvCt1GoNaXnSBbMJvzrObTV2IzFYMJla8vPsSjd
pDEiaBECgYEAu+sbrc3170ivwFPtC7FkLVEbm4/+lYSajCdmGu0zqJzseBicNToe
BHShEJ3fpWgbFbLYEoj6DPzWyURo11o8NDs13o9W9iGcRRed5rKYOCRwLkEM2c3j
CbIsukBQhA+RwrQrYkIaDfdUpM2+Cy8BcYaujkDShCiIXWbXNAKJKGcCgYEAuxyt
Jt8fOB9ogSFEkhMph/MOv0voFloPJq9MfeiBka9ec1eDZAGbjiaZwWfn9n0CH+SB
76/hLFjqr+zHtF/Ri77UU8XsG8DQQNgEKtHYZHIevVumt3VBwwpMp/SfE4kKzxff
NWDa1yb2JlkmN/xprHsXwqMxvCRwPW8cIpV0x/sCgYAj83TWKYMVhjhpeSTuib96
k/vOJRw1iqruiVMVb6/kYDE1QLAR1s6LV6zAuxNgV6xm2FJSKXZ9KZoF41qTaKX/
8Bv8OjwO1ptI9J221xAcHYyArN1ChgsbfcTk1Q0SVtAyCboLEE5fwaOl696h0Rpb
l8KpYGll80Mza0tcneeTnQKBgG09gsHtBhcID0VEnPoDgf3DI9r/gBJ8pdfaBHiF
5A+gKS6B603Zum21j5LhDQZVWYYxLMM5FeeEShBH1xgx0O8bjG8UYJKbcXpKI7S0
KvgJwHShK6Z0KN6sBrEQGkeXfN4He+N4FowCTTd6WNva2/89JlQWXxUO2RCk6/Is
+689AoGBAIS5ebhxpnwjEPHraX8sJKovB61RWhZJM2UdWrj8h4xNnYeihmLduuNP
Mwa7xuTtikKf6Y7+O7ayCwL6mOycRQ8qojl4qw6xXDLfvbP2T1i8BYwqmWZFCWKS
+UNu/01W+MqxFLaFGAZPnIUCb+XaYfkxU7OhNoU0OXp3X/0Yg9hC
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (11445955,   10, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
             VALUES ('markus_flores@dlsu.edu.ph', 11445954, '1234', 'Markus', 'Flores', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjDWpD8+30QIyCoKBMD1W
qbwQVisaXbbsrKq0mxl6EBQ+1N/LGlsM4oSYryFHiznNLkN2eThIkA0Xih1ogVCh
zahmmDtMO7NtSGQlEu6zvb2De3/QSRcbu/Q5Yt0LUWBEnmW5zbPa89WlzlstJMMT
KuBKBY7OEOz/fVXZFSHdyISbHj4RkNLi65Ss1/31HJw8bK3u8WFN7a2JCTlCHJiB
Ioq7A+/bMmUvus8FSWpcs/pZM1KC+0OUp5P6mdqXnzvW1u7eOk9Pm2b2v6x6UTyM
YIamg5GhiDW1Janic42GRXzesJx6bWWaddPdHEe1HWbtdfKLaLfP09FYyU6/4F7w
7wIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAjDWpD8+30QIyCoKBMD1WqbwQVisaXbbsrKq0mxl6EBQ+1N/L
GlsM4oSYryFHiznNLkN2eThIkA0Xih1ogVChzahmmDtMO7NtSGQlEu6zvb2De3/Q
SRcbu/Q5Yt0LUWBEnmW5zbPa89WlzlstJMMTKuBKBY7OEOz/fVXZFSHdyISbHj4R
kNLi65Ss1/31HJw8bK3u8WFN7a2JCTlCHJiBIoq7A+/bMmUvus8FSWpcs/pZM1KC
+0OUp5P6mdqXnzvW1u7eOk9Pm2b2v6x6UTyMYIamg5GhiDW1Janic42GRXzesJx6
bWWaddPdHEe1HWbtdfKLaLfP09FYyU6/4F7w7wIDAQABAoIBADiCkCctQxrcVari
uorkzf8PK05vhOrshSt6idxRQl8kqcZGhKeUtva9FoTPVvSIUWgqDKACzUwx2qDy
BWLJSs2G6ALHM4yEXrFkm4Sr7Im2zj2CYEJ1K9pvLonoKV2c/UsSGPcNXFwWagNn
wCQm85y+VVc0HV25B6hOZ3Ya9jaQkpueE5ZM5JcQMIQy2QCO7GBrY5b1c9/lZaOW
/xUgHtP+5yJrFbAFAKo7OFdnjRsqcGClJYpXMtycHD2T/anFx41owNPo42VLymfm
NKjyyE/w39VEeIsqpifW4bveC4lpuHIvO0ZrCZtQbRkS2Z0Tvv1k0/WaJmpY8ASb
9S195MECgYEAyqli4mVPbnnqbIVxn4ESzegNQN3f40utvnZyLnvpiZsTjaxkvetJ
e2oujt7FQUGr6OKgXeObtZVR8azFAV9kbPuzfUXLvCKNi/wkXlbyKkL8B1UxFJJu
PMafzd0lA86Z8jLc6JRxI7sz5CRLYoNaxYw9+Lft6707MBJ1zmfwiLECgYEAsRx6
vSbRaEWAYvoHd5fG8kZyeCDK6Uq9spEav9mt3MxHtwfa5YAR8p8XzV2ZzTUFCYhU
42f5dwWNXvQtLyZlZ8VTULSIAJS2JES3xK6QYoP0CEcqeNflvBLZ/mLPou/xz9Ld
du1OBBwpxFjOucMlpQ/pjgjKFaq0EIIpsphde58CgYBpCkJmdXwmFqqadM/fjFbi
wlOcO2O/u4niHiIwValF2UrZM3FDvp/nh7F5+5zhpdgkbNIR19bs1ugSCypQ+9Bh
bFQrqfFfIcmbtKRlAUui+/UFF/LIZt0cQxaw7N4yivLfxd0Z71Z03qKWrPklpk91
9KpqL2rxtLLox6inwte5AQKBgEBkPU+V1F6XnjTd+GcHnIIrEKUSLxOgY9WPIe2M
Y8S51Hz78x6rcFsIcmvs0uUjmKA9m7dN7wnRz/MszVyuFgIjYMYfzK6BYrNO9I0i
dkYK+WclEJD81X6KUA1HuXvgxsarQG9jmZCu+JR1QTuScpZPcbd9BJPaCztRR32y
HZK7AoGAPPyGiRs4E/qWlXbOgIpk5ArVyON4zRtHz14I+Iw92+Sx2Z13wdMjMM1m
N42mDkLiwMrDjLKu9Kql8dSWM9EBptdhmTHJ/lHIZaOHuHV1TS1SvH8InxxHQrFH
IABnJjph404aO0FT5m14xZDFUFXaKoyadX/emoeglPtg3m/YDVU=
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (11445954,  30039, system_get_current_year_id());
INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (11445954,  20031, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
             VALUES ('dominique_dagunton@dlsu.edu.ph', 11445953, '1234', 'Dominique', 'Dagunton', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAkJXvbAsCxEbsSYi5i53b
xCt72VnKykxiwIVlb902o1E1342/3LC/j3zOzZke+oTSE8HMe3be8n9FKUpmuMCJ
VqGR7/2wBkgIGb+WfjiQPX7fuGJYIv5dIG+Pl/vR2HDCJ/T7mpKYkHElXW6kMZ2V
U3gFksgeFgf3LbL5WJcxHWj4KTigwGFAUV82ZO1Mg/50CKnsnNwri42j1sHD6BsK
h27M6nnS/IZF+Ss2+fGmO6elpgPIfVcyi0JiZOOJC7MK896PcQAmxBwAhKD7nF6F
Qz8uUh5HjTbx4nPG40kDAtg9LSH77O6ZgOWonPzqGIDjm1JX5qvYjrk761VxlWm7
yQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAkJXvbAsCxEbsSYi5i53bxCt72VnKykxiwIVlb902o1E1342/
3LC/j3zOzZke+oTSE8HMe3be8n9FKUpmuMCJVqGR7/2wBkgIGb+WfjiQPX7fuGJY
Iv5dIG+Pl/vR2HDCJ/T7mpKYkHElXW6kMZ2VU3gFksgeFgf3LbL5WJcxHWj4KTig
wGFAUV82ZO1Mg/50CKnsnNwri42j1sHD6BsKh27M6nnS/IZF+Ss2+fGmO6elpgPI
fVcyi0JiZOOJC7MK896PcQAmxBwAhKD7nF6FQz8uUh5HjTbx4nPG40kDAtg9LSH7
7O6ZgOWonPzqGIDjm1JX5qvYjrk761VxlWm7yQIDAQABAoIBACHtLLr7cnC/+53d
mTwrlG/ZjDwaF72UYu+t3Xl8PN/hpHSKfGS6jJiMvrH7pgs+s1SzetnVsMbSGlZw
AN6FPzS2wNnBe1Zd/JieHiAMAbyMUs6fNPMxIIUF6HnPOxRAkS5zC77fezEZe50K
4zhJM8rcNOKWVojw4Y01m9Cv2XR+3FcLE071g/vHo+nWKjBKZ/HJQjosRpTdWxJF
K3r6HSd9CPUUgjn3Kc8NBj2Fb2iJMzwrkPeiWwuAs21MtHsaUvidwnnAN9AR3d3S
HqbU1w8qzTc2FqWdg3/Tfacsauw/YBvu7h7D/YaYfQWsAFHeVrEd3gt6dM5OFxUl
cvGCfUkCgYEA09jHX5Qf8Oi/vV76WOiCrH2rzaGwZBfcNVcNqMRFXyvxY8N4AACH
jpUVFnkeG1xio1ue94Akzfs/+h22MQx+JZaMwr0jOMtnXEQWNmibaR9LG24xJltW
u+/wEpjzrYg8o8XbEHjKDpvyjm82Q6fyX5qf+FIU7Jz6a0SpryWuHYMCgYEArrhl
oQbRjwu88X2kCywSIfeUJR3jfA364UVEm4U6LsbT3mE26CbSVrvnKRWGLy4ZsmUM
mczl54tzytRGt7ikf01CbsmXt8v/J8UWRAEhRKBPXEVS4SQ49G9ijUIkSi5b3jN0
KnObsrRfe0uwxqMvt6a56W4GwKYnAM6ujgPm68MCgYBLuVc64PWx5WB0TnjqQuJC
ygEZVcx5WtYJ8v4c71tks45rfLluNsI9wyhwigaq/RD9F4jxK0r8ney2eNxhF/gX
c4MJMRZf/MULhAL0m9vBbcApI/BJp6iPMSr9WtLvmp0iZVzyvFptcmz3YOVitau7
ZMf9uUllco9IvJhy1OMyBQKBgEr4Uptiyp6/oaZZi/9DPNCYZFf82DTN5t2slEDL
TOjvZc/hFOdOaSjQXeMSGk66UEps85g3BFtzSg85QNLqhqMdKqlRFSnHfce52ND7
TyQcSZFFKcfzfADenoIQZHP0KnVQzMK+coueu+2yz7qcIQiDoPhZvsoBQXEmPl4v
rHFzAoGAdZFx9nobrNzsRetXuL7pcxtVngiDM+5+9jaeA57VE8id1ggsIr1MlZEb
pqQBSqfr7cM32loIRyhuDd+9eM1fqtumG8LI3FRm5HtZuZr5Eds7ywIXGB6ugP6M
6V4EL/W4vAfjCvu1dmH45Vx3MgJPhtinyaT4yqiMLv8N/YBKkyU=
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (11445953,    1, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
             VALUES ('neil_capistrano@dlsu.edu.ph', 11445952, '1234', 'Neil', 'Capistrano', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArdjmjQSvYOuZD4w1J3oD
AZyWknSkIEebVNh5T563AtBoEfkSYfhW+MaumUBkJNt40Cl8Zp/wpy53cFwMHQ/L
vO9VMTogiysoeSLzjdNspEnWapZlcp+XPXRD9TDVwGxKHeF81eAeDpHwV7G42EFo
IV9HUW47kk0jljqmoRbWfcCD9ryjaz9DGiBoV5lhxpQSF5JhydYgt1B+Z5m602fC
acZCR7jf817RtmUxbRxHmwUMd73GJwVIgzQkG+HoyUeyRDbtbJJDlJs+NsV5f5xU
I9dE3OxApAimpcEOKCezzH0vEB498mgLbi9ZQdyyeCJZRnJHmVbyWdSdmc1TiZYQ
zQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEArdjmjQSvYOuZD4w1J3oDAZyWknSkIEebVNh5T563AtBoEfkS
YfhW+MaumUBkJNt40Cl8Zp/wpy53cFwMHQ/LvO9VMTogiysoeSLzjdNspEnWapZl
cp+XPXRD9TDVwGxKHeF81eAeDpHwV7G42EFoIV9HUW47kk0jljqmoRbWfcCD9ryj
az9DGiBoV5lhxpQSF5JhydYgt1B+Z5m602fCacZCR7jf817RtmUxbRxHmwUMd73G
JwVIgzQkG+HoyUeyRDbtbJJDlJs+NsV5f5xUI9dE3OxApAimpcEOKCezzH0vEB49
8mgLbi9ZQdyyeCJZRnJHmVbyWdSdmc1TiZYQzQIDAQABAoIBAB1+BG678rywe0Dl
+kZ+LnBhjjG+U/Gd9D4Kk1nshQOXM3CJHpM8PBTsL8aT4+lUykQWJaKLU5opCd4n
3242tcuRlpRJVigF5FHYmhTfXzjnxdZDOWaeqFumk7jO1hRUyqYTEMh/wtmZ7HoU
DlWxkubGcSThXH3PVFAyFv6RD0Y50A4em/2ObFeyOavBlmXNwxdXkeWJCtWDlDdU
ebM6ZKufJwKQ6EJitFPRyKo7XQWTGNJ9TYtX0Hp4w0wFG6OOF6bsZJ3Jh73fJhqE
mlLrvC1v5wsJUCojXrzBjGl2uMNL01m+AXwKLY23XSP828cZvAfQAR7x4w9XlYzZ
z87zNwECgYEA+eBhZS9RDJEIxxlc8ubzFiIaHMtYNK4y3XLtj2nTxYRTRkUuZWCZ
AfqfdwXzOUGDR5/ViEfAUOwKpoqJT5dW1CU7iAQFcI1l8zXt9l/EAvc3IsN36pBV
rGRdfYDZdxPweRU4skehUcj5WBewl7hWzIRqxEPbaDoBpxCbKeXNqe0CgYEAshuL
gKLwJkbPqn/383g9WrUTHKxz39G00mTiTWe73uqcaoo13QBmJWxUwLYvGyFeEeWg
rU1BSYJpC/yi+rd/C/cCIVcX3U+3/NDLPj4NqllW8kbCx76bVUAL/o4W4M1CXnI7
FLcUbF+bKOwMhMK1JI3OY0Kf0/Zos6jBgXE9pmECgYBWNc8EjQ2mi0d/AcYq2/mU
clGWC6Y0DsHn22YQ688vv1bH0MiQG4LOxvxLoVboMy0rAf83FKJKiRWnnfZ/6lP/
v5TJebGywmYhQkMGlMXYzBhOuyfdWszkPIBw84qT5eI6tFKqV8JVqEQ2232G6wev
aiQ38L17OUAmtrkB/JI3hQKBgH4YHjWeJaMTsuYk3yhR0i4r0DIWrZqh3wCtR8JB
VLLHKqIK44NpSufnwEEHOmZcwzqsdYr8DOK8Hx7LZ59U1e9kmu97t3uJetrT/3A7
gnU99t5j1naPrW03gMZhVjUlXH19JfLOgvkO3sykAWDkcFZGxv1jJ8BqzUmUihrY
TytBAoGBAI/ER2xg4RY59hEr0ST9tIwpV/4r6S6bDAiCsFmfMMfU4U7TPocfouMY
BXKAD/glJ44EL4z82axYP0LA6Abe/pfkc8dwWsEAayYjYV+8qzQ7mtHRKxmLxHTm
BtfxKI72NnSS70p1VAzKACZXwMRR5RRhOz75s1bJ3JK18AMSRc3r
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
             VALUES ('org_pres@dlsu.edu.ph', 1111111, '1234', 'Organization', 'President', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArdjmjQSvYOuZD4w1J3oD
AZyWknSkIEebVNh5T563AtBoEfkSYfhW+MaumUBkJNt40Cl8Zp/wpy53cFwMHQ/L
vO9VMTogiysoeSLzjdNspEnWapZlcp+XPXRD9TDVwGxKHeF81eAeDpHwV7G42EFo
IV9HUW47kk0jljqmoRbWfcCD9ryjaz9DGiBoV5lhxpQSF5JhydYgt1B+Z5m602fC
acZCR7jf817RtmUxbRxHmwUMd73GJwVIgzQkG+HoyUeyRDbtbJJDlJs+NsV5f5xU
I9dE3OxApAimpcEOKCezzH0vEB498mgLbi9ZQdyyeCJZRnJHmVbyWdSdmc1TiZYQ
zQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEArdjmjQSvYOuZD4w1J3oDAZyWknSkIEebVNh5T563AtBoEfkS
YfhW+MaumUBkJNt40Cl8Zp/wpy53cFwMHQ/LvO9VMTogiysoeSLzjdNspEnWapZl
cp+XPXRD9TDVwGxKHeF81eAeDpHwV7G42EFoIV9HUW47kk0jljqmoRbWfcCD9ryj
az9DGiBoV5lhxpQSF5JhydYgt1B+Z5m602fCacZCR7jf817RtmUxbRxHmwUMd73G
JwVIgzQkG+HoyUeyRDbtbJJDlJs+NsV5f5xUI9dE3OxApAimpcEOKCezzH0vEB49
8mgLbi9ZQdyyeCJZRnJHmVbyWdSdmc1TiZYQzQIDAQABAoIBAB1+BG678rywe0Dl
+kZ+LnBhjjG+U/Gd9D4Kk1nshQOXM3CJHpM8PBTsL8aT4+lUykQWJaKLU5opCd4n
3242tcuRlpRJVigF5FHYmhTfXzjnxdZDOWaeqFumk7jO1hRUyqYTEMh/wtmZ7HoU
DlWxkubGcSThXH3PVFAyFv6RD0Y50A4em/2ObFeyOavBlmXNwxdXkeWJCtWDlDdU
ebM6ZKufJwKQ6EJitFPRyKo7XQWTGNJ9TYtX0Hp4w0wFG6OOF6bsZJ3Jh73fJhqE
mlLrvC1v5wsJUCojXrzBjGl2uMNL01m+AXwKLY23XSP828cZvAfQAR7x4w9XlYzZ
z87zNwECgYEA+eBhZS9RDJEIxxlc8ubzFiIaHMtYNK4y3XLtj2nTxYRTRkUuZWCZ
AfqfdwXzOUGDR5/ViEfAUOwKpoqJT5dW1CU7iAQFcI1l8zXt9l/EAvc3IsN36pBV
rGRdfYDZdxPweRU4skehUcj5WBewl7hWzIRqxEPbaDoBpxCbKeXNqe0CgYEAshuL
gKLwJkbPqn/383g9WrUTHKxz39G00mTiTWe73uqcaoo13QBmJWxUwLYvGyFeEeWg
rU1BSYJpC/yi+rd/C/cCIVcX3U+3/NDLPj4NqllW8kbCx76bVUAL/o4W4M1CXnI7
FLcUbF+bKOwMhMK1JI3OY0Kf0/Zos6jBgXE9pmECgYBWNc8EjQ2mi0d/AcYq2/mU
clGWC6Y0DsHn22YQ688vv1bH0MiQG4LOxvxLoVboMy0rAf83FKJKiRWnnfZ/6lP/
v5TJebGywmYhQkMGlMXYzBhOuyfdWszkPIBw84qT5eI6tFKqV8JVqEQ2232G6wev
aiQ38L17OUAmtrkB/JI3hQKBgH4YHjWeJaMTsuYk3yhR0i4r0DIWrZqh3wCtR8JB
VLLHKqIK44NpSufnwEEHOmZcwzqsdYr8DOK8Hx7LZ59U1e9kmu97t3uJetrT/3A7
gnU99t5j1naPrW03gMZhVjUlXH19JfLOgvkO3sykAWDkcFZGxv1jJ8BqzUmUihrY
TytBAoGBAI/ER2xg4RY59hEr0ST9tIwpV/4r6S6bDAiCsFmfMMfU4U7TPocfouMY
BXKAD/glJ44EL4z82axYP0LA6Abe/pfkc8dwWsEAayYjYV+8qzQ7mtHRKxmLxHTm
BtfxKI72NnSS70p1VAzKACZXwMRR5RRhOz75s1bJ3JK18AMSRc3r
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (1111111, 10023, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
             VALUES ('org_vp@dlsu.edu.ph', 2222222, '1234', 'Organization', 'VP - Finance', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArdjmjQSvYOuZD4w1J3oD
AZyWknSkIEebVNh5T563AtBoEfkSYfhW+MaumUBkJNt40Cl8Zp/wpy53cFwMHQ/L
vO9VMTogiysoeSLzjdNspEnWapZlcp+XPXRD9TDVwGxKHeF81eAeDpHwV7G42EFo
IV9HUW47kk0jljqmoRbWfcCD9ryjaz9DGiBoV5lhxpQSF5JhydYgt1B+Z5m602fC
acZCR7jf817RtmUxbRxHmwUMd73GJwVIgzQkG+HoyUeyRDbtbJJDlJs+NsV5f5xU
I9dE3OxApAimpcEOKCezzH0vEB498mgLbi9ZQdyyeCJZRnJHmVbyWdSdmc1TiZYQ
zQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEArdjmjQSvYOuZD4w1J3oDAZyWknSkIEebVNh5T563AtBoEfkS
YfhW+MaumUBkJNt40Cl8Zp/wpy53cFwMHQ/LvO9VMTogiysoeSLzjdNspEnWapZl
cp+XPXRD9TDVwGxKHeF81eAeDpHwV7G42EFoIV9HUW47kk0jljqmoRbWfcCD9ryj
az9DGiBoV5lhxpQSF5JhydYgt1B+Z5m602fCacZCR7jf817RtmUxbRxHmwUMd73G
JwVIgzQkG+HoyUeyRDbtbJJDlJs+NsV5f5xUI9dE3OxApAimpcEOKCezzH0vEB49
8mgLbi9ZQdyyeCJZRnJHmVbyWdSdmc1TiZYQzQIDAQABAoIBAB1+BG678rywe0Dl
+kZ+LnBhjjG+U/Gd9D4Kk1nshQOXM3CJHpM8PBTsL8aT4+lUykQWJaKLU5opCd4n
3242tcuRlpRJVigF5FHYmhTfXzjnxdZDOWaeqFumk7jO1hRUyqYTEMh/wtmZ7HoU
DlWxkubGcSThXH3PVFAyFv6RD0Y50A4em/2ObFeyOavBlmXNwxdXkeWJCtWDlDdU
ebM6ZKufJwKQ6EJitFPRyKo7XQWTGNJ9TYtX0Hp4w0wFG6OOF6bsZJ3Jh73fJhqE
mlLrvC1v5wsJUCojXrzBjGl2uMNL01m+AXwKLY23XSP828cZvAfQAR7x4w9XlYzZ
z87zNwECgYEA+eBhZS9RDJEIxxlc8ubzFiIaHMtYNK4y3XLtj2nTxYRTRkUuZWCZ
AfqfdwXzOUGDR5/ViEfAUOwKpoqJT5dW1CU7iAQFcI1l8zXt9l/EAvc3IsN36pBV
rGRdfYDZdxPweRU4skehUcj5WBewl7hWzIRqxEPbaDoBpxCbKeXNqe0CgYEAshuL
gKLwJkbPqn/383g9WrUTHKxz39G00mTiTWe73uqcaoo13QBmJWxUwLYvGyFeEeWg
rU1BSYJpC/yi+rd/C/cCIVcX3U+3/NDLPj4NqllW8kbCx76bVUAL/o4W4M1CXnI7
FLcUbF+bKOwMhMK1JI3OY0Kf0/Zos6jBgXE9pmECgYBWNc8EjQ2mi0d/AcYq2/mU
clGWC6Y0DsHn22YQ688vv1bH0MiQG4LOxvxLoVboMy0rAf83FKJKiRWnnfZ/6lP/
v5TJebGywmYhQkMGlMXYzBhOuyfdWszkPIBw84qT5eI6tFKqV8JVqEQ2232G6wev
aiQ38L17OUAmtrkB/JI3hQKBgH4YHjWeJaMTsuYk3yhR0i4r0DIWrZqh3wCtR8JB
VLLHKqIK44NpSufnwEEHOmZcwzqsdYr8DOK8Hx7LZ59U1e9kmu97t3uJetrT/3A7
gnU99t5j1naPrW03gMZhVjUlXH19JfLOgvkO3sykAWDkcFZGxv1jJ8BqzUmUihrY
TytBAoGBAI/ER2xg4RY59hEr0ST9tIwpV/4r6S6bDAiCsFmfMMfU4U7TPocfouMY
BXKAD/glJ44EL4z82axYP0LA6Abe/pfkc8dwWsEAayYjYV+8qzQ7mtHRKxmLxHTm
BtfxKI72NnSS70p1VAzKACZXwMRR5RRhOz75s1bJ3JK18AMSRc3r
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (2222222, 10029, system_get_current_year_id());


INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
              VALUES ('org_avp@dlsu.edu.ph', 3333333, '1234', 'Organization', 'AVP - Finance', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArdjmjQSvYOuZD4w1J3oD
AZyWknSkIEebVNh5T563AtBoEfkSYfhW+MaumUBkJNt40Cl8Zp/wpy53cFwMHQ/L
vO9VMTogiysoeSLzjdNspEnWapZlcp+XPXRD9TDVwGxKHeF81eAeDpHwV7G42EFo
IV9HUW47kk0jljqmoRbWfcCD9ryjaz9DGiBoV5lhxpQSF5JhydYgt1B+Z5m602fC
acZCR7jf817RtmUxbRxHmwUMd73GJwVIgzQkG+HoyUeyRDbtbJJDlJs+NsV5f5xU
I9dE3OxApAimpcEOKCezzH0vEB498mgLbi9ZQdyyeCJZRnJHmVbyWdSdmc1TiZYQ
zQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEArdjmjQSvYOuZD4w1J3oDAZyWknSkIEebVNh5T563AtBoEfkS
YfhW+MaumUBkJNt40Cl8Zp/wpy53cFwMHQ/LvO9VMTogiysoeSLzjdNspEnWapZl
cp+XPXRD9TDVwGxKHeF81eAeDpHwV7G42EFoIV9HUW47kk0jljqmoRbWfcCD9ryj
az9DGiBoV5lhxpQSF5JhydYgt1B+Z5m602fCacZCR7jf817RtmUxbRxHmwUMd73G
JwVIgzQkG+HoyUeyRDbtbJJDlJs+NsV5f5xUI9dE3OxApAimpcEOKCezzH0vEB49
8mgLbi9ZQdyyeCJZRnJHmVbyWdSdmc1TiZYQzQIDAQABAoIBAB1+BG678rywe0Dl
+kZ+LnBhjjG+U/Gd9D4Kk1nshQOXM3CJHpM8PBTsL8aT4+lUykQWJaKLU5opCd4n
3242tcuRlpRJVigF5FHYmhTfXzjnxdZDOWaeqFumk7jO1hRUyqYTEMh/wtmZ7HoU
DlWxkubGcSThXH3PVFAyFv6RD0Y50A4em/2ObFeyOavBlmXNwxdXkeWJCtWDlDdU
ebM6ZKufJwKQ6EJitFPRyKo7XQWTGNJ9TYtX0Hp4w0wFG6OOF6bsZJ3Jh73fJhqE
mlLrvC1v5wsJUCojXrzBjGl2uMNL01m+AXwKLY23XSP828cZvAfQAR7x4w9XlYzZ
z87zNwECgYEA+eBhZS9RDJEIxxlc8ubzFiIaHMtYNK4y3XLtj2nTxYRTRkUuZWCZ
AfqfdwXzOUGDR5/ViEfAUOwKpoqJT5dW1CU7iAQFcI1l8zXt9l/EAvc3IsN36pBV
rGRdfYDZdxPweRU4skehUcj5WBewl7hWzIRqxEPbaDoBpxCbKeXNqe0CgYEAshuL
gKLwJkbPqn/383g9WrUTHKxz39G00mTiTWe73uqcaoo13QBmJWxUwLYvGyFeEeWg
rU1BSYJpC/yi+rd/C/cCIVcX3U+3/NDLPj4NqllW8kbCx76bVUAL/o4W4M1CXnI7
FLcUbF+bKOwMhMK1JI3OY0Kf0/Zos6jBgXE9pmECgYBWNc8EjQ2mi0d/AcYq2/mU
clGWC6Y0DsHn22YQ688vv1bH0MiQG4LOxvxLoVboMy0rAf83FKJKiRWnnfZ/6lP/
v5TJebGywmYhQkMGlMXYzBhOuyfdWszkPIBw84qT5eI6tFKqV8JVqEQ2232G6wev
aiQ38L17OUAmtrkB/JI3hQKBgH4YHjWeJaMTsuYk3yhR0i4r0DIWrZqh3wCtR8JB
VLLHKqIK44NpSufnwEEHOmZcwzqsdYr8DOK8Hx7LZ59U1e9kmu97t3uJetrT/3A7
gnU99t5j1naPrW03gMZhVjUlXH19JfLOgvkO3sykAWDkcFZGxv1jJ8BqzUmUihrY
TytBAoGBAI/ER2xg4RY59hEr0ST9tIwpV/4r6S6bDAiCsFmfMMfU4U7TPocfouMY
BXKAD/glJ44EL4z82axYP0LA6Abe/pfkc8dwWsEAayYjYV+8qzQ7mtHRKxmLxHTm
BtfxKI72NnSS70p1VAzKACZXwMRR5RRhOz75s1bJ3JK18AMSRc3r
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (3333333, 10026, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
            VALUES ('faculty_adviser1@dlsu.edu.ph', 4444444, '1234', 'Faculty', 'Adviser', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArdjmjQSvYOuZD4w1J3oD
AZyWknSkIEebVNh5T563AtBoEfkSYfhW+MaumUBkJNt40Cl8Zp/wpy53cFwMHQ/L
vO9VMTogiysoeSLzjdNspEnWapZlcp+XPXRD9TDVwGxKHeF81eAeDpHwV7G42EFo
IV9HUW47kk0jljqmoRbWfcCD9ryjaz9DGiBoV5lhxpQSF5JhydYgt1B+Z5m602fC
acZCR7jf817RtmUxbRxHmwUMd73GJwVIgzQkG+HoyUeyRDbtbJJDlJs+NsV5f5xU
I9dE3OxApAimpcEOKCezzH0vEB498mgLbi9ZQdyyeCJZRnJHmVbyWdSdmc1TiZYQ
zQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEArdjmjQSvYOuZD4w1J3oDAZyWknSkIEebVNh5T563AtBoEfkS
YfhW+MaumUBkJNt40Cl8Zp/wpy53cFwMHQ/LvO9VMTogiysoeSLzjdNspEnWapZl
cp+XPXRD9TDVwGxKHeF81eAeDpHwV7G42EFoIV9HUW47kk0jljqmoRbWfcCD9ryj
az9DGiBoV5lhxpQSF5JhydYgt1B+Z5m602fCacZCR7jf817RtmUxbRxHmwUMd73G
JwVIgzQkG+HoyUeyRDbtbJJDlJs+NsV5f5xUI9dE3OxApAimpcEOKCezzH0vEB49
8mgLbi9ZQdyyeCJZRnJHmVbyWdSdmc1TiZYQzQIDAQABAoIBAB1+BG678rywe0Dl
+kZ+LnBhjjG+U/Gd9D4Kk1nshQOXM3CJHpM8PBTsL8aT4+lUykQWJaKLU5opCd4n
3242tcuRlpRJVigF5FHYmhTfXzjnxdZDOWaeqFumk7jO1hRUyqYTEMh/wtmZ7HoU
DlWxkubGcSThXH3PVFAyFv6RD0Y50A4em/2ObFeyOavBlmXNwxdXkeWJCtWDlDdU
ebM6ZKufJwKQ6EJitFPRyKo7XQWTGNJ9TYtX0Hp4w0wFG6OOF6bsZJ3Jh73fJhqE
mlLrvC1v5wsJUCojXrzBjGl2uMNL01m+AXwKLY23XSP828cZvAfQAR7x4w9XlYzZ
z87zNwECgYEA+eBhZS9RDJEIxxlc8ubzFiIaHMtYNK4y3XLtj2nTxYRTRkUuZWCZ
AfqfdwXzOUGDR5/ViEfAUOwKpoqJT5dW1CU7iAQFcI1l8zXt9l/EAvc3IsN36pBV
rGRdfYDZdxPweRU4skehUcj5WBewl7hWzIRqxEPbaDoBpxCbKeXNqe0CgYEAshuL
gKLwJkbPqn/383g9WrUTHKxz39G00mTiTWe73uqcaoo13QBmJWxUwLYvGyFeEeWg
rU1BSYJpC/yi+rd/C/cCIVcX3U+3/NDLPj4NqllW8kbCx76bVUAL/o4W4M1CXnI7
FLcUbF+bKOwMhMK1JI3OY0Kf0/Zos6jBgXE9pmECgYBWNc8EjQ2mi0d/AcYq2/mU
clGWC6Y0DsHn22YQ688vv1bH0MiQG4LOxvxLoVboMy0rAf83FKJKiRWnnfZ/6lP/
v5TJebGywmYhQkMGlMXYzBhOuyfdWszkPIBw84qT5eI6tFKqV8JVqEQ2232G6wev
aiQ38L17OUAmtrkB/JI3hQKBgH4YHjWeJaMTsuYk3yhR0i4r0DIWrZqh3wCtR8JB
VLLHKqIK44NpSufnwEEHOmZcwzqsdYr8DOK8Hx7LZ59U1e9kmu97t3uJetrT/3A7
gnU99t5j1naPrW03gMZhVjUlXH19JfLOgvkO3sykAWDkcFZGxv1jJ8BqzUmUihrY
TytBAoGBAI/ER2xg4RY59hEr0ST9tIwpV/4r6S6bDAiCsFmfMMfU4U7TPocfouMY
BXKAD/glJ44EL4z82axYP0LA6Abe/pfkc8dwWsEAayYjYV+8qzQ7mtHRKxmLxHTm
BtfxKI72NnSS70p1VAzKACZXwMRR5RRhOz75s1bJ3JK18AMSRc3r
-----END RSA PRIVATE KEY-----', 2);

INSERT INTO OrganizationFacultyAdviser (organization, faculty, yearID)
                                VALUES (           1, 4444444, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
            VALUES ('docu_vp@dlsu.edu.ph', 5555555, '1234', 'Organization', 'VP - Docu', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArdjmjQSvYOuZD4w1J3oD
AZyWknSkIEebVNh5T563AtBoEfkSYfhW+MaumUBkJNt40Cl8Zp/wpy53cFwMHQ/L
vO9VMTogiysoeSLzjdNspEnWapZlcp+XPXRD9TDVwGxKHeF81eAeDpHwV7G42EFo
IV9HUW47kk0jljqmoRbWfcCD9ryjaz9DGiBoV5lhxpQSF5JhydYgt1B+Z5m602fC
acZCR7jf817RtmUxbRxHmwUMd73GJwVIgzQkG+HoyUeyRDbtbJJDlJs+NsV5f5xU
I9dE3OxApAimpcEOKCezzH0vEB498mgLbi9ZQdyyeCJZRnJHmVbyWdSdmc1TiZYQ
zQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEArdjmjQSvYOuZD4w1J3oDAZyWknSkIEebVNh5T563AtBoEfkS
YfhW+MaumUBkJNt40Cl8Zp/wpy53cFwMHQ/LvO9VMTogiysoeSLzjdNspEnWapZl
cp+XPXRD9TDVwGxKHeF81eAeDpHwV7G42EFoIV9HUW47kk0jljqmoRbWfcCD9ryj
az9DGiBoV5lhxpQSF5JhydYgt1B+Z5m602fCacZCR7jf817RtmUxbRxHmwUMd73G
JwVIgzQkG+HoyUeyRDbtbJJDlJs+NsV5f5xUI9dE3OxApAimpcEOKCezzH0vEB49
8mgLbi9ZQdyyeCJZRnJHmVbyWdSdmc1TiZYQzQIDAQABAoIBAB1+BG678rywe0Dl
+kZ+LnBhjjG+U/Gd9D4Kk1nshQOXM3CJHpM8PBTsL8aT4+lUykQWJaKLU5opCd4n
3242tcuRlpRJVigF5FHYmhTfXzjnxdZDOWaeqFumk7jO1hRUyqYTEMh/wtmZ7HoU
DlWxkubGcSThXH3PVFAyFv6RD0Y50A4em/2ObFeyOavBlmXNwxdXkeWJCtWDlDdU
ebM6ZKufJwKQ6EJitFPRyKo7XQWTGNJ9TYtX0Hp4w0wFG6OOF6bsZJ3Jh73fJhqE
mlLrvC1v5wsJUCojXrzBjGl2uMNL01m+AXwKLY23XSP828cZvAfQAR7x4w9XlYzZ
z87zNwECgYEA+eBhZS9RDJEIxxlc8ubzFiIaHMtYNK4y3XLtj2nTxYRTRkUuZWCZ
AfqfdwXzOUGDR5/ViEfAUOwKpoqJT5dW1CU7iAQFcI1l8zXt9l/EAvc3IsN36pBV
rGRdfYDZdxPweRU4skehUcj5WBewl7hWzIRqxEPbaDoBpxCbKeXNqe0CgYEAshuL
gKLwJkbPqn/383g9WrUTHKxz39G00mTiTWe73uqcaoo13QBmJWxUwLYvGyFeEeWg
rU1BSYJpC/yi+rd/C/cCIVcX3U+3/NDLPj4NqllW8kbCx76bVUAL/o4W4M1CXnI7
FLcUbF+bKOwMhMK1JI3OY0Kf0/Zos6jBgXE9pmECgYBWNc8EjQ2mi0d/AcYq2/mU
clGWC6Y0DsHn22YQ688vv1bH0MiQG4LOxvxLoVboMy0rAf83FKJKiRWnnfZ/6lP/
v5TJebGywmYhQkMGlMXYzBhOuyfdWszkPIBw84qT5eI6tFKqV8JVqEQ2232G6wev
aiQ38L17OUAmtrkB/JI3hQKBgH4YHjWeJaMTsuYk3yhR0i4r0DIWrZqh3wCtR8JB
VLLHKqIK44NpSufnwEEHOmZcwzqsdYr8DOK8Hx7LZ59U1e9kmu97t3uJetrT/3A7
gnU99t5j1naPrW03gMZhVjUlXH19JfLOgvkO3sykAWDkcFZGxv1jJ8BqzUmUihrY
TytBAoGBAI/ER2xg4RY59hEr0ST9tIwpV/4r6S6bDAiCsFmfMMfU4U7TPocfouMY
BXKAD/glJ44EL4z82axYP0LA6Abe/pfkc8dwWsEAayYjYV+8qzQ7mtHRKxmLxHTm
BtfxKI72NnSS70p1VAzKACZXwMRR5RRhOz75s1bJ3JK18AMSRc3r
-----END RSA PRIVATE KEY-----', 2);
INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (5555555, 10027, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
         VALUES ('aps_vc@dlsu.edu.ph', 6666666, '1234', 'CSO', 'VC - APS', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArdjmjQSvYOuZD4w1J3oD
AZyWknSkIEebVNh5T563AtBoEfkSYfhW+MaumUBkJNt40Cl8Zp/wpy53cFwMHQ/L
vO9VMTogiysoeSLzjdNspEnWapZlcp+XPXRD9TDVwGxKHeF81eAeDpHwV7G42EFo
IV9HUW47kk0jljqmoRbWfcCD9ryjaz9DGiBoV5lhxpQSF5JhydYgt1B+Z5m602fC
acZCR7jf817RtmUxbRxHmwUMd73GJwVIgzQkG+HoyUeyRDbtbJJDlJs+NsV5f5xU
I9dE3OxApAimpcEOKCezzH0vEB498mgLbi9ZQdyyeCJZRnJHmVbyWdSdmc1TiZYQ
zQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEArdjmjQSvYOuZD4w1J3oDAZyWknSkIEebVNh5T563AtBoEfkS
YfhW+MaumUBkJNt40Cl8Zp/wpy53cFwMHQ/LvO9VMTogiysoeSLzjdNspEnWapZl
cp+XPXRD9TDVwGxKHeF81eAeDpHwV7G42EFoIV9HUW47kk0jljqmoRbWfcCD9ryj
az9DGiBoV5lhxpQSF5JhydYgt1B+Z5m602fCacZCR7jf817RtmUxbRxHmwUMd73G
JwVIgzQkG+HoyUeyRDbtbJJDlJs+NsV5f5xUI9dE3OxApAimpcEOKCezzH0vEB49
8mgLbi9ZQdyyeCJZRnJHmVbyWdSdmc1TiZYQzQIDAQABAoIBAB1+BG678rywe0Dl
+kZ+LnBhjjG+U/Gd9D4Kk1nshQOXM3CJHpM8PBTsL8aT4+lUykQWJaKLU5opCd4n
3242tcuRlpRJVigF5FHYmhTfXzjnxdZDOWaeqFumk7jO1hRUyqYTEMh/wtmZ7HoU
DlWxkubGcSThXH3PVFAyFv6RD0Y50A4em/2ObFeyOavBlmXNwxdXkeWJCtWDlDdU
ebM6ZKufJwKQ6EJitFPRyKo7XQWTGNJ9TYtX0Hp4w0wFG6OOF6bsZJ3Jh73fJhqE
mlLrvC1v5wsJUCojXrzBjGl2uMNL01m+AXwKLY23XSP828cZvAfQAR7x4w9XlYzZ
z87zNwECgYEA+eBhZS9RDJEIxxlc8ubzFiIaHMtYNK4y3XLtj2nTxYRTRkUuZWCZ
AfqfdwXzOUGDR5/ViEfAUOwKpoqJT5dW1CU7iAQFcI1l8zXt9l/EAvc3IsN36pBV
rGRdfYDZdxPweRU4skehUcj5WBewl7hWzIRqxEPbaDoBpxCbKeXNqe0CgYEAshuL
gKLwJkbPqn/383g9WrUTHKxz39G00mTiTWe73uqcaoo13QBmJWxUwLYvGyFeEeWg
rU1BSYJpC/yi+rd/C/cCIVcX3U+3/NDLPj4NqllW8kbCx76bVUAL/o4W4M1CXnI7
FLcUbF+bKOwMhMK1JI3OY0Kf0/Zos6jBgXE9pmECgYBWNc8EjQ2mi0d/AcYq2/mU
clGWC6Y0DsHn22YQ688vv1bH0MiQG4LOxvxLoVboMy0rAf83FKJKiRWnnfZ/6lP/
v5TJebGywmYhQkMGlMXYzBhOuyfdWszkPIBw84qT5eI6tFKqV8JVqEQ2232G6wev
aiQ38L17OUAmtrkB/JI3hQKBgH4YHjWeJaMTsuYk3yhR0i4r0DIWrZqh3wCtR8JB
VLLHKqIK44NpSufnwEEHOmZcwzqsdYr8DOK8Hx7LZ59U1e9kmu97t3uJetrT/3A7
gnU99t5j1naPrW03gMZhVjUlXH19JfLOgvkO3sykAWDkcFZGxv1jJ8BqzUmUihrY
TytBAoGBAI/ER2xg4RY59hEr0ST9tIwpV/4r6S6bDAiCsFmfMMfU4U7TPocfouMY
BXKAD/glJ44EL4z82axYP0LA6Abe/pfkc8dwWsEAayYjYV+8qzQ7mtHRKxmLxHTm
BtfxKI72NnSS70p1VAzKACZXwMRR5RRhOz75s1bJ3JK18AMSRc3r
-----END RSA PRIVATE KEY-----', 2);
INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                         VALUES (6666666, 12, system_get_current_year_id());

INSERT INTO Account (email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
      VALUES ('aps_avc@dlsu.edu.ph', 7777777, '1234', 'CSO', 'AVC - APS', '+63 9228474849', '-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArdjmjQSvYOuZD4w1J3oD
AZyWknSkIEebVNh5T563AtBoEfkSYfhW+MaumUBkJNt40Cl8Zp/wpy53cFwMHQ/L
vO9VMTogiysoeSLzjdNspEnWapZlcp+XPXRD9TDVwGxKHeF81eAeDpHwV7G42EFo
IV9HUW47kk0jljqmoRbWfcCD9ryjaz9DGiBoV5lhxpQSF5JhydYgt1B+Z5m602fC
acZCR7jf817RtmUxbRxHmwUMd73GJwVIgzQkG+HoyUeyRDbtbJJDlJs+NsV5f5xU
I9dE3OxApAimpcEOKCezzH0vEB498mgLbi9ZQdyyeCJZRnJHmVbyWdSdmc1TiZYQ
zQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEArdjmjQSvYOuZD4w1J3oDAZyWknSkIEebVNh5T563AtBoEfkS
YfhW+MaumUBkJNt40Cl8Zp/wpy53cFwMHQ/LvO9VMTogiysoeSLzjdNspEnWapZl
cp+XPXRD9TDVwGxKHeF81eAeDpHwV7G42EFoIV9HUW47kk0jljqmoRbWfcCD9ryj
az9DGiBoV5lhxpQSF5JhydYgt1B+Z5m602fCacZCR7jf817RtmUxbRxHmwUMd73G
JwVIgzQkG+HoyUeyRDbtbJJDlJs+NsV5f5xUI9dE3OxApAimpcEOKCezzH0vEB49
8mgLbi9ZQdyyeCJZRnJHmVbyWdSdmc1TiZYQzQIDAQABAoIBAB1+BG678rywe0Dl
+kZ+LnBhjjG+U/Gd9D4Kk1nshQOXM3CJHpM8PBTsL8aT4+lUykQWJaKLU5opCd4n
3242tcuRlpRJVigF5FHYmhTfXzjnxdZDOWaeqFumk7jO1hRUyqYTEMh/wtmZ7HoU
DlWxkubGcSThXH3PVFAyFv6RD0Y50A4em/2ObFeyOavBlmXNwxdXkeWJCtWDlDdU
ebM6ZKufJwKQ6EJitFPRyKo7XQWTGNJ9TYtX0Hp4w0wFG6OOF6bsZJ3Jh73fJhqE
mlLrvC1v5wsJUCojXrzBjGl2uMNL01m+AXwKLY23XSP828cZvAfQAR7x4w9XlYzZ
z87zNwECgYEA+eBhZS9RDJEIxxlc8ubzFiIaHMtYNK4y3XLtj2nTxYRTRkUuZWCZ
AfqfdwXzOUGDR5/ViEfAUOwKpoqJT5dW1CU7iAQFcI1l8zXt9l/EAvc3IsN36pBV
rGRdfYDZdxPweRU4skehUcj5WBewl7hWzIRqxEPbaDoBpxCbKeXNqe0CgYEAshuL
gKLwJkbPqn/383g9WrUTHKxz39G00mTiTWe73uqcaoo13QBmJWxUwLYvGyFeEeWg
rU1BSYJpC/yi+rd/C/cCIVcX3U+3/NDLPj4NqllW8kbCx76bVUAL/o4W4M1CXnI7
FLcUbF+bKOwMhMK1JI3OY0Kf0/Zos6jBgXE9pmECgYBWNc8EjQ2mi0d/AcYq2/mU
clGWC6Y0DsHn22YQ688vv1bH0MiQG4LOxvxLoVboMy0rAf83FKJKiRWnnfZ/6lP/
v5TJebGywmYhQkMGlMXYzBhOuyfdWszkPIBw84qT5eI6tFKqV8JVqEQ2232G6wev
aiQ38L17OUAmtrkB/JI3hQKBgH4YHjWeJaMTsuYk3yhR0i4r0DIWrZqh3wCtR8JB
VLLHKqIK44NpSufnwEEHOmZcwzqsdYr8DOK8Hx7LZ59U1e9kmu97t3uJetrT/3A7
gnU99t5j1naPrW03gMZhVjUlXH19JfLOgvkO3sykAWDkcFZGxv1jJ8BqzUmUihrY
TytBAoGBAI/ER2xg4RY59hEr0ST9tIwpV/4r6S6bDAiCsFmfMMfU4U7TPocfouMY
BXKAD/glJ44EL4z82axYP0LA6Abe/pfkc8dwWsEAayYjYV+8qzQ7mtHRKxmLxHTm
BtfxKI72NnSS70p1VAzKACZXwMRR5RRhOz75s1bJ3JK18AMSRc3r
-----END RSA PRIVATE KEY-----', 2);
INSERT INTO OrganizationOfficer (idNumber, role, yearID)
                      VALUES (7777777, 13, system_get_current_year_id());

INSERT INTO GOSM (termID, studentOrganization)
           VALUES (system_get_current_term_id(), 1);
UPDATE GOSM
   SET status = 2
 WHERE id%100000 = 1;


INSERT INTO GOSMActivity (gosm, goals, objectives, strategies, description, measures, targetDateStart, targetDateEnd, ActivityNature, ActivityType, isRelatedToOrganizationNature, budget)
                    VALUES ((SELECT id FROM GOSM WHERE id%100000 = 1 LIMIT 1), 'Goal Mo to', '{"Objectives", "Mo", "To"}', 'Strategies Mo to', 'Descibe kita', 'Measure mo to :)', '2017-9-6', '2017-9-6', 1, 2, false, 999.99);
INSERT INTO GOSMActivityProjectHead (idNumber, activityID)
                             VALUES (3333333, (SELECT id FROM GOSMActivity WHERE gosm%100000 = 1 LIMIT 1));

INSERT INTO ProjectProposal (facultyAdviser, preparedBy, GOSMActivity, ENP, ENMP, venue, context1, context2, context3, sourceFundOther, sourceFundParticipantFee, sourceFundOrganizational, accumulatedOperationalFunds, accumulatedDepositoryFunds, comments)
                     VALUES (4444444, 3333333, (SELECT id FROM GOSMActivity WHERE gosm%100000 = 1 LIMIT 1), 1, 1, 0, 'Context kita', 'Context parin kita', 'Context ulit kita',69.69, 69.69, 69.69, 69.69, 69.69, 'Comments ko toh');

UPDATE ProjectProposal
   SET status = 2
WHERE id = 1;

INSERT INTO ProjectProposalExpenses (projectProposal, material, quantity, unitCost)
                              VALUES(1, 'Boyfriend Material 1', 7, 60.0000);
INSERT INTO ProjectProposalExpenses (projectProposal, material, quantity, unitCost)
                              VALUES(1, 'Boyfriend Material 2', 80, 60.0000);
INSERT INTO ProjectProposalExpenses (projectProposal, material, quantity, unitCost)
                              VALUES(1, 'Boyfriend Material 3', 80, 60.0000);

DELETE FROM ProjectProposalExpenses
WHERE projectProposal = 1
AND sequence = 1;

COMMIT;
