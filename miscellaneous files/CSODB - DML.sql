ROLLBACK;

START TRANSACTION;
/* 2015 - 2016 */
INSERT INTO SchoolYear(startYear, endYear, dateStart, dateEnd)
               VALUES (2015, 2016, '2015-08-24', '2016-08-27');
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2015 AND endYear = 2016), 1, '2015-08-24', '2015-12-08');
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2015 AND endYear = 2016), 2, '2016-01-06', '2016-04-16');
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2015 AND endYear = 2016), 3, '2016-05-23', '2016-08-27');
/* 2016 - 2017 */
INSERT INTO SchoolYear(id, startYear, endYear, dateStart, dateEnd)
               VALUES (2, 2016, 2017, '2016-09-12', '2017-08-19');
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2016 AND endYear = 2017), 1, '2016-09-12', '2016-12-17');
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2016 AND endYear = 2017), 2, '2016-01-04', '2016-04-11');
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2016 AND endYear = 2017), 3, '2017-05-15', '2017-08-19');
/* 2017 - 2018 */
INSERT INTO SchoolYear(id, startYear, endYear, dateStart, dateEnd)
               VALUES (3, 2017, 2018, '2017-09-11', '2018-08-28');
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2017 AND endYear = 2018), 1, '2017-09-11', '2017-12-16');
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2017 AND endYear = 2018), 2, '2018-01-08', '2018-04-21');
INSERT INTO TERM (schoolYearID, number, dateStart, dateEnd)
          VALUES ((SELECT id FROM SchoolYear WHERE startYear = 2017 AND endYear = 2018), 3, '2018-05-24', '2018-08-28');

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
    VALUES (10, 'STRC Building');

INSERT INTO public."Building"(
            id, name)
    VALUES (11, 'University Library Building');

INSERT INTO public."Building"(
            id, name)
    VALUES (12, 'William Shaw Building');

INSERT INTO public."Building"(
            id, name)
    VALUES (13, 'Henry Sy Building');

INSERT INTO public."Building"(
            id, name)
    VALUES (14, 'Others');

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
                                  (18, 'Natividad Fajardo-Rosario Gonzalez Auditorium, 18th Flr.', 238, 2, 3000, 0, 0);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (19, 'Br. Gabriel Connon Conference Room SPS 201', 30, 0, 385, 0, 1);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (20, 'Rehersal Room, SPS 507', 0, 0, 275, 0, 1);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (21, 'Tennis Court, Roof deck', 0, 0, 330, 0, 1);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (22, 'Waldo Perfecto Seminar Room, SPS 102', 156, 1, 1595, 0, 1);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (23, 'Classroom', 45, 0, 605, 0, 2);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (24, 'Teresa Yuchengco Auditorium, 7th-9th flr.', 1104, 2, 7700, 0, 2);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (25, 'Y 407 Seminar Room', 90, 1, 880, 0, 2);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (26, 'Y 408 Seminar Room', 90, 1, 880, 0, 2);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (27, 'Y 409 Seminar Room', 90, 1, 880, 0, 2);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (28, 'Y 507 Seminar Room', 90, 1, 880, 0, 2);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (29, 'Y 508 Seminar Room', 90, 1, 880, 0, 2);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (30, 'Y 509 Seminar Room', 90, 1, 880, 0, 2);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (31, '7th Floor Gym(w/ Scoreboard)', 0, 2, 1265, 0, 3);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (32, '7th Floor Gym(w/o Scoreboard)', 0, 2, 880, 0, 3);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (33, '9th Floor Gym(w/ Scoreboard)', 0, 2, 1815, 0, 3);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (34, '9th Floor Gym(w/o Scoreboard)', 0, 2, 1430, 0, 3);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (35, 'Classroom', 45, 0, 495, 0, 3);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (36, 'E201 Multipurpose Room', 90, 1, 880, 0, 3);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (37, 'E202 Multipurpose Room', 48, 0, 605, 0, 3);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (38, 'E 802 Practice Room', 0, 0, 275, 0, 3);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (39, 'E 803 Practice Room', 0, 0, 275, 0, 3);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (40, 'E 804 Dance Room', 45, 0, 375, 0, 3);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (41, 'E 1001 Practice Room', 0, 0, 230, 0, 3);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (42, 'E 1002 Practice Room', 0, 0, 230, 0, 3);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (43, 'E 1003 Practice Room', 0, 0, 230, 0, 3);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (44, 'E 1004 Practice Room', 0, 0, 230, 0, 3);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (45, 'E 1005 Practice Room', 0, 0, 230, 0, 3);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (46, 'Swimming Pool, 1st flr.', 0, 0, 132, 3, 3);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (47, 'Classroom', 45, 0, 495, 0, 4);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (48, 'Shell Companies in Philippines Audio Visual Room, V210', 93, 1, 880, 0, 4);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (49, 'Classroom', 45, 0, 495, 0, 5);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (50, 'Intellect Seminar Room', 120, 1, 715, 0, 5);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (51, 'Ariston Estrada Seminar Room, L 216', 60, 0, 715, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (52, 'Br. Richard Duerr Board Room, L 113', 25, 0, 605, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (53, 'Br. Richard Duerr Board Room Receiving Area, L 115', 0, 0, 495, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (54, 'Classroom', 45, 0, 495, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (55, 'Conference Room A, L128A', 20, 0, 275, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (56, 'Conference Room A, L128', 20, 0, 275, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (57, 'Conference Room A, L127A', 10, 0, 220, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (58, 'Conference Room A, L127', 10, 0, 220, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (59, 'L 112 Conference Room', 12, 0, 385, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (60, 'L 218 Case Room', 40, 0, 495, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (61, 'L 219 Case Room', 40, 0, 495, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (62, 'Marelian Gaerlan Conservatory North Wing (w/ Sound System), 1st flr.', 250, 2, 2200, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (63, 'Marelian Gaerlan Conservatory North Wing (w/o Sound System) 1st flr.', 250, 2, 1925, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (64, 'Marelian Gaerlan Conservatory South Wing, 1st flr.', 250, 2, 1925, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (65, 'Medrano Hall, L213', 100, 1, 1650, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (66, 'Most Blessed Sacrament (Main) Chapel (w/ airconditioning), 2nd flr.', 580, 2, 2750, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (67, 'Most Blessed Sacrament (Main) Chapel (w/o airconditioning), 2nd flr.', 580, 2, 2090, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (68, 'Pablo Nicholas Seminar Room, L 315', 170, 1, 1650, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (69, 'Tereso Lara Seminar Room, L 230', 60, 0, 715, 0, 6);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (70, 'Classroom', 45, 0, 495, 0, 7);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (71, 'Laboratory (Room Only)', 0, 0, 660, 0, 7);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (72, 'Pearl of Great Price Chapel, 1st flr.', 108, 1, 1540, 0, 7);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (73, 'Rosario Jose Science Lecture Room, J 504', 92, 1, 605, 0, 7);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (74, 'Classroom', 45, 0, 495, 0, 8);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (75, 'E Classroom, M 306', 40, 0, 2530, 0, 8);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (76, 'Classroom', 45, 0, 495, 0, 9);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (77, 'STRC 412 Seminar Room', 42, 0, 660, 0, 10);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (78, 'Ortigas Seminar Room, 1st flr.', 30, 0, 440, 0, 11);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (79, 'William Shaw Little Theatre, 1st flr.', 270, 2, 2970, 0, 12);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (80, 'Agno House', 20, 0, 440, 0, 13);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (81, 'Amphitheater (w/ Sound System)', 300, 2, 415, 0, 13);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (82, 'Amphitheater (w/o Sound System)', 300, 2, 250, 0, 13);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (83, 'Chess Plaza', 0, 0, 495, 0, 13);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (84, 'Football Field', 0, 0, 1515, 0, 13);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (85, 'Marian Quadrangle (w/ Sound System)', 0, 0, 770, 0, 13);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (86, 'Marian Quadrangle (w/o Sound System)', 0, 0, 660, 0, 13);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (87, 'Retreat House Room 101', 45, 0, 660, 0, 13);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (88, 'Retreat House Room 201', 45, 0, 660, 0, 13);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (89, 'Sound System', 0, 0, 165, 0, 13);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (90, 'Sports Plaza (Per Court)', 0, 0, 302.50, 0, 13);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (91, 'HSH101 (The Meadow-Main Lobby)', 0, 0, 5800, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (92, '2nd Floor - Enrollment Central Lobby', 20, 0, 1500, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (93, '3rd Floor - Conference Room', 0, 0, 700, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (94, '4th Floor - Function Room Lobby', 0, 0, 1920, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (95, '4th Floor (HSH401) - Multi-Purpose Room', 20, 0, 6700, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (96, '4th Floor (HSH402) - Meeting Room A', 14, 0, 778, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (97, '4th Floor (HSH406) - Meeting Room B', 0, 0, 320, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (98, '5th Floor - Function Room Lobby', 0, 0, 1920, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (99, '5th Floor (HSH501) - Multi-Purpose Room', 0, 0, 6700, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (100, '5th Floor - Bean Bag Area', 0, 0, 1260, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (101, '6th Floor - Display Area', 0, 0, 5700, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (102, '7th Floor (HSH701) - Meeting Room', 18, 0, 550, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (103, '8th Floor (HSH801) - Meeting Room', 18, 0, 550, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (104, '13th Floor - Audio Visual Room', 45, 0, 826, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (105, '13th Floor - EDC Multi-Purpose Room', 0, 0, 1126, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (106, '14th Floor - Conference Room 1', 20, 0, 673.92, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (107, '14th Floor - Conference Room 2', 16, 0, 544.32, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (108, '14th Floor - Board Room', 30, 0, 1504.80, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (109, 'Roof Deck - Dining Area', 0, 0, 1247, 0, 14);

INSERT INTO public."ActivityVenue"(
            id, name, capacity, size, rate, "rateType", building)
    VALUES (110, 'Roof Deck - Garden', 0, 0, 1550, 0, 14);

/* Organization Data */
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (1, 'LSCS', 'La Salle Computer Society', 2, NULL);

INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (2, 'MC', 'Math Circle', 1, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (3, 'Physoc', 'Physics Society', 1, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (4, 'SV', 'Societas Vitae', 1, NULL);
INSERT INTO StudentOrganization (id, acronym, name, cluster, description)
                 VALUES (5, 'Chemsoc', 'Chemistry Society', 1, NULL);

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
                 VALUES (11, 'Moo', 'Moo Media', 2, NULL);
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
                 VALUES (18, 'Cultura', 'Cultura', 3, NULL);
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
-- ORG 1 ACCOUNTS
INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('org_president@dlsu.edu.ph', 1111111, '1234', 'Organization', 'President', '6312312412', '-----BEGIN PUBLIC KEY-----
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

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('org_vp_internal@dlsu.edu.ph', 1111112, '1234', 'Organization', 'VP - Internal', '6312312412', '-----BEGIN PUBLIC KEY-----
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

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('org_vp_documentation@dlsu.edu.ph', 1111113, '1234', 'Organization', 'VP - Documentation', '612424515','-----BEGIN PUBLIC KEY-----
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

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('org_avp_documentation@dlsu.edu.ph', 1111114, '1234', 'Organization', 'AVP - Documentation', '612424515','-----BEGIN PUBLIC KEY-----
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

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('org_vp_finance@dlsu.edu.ph', 1111115, '1234', 'Organization', 'VP - Finance','612424515', '-----BEGIN PUBLIC KEY-----
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

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('org_avp_finance@dlsu.edu.ph', 1111116, '1234', 'Organization', 'AVP - Finance', '612424515', '-----BEGIN PUBLIC KEY-----
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

-- CSO ACCOUNTS

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_chairperson@dlsu.edu.ph', 1011117, '1234', 'CSO', 'Chairperson', '6312312412', '-----BEGIN PUBLIC KEY-----
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
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_executivechairperson_external@dlsu.edu.ph', 1011118, '1234', 'CSO', 'Executive Chairperson External', '6312312412', '-----BEGIN PUBLIC KEY-----
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

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_vp_aps@dlsu.edu.ph', 1011119, '1234', 'CSO', 'VP - APS', '612424515', '-----BEGIN PUBLIC KEY-----
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


INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_avc_aps@dlsu.edu.ph', 1011120, '1234', 'CSO', 'AVC - APS', '612424515', '-----BEGIN PUBLIC KEY-----
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

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_a_aps@dlsu.edu.ph', 1011121, '1234', 'CSO', 'A - APS', '612424515', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCOYiBI+1aZziS3gGvHXF03c87V
8tL14124sGiEhUHRLVQ5Uo7Pc2WZYLE91Z9nkJGWu28+Ki/f45CTuKrT55pkIk0G
AudrXsAenJm/vCUVEuxYUpUt3GtSBxs7iuWN59956VGsaxj8SLA7Wie+z3h6RSGR
BwbGbO5pizm1z5TQZwIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQCOYiBI+1aZziS3gGvHXF03c87V8tL14124sGiEhUHRLVQ5Uo7P
c2WZYLE91Z9nkJGWu28+Ki/f45CTuKrT55pkIk0GAudrXsAenJm/vCUVEuxYUpUt
3GtSBxs7iuWN59956VGsaxj8SLA7Wie+z3h6RSGRBwbGbO5pizm1z5TQZwIDAQAB
AoGBAIYd4BNezIAsMWG4Uc2ELzogl9/nztdWx91ELe9GJm0GqaMlJOg75qPG9K0u
H+zJvJmjDHIeAuJ91J2RATiBnGb1uFTPFfCa2/I1x9V/jcdCnl6de6V7bnJGj4yt
+FwY0O3YSEARUNuOrq5U5Naj6OiszcA/cUEhkOu0WpYvPsPhAkEAygdM6rAM7uNR
lz05H+gygcyUHpplyBZv7t0SoroJZl+kQCGSVhPYusplkM1W2kdqzkSfgixhyYDR
9FMA7fJQ/QJBALRrstwoLPw+N3222XxTao1ik7voUtcn7E8CHXA8VD86Cd/WC4tv
z8VkMm5sDrZPHXlTGB0oBZQTalliTv3HxjMCQCSxZL/vT7oHoWcFoJ1x79JxVKmm
QzwvDw9kKaFShqiIUG2xa0GlAyUR45aEJPUqKXTjM9FRvET716Y3eSC+dQUCQCbZ
igoeHJG0U/6eAPbkf20ybN1piW0LC7d3nR8t3nY+6SFp1dKQoQzAJpvgaMqY/p/B
ZM/iblEUXTIiGSBMhEECQQCeCCAz+Q0yE9fdUGLyYASC2/N61l5rEXaeuj6eHFhj
Ci6j/bJJW7xSO9MXjAimu4jXUl2JRggT2/gZ2eSaXoID
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO Account( email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
VALUES('cso_vc_finance@dlsu.edu.ph', 1011122, '1234', 'CSO', 'VC - Finance', '612424515', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQChUp/jlMxfxNpHoOrGA5DaT+2y
fWLbXwM+PApszBLX74I8oRneK7G5h2Os9HGu/loM8YiPuamhegcu44V5eR/bg1T+
N0HVnjGXoiFrQ3H4ATKr7hiOKyGkPL8pVB1Ytl+ABVMBsssvI2Srd9Lwi4rmHxkG
1qclxQml4ztiHAcgEQIDAQAB
-----END PUBLIC KEY-----','-----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----', 1 );


INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_avc_finance@dlsu.edu.ph', 1011123, '1234', 'CSO', 'AVC - Finance', '63512316', '-----BEGIN PUBLIC KEY-----
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

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_a_finance@dlsu.edu.ph', 1011124, '1234', 'CSO', 'A - Finance', '6321515512', '-----BEGIN PUBLIC KEY-----
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


INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_vc_pnp@dlsu.edu.ph', 1011125, '1234', 'CSO', 'VC - PNP', '6321515512', '-----BEGIN PUBLIC KEY-----
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
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_avc_pnp@dlsu.edu.ph', 1011126, '1234', 'CSO', 'AVC - PNP', '6321515512', '-----BEGIN PUBLIC KEY-----
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
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_a_pnp@dlsu.edu.ph', 1011127, '1234', 'CSO', 'A - PNP', '6321515512', '-----BEGIN PUBLIC KEY-----
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
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_vc_orgres@dlsu.edu.ph', 1011128, '1234', 'CSO', 'VC - ORGRES', '6321515512', '-----BEGIN PUBLIC KEY-----
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
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_avc_orgres@dlsu.edu.ph', 1011129, '1234', 'CSO', 'AVC - ORGRES', '6321515512', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCWV0IKxCMIRG3uw+obl+BbX3Zc
ahot+jWM+/wONxsfEhEUl/Pxd4d/kCPc2uxsgOCsLr2W12TBMJOG0p7bySjbgCaT
uFMSrD18GVir4/NMwD50f/pDa83CLhN9wUfljKZ6433Fq5S8ZwaKq0vxFBmQphRY
9TSVIY79gL6owf+2KQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQCWV0IKxCMIRG3uw+obl+BbX3Zcahot+jWM+/wONxsfEhEUl/Px
d4d/kCPc2uxsgOCsLr2W12TBMJOG0p7bySjbgCaTuFMSrD18GVir4/NMwD50f/pD
a83CLhN9wUfljKZ6433Fq5S8ZwaKq0vxFBmQphRY9TSVIY79gL6owf+2KQIDAQAB
AoGAMgJEjaBApvdcOhghP5x9nOdcT9Fbc//O4F7RsUjTVLqFw/vnwWKpR92CkGyi
SFV2ZtAFcK+lbD3kVOyquyFm3VeAgi7o7r0z5cML5EbC7/4FU++qa13+/Yxe+wH3
x11xItwhhbEuzwxC3cqPLDZKsqZ7wRVBeeWf7a1ZlMARzKECQQDyrwkJ26bdEqWA
rNPKzEGeq8R1NsHXyogwalcQXKuI6hlZDa0G8x+hs5qZCRR8xEbBdpxY0KqcWAx4
zzWsCAnbAkEAnpcWYm2tr8I+IthJvZC/BkQ4fES9ImfMyY/jIi8KCpaEhTgtd5Qs
8LQ9myy0gaUJbtPythnlvV9MkLpYku5pSwJBAIpQiG496lSFlB5KYktrLtsoOsgz
dTdwDz7I3OZOatWV1uyShtM3LggTPUGLk0mo9Eq/N0zHYPXKmREhyA1MZ5ECQFMU
ucBUzwHdk6mzf2YU104UHTdU13SXxlvtykLVO8ByO/iChqc3dBehhQiu8d1dNUTf
Oi6WAJolu7myNca7qWMCQC5RzyUic9LsCJ0WEbJdCiGNFf68NCKvgU3Ecd0oOVdw
DHlzzr/32erXIjn8nravd8WMOOzjDUkrgI/hHAqR/5s=
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_a_orgres@dlsu.edu.ph', 1011130, '1234', 'CSO', 'A - ORGRES', '6321515512', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCWV0IKxCMIRG3uw+obl+BbX3Zc
ahot+jWM+/wONxsfEhEUl/Pxd4d/kCPc2uxsgOCsLr2W12TBMJOG0p7bySjbgCaT
uFMSrD18GVir4/NMwD50f/pDa83CLhN9wUfljKZ6433Fq5S8ZwaKq0vxFBmQphRY
9TSVIY79gL6owf+2KQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQCWV0IKxCMIRG3uw+obl+BbX3Zcahot+jWM+/wONxsfEhEUl/Px
d4d/kCPc2uxsgOCsLr2W12TBMJOG0p7bySjbgCaTuFMSrD18GVir4/NMwD50f/pD
a83CLhN9wUfljKZ6433Fq5S8ZwaKq0vxFBmQphRY9TSVIY79gL6owf+2KQIDAQAB
AoGAMgJEjaBApvdcOhghP5x9nOdcT9Fbc//O4F7RsUjTVLqFw/vnwWKpR92CkGyi
SFV2ZtAFcK+lbD3kVOyquyFm3VeAgi7o7r0z5cML5EbC7/4FU++qa13+/Yxe+wH3
x11xItwhhbEuzwxC3cqPLDZKsqZ7wRVBeeWf7a1ZlMARzKECQQDyrwkJ26bdEqWA
rNPKzEGeq8R1NsHXyogwalcQXKuI6hlZDa0G8x+hs5qZCRR8xEbBdpxY0KqcWAx4
zzWsCAnbAkEAnpcWYm2tr8I+IthJvZC/BkQ4fES9ImfMyY/jIi8KCpaEhTgtd5Qs
8LQ9myy0gaUJbtPythnlvV9MkLpYku5pSwJBAIpQiG496lSFlB5KYktrLtsoOsgz
dTdwDz7I3OZOatWV1uyShtM3LggTPUGLk0mo9Eq/N0zHYPXKmREhyA1MZ5ECQFMU
ucBUzwHdk6mzf2YU104UHTdU13SXxlvtykLVO8ByO/iChqc3dBehhQiu8d1dNUTf
Oi6WAJolu7myNca7qWMCQC5RzyUic9LsCJ0WEbJdCiGNFf68NCKvgU3Ecd0oOVdw
DHlzzr/32erXIjn8nravd8WMOOzjDUkrgI/hHAqR/5s=
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_vc_amt@dlsu.edu.ph', 1011131, '1234', 'CSO', 'VC - AMT', '6321515512', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCeFN2GSH42bd7cFgBAL/8+wuqG
PfKvgGPA8YKQssFMN6LIx5finI1lGDElLkIHCRCf0VojsLsHoe5Q/mrc/VOSwnQJ
SZMbc5zMj9ZlvoYOcId+51zBstyu7ihaVTxWuvzbZWhEFIfj2xQWRwPHMPrFxmMj
srNfbf895LdAN/bTxwIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQCeFN2GSH42bd7cFgBAL/8+wuqGPfKvgGPA8YKQssFMN6LIx5fi
nI1lGDElLkIHCRCf0VojsLsHoe5Q/mrc/VOSwnQJSZMbc5zMj9ZlvoYOcId+51zB
styu7ihaVTxWuvzbZWhEFIfj2xQWRwPHMPrFxmMjsrNfbf895LdAN/bTxwIDAQAB
AoGAJU7RVT7Iorndbd23Y26wc7R2uwXlv6uyXzfgU5wMaJt8zJvmabH+4MwL1TWM
mbJ2/PDgsCmmik+aOf1BZTRYQ5xruDd3M8v0OTiUbbkZgao2VwrUC6zR+zCK6nC/
wLnONvehp0sG3IWJS4NU0/1Y1z16XvewO0wbfuMCWAB7qKkCQQDZHGh0UJxX5TFI
rmWEs2tjEv7Z7miAwC+DRDXJ3ChE2WbhumOKMDymzJHJyG/U4KDFZmmfG85WXzJc
L04FFPzzAkEAumWrePZfV/a/Q43JamF2aw2QIzpNdopVGoQYbzO7s5x7hKU9EV2r
M/wGo4apRQQJ66iwLYZWR5gu6Ws+7wsy3QJBAMyubIdjy9FNgMYNrCWL5Oy1ZtBc
Y+clyGVPdApHZStrbgPW7arEyRlTeQorzcp6rvcLEv5uf3uMKfUgn8RIwiMCQAcE
Or8z7wTdqfd+B930S0PeX9WjpTTYIjn8TPsqpF8vfcrReYoEz6QGUa2oLQkHDOSN
FgywqODLDsEEo3rWHhUCQQCHhoumTELnKoueQ7SCG5G7d/cnsYLgzHX96MLCvOlP
lWBVZ/QbUBAe0on6mvpzehnD3sS2wOQl4sET1k8eeCth
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_avc_amt@dlsu.edu.ph', 1011132, '1234', 'CSO', 'AVC - AMT', '6321515512', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC0I5u8qRuNtDooiaKMQEw3gfnS
V+U8bCmPpErGMnXRj/Q4sC6Fgl/DRCP9holoP3jKPA0Th/D/LEd9J+IasUGz5I9n
r+/rs5iQ6hqV6QGsGtKwlpLW2k7XINiyEblseTficgYfMQE8O69zvdC9w1D2ggcL
60eyZH+KAqdDUYtl8wIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQC0I5u8qRuNtDooiaKMQEw3gfnSV+U8bCmPpErGMnXRj/Q4sC6F
gl/DRCP9holoP3jKPA0Th/D/LEd9J+IasUGz5I9nr+/rs5iQ6hqV6QGsGtKwlpLW
2k7XINiyEblseTficgYfMQE8O69zvdC9w1D2ggcL60eyZH+KAqdDUYtl8wIDAQAB
AoGAE+US4CU1G9NZ0PxSbXb0c/Tw6GA4uxGfDXQxpe4QwRJLAK/Ek44wkVpHN0rS
hibsajlzoEKVRTlYs+PhvtzwyoPrd66I6izjSL8bMWwTKXJQBEtorsh+2gvQd739
zpESr4UunEIFBPHtgcE1vrCj/hDTaUaHBhOSc4UcQxfUWEECQQDgFsfgTOGOw9it
b5xi7w2a+kWZZSBnwLCuSpRB7iujmaZZQd61Bhl8cpNOVO14eCAHT+pGSi9/BzDj
NeEc0DLjAkEAzcqfmUoGwWSK4Vj4jy1f/FzjZ6zSWOPvmiZuOWvhBj3MVfM92D+l
gfaA/CDHFTQioo8pNzHV/f9ZEU2VRoGdsQJBAKEEXXyzYYPHAAOnZhTEtt78JFST
kJRcpdem6R7yt1KnzhrmtNMYXenJHkWzyqq8ji8S4kC9f6FkFmG8zlN42ocCQQCS
CfTwp2Pb4inceXMKyDyRrqmCbVZo1ni2gAdAoJnz/+7+H7wHtkMR04j9Y5VkKrdZ
fRbWoHsn4QmoCdKhUmJBAkBF1iXf5/sMH5zon9QMbc7R7VxJe68Xvnnd4uG+UYD1
fZV6DOdrAH9JYVrQaX6bDDEWIIiJI9+P7n37tsbDdHEc
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_a_amt@dlsu.edu.ph', 1011133, '1234', 'CSO', 'A - AMT', '6321515512', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCKP1hDH1Pt9lTkpQ8sikyOk+FK
wQQuq5ajaMBotZwzh3Of1WJ0S4btMB0eVeppP0HM0IgIFivIBQJeHGvcMe8OtUUW
OpjTkGUr3b1UyVqbaGTdFUPFoBVL+Zw/1HDU4Gnc/1DsAUvSXeLlRi0ErL8DGQYP
DDyxxIDgdyXUsRAzzQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQCKP1hDH1Pt9lTkpQ8sikyOk+FKwQQuq5ajaMBotZwzh3Of1WJ0
S4btMB0eVeppP0HM0IgIFivIBQJeHGvcMe8OtUUWOpjTkGUr3b1UyVqbaGTdFUPF
oBVL+Zw/1HDU4Gnc/1DsAUvSXeLlRi0ErL8DGQYPDDyxxIDgdyXUsRAzzQIDAQAB
AoGAa+2gHmbqwzA4fnhOLFucAQN6Mz4U4cqbw98Xt6dw1tm8bt/MCTadk7aoRPKW
GqyD1j5GtOl6LKGcg5R0sGdbVV38uIhm3coyGZCjIoWqxDbThv+Pql4wiuzo/j8O
dv/1ki3Fll07CbCA+OB+P56zrViHq86YJAOjQLHAPOU7wAECQQDHSco3nAfMpWHB
gCiX3kzI8cUkZmoPVUk0eqkAPAO42M7+uU0a6lT6+J7TSJ16/gypLo0yH+YPSHLM
PCnbWxwBAkEAsZa2rlnZtYosSSCERW7jZkVKzRsxBrfraAaxyaKk2e3eiD+yvWKO
UhHqiW6zJJun+w373dC6rVGLXQ2ozlbHzQJBAK9cGvh779D/5dkjMJUSI3beZ570
D3eWkGgBVxzBsnTBMsOpwlNgx45fn0JDr28+hV2JfO0SbJoeIgXdGufOcAECQAV6
puw+LW9icfdXn30c7LstDB/D5QFWD1dITZfxArEOm70MahFZxxZVIy1WUwSgINCo
H8s6M2hBidE3KKwlFUkCQQCQYChZko5REYv7dIJVPzISLXpCsR794R74t4FbHO3e
y0p8vzRsm8IYup9GlvdF0t2NUQuBLNCHK3ajS58iQwsR
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_vc_adm@dlsu.edu.ph', 1011134, '1234', 'CSO', 'VC - ADM', '6321515512', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDQVV5SkDUwS273nVMNCihKHiRi
F4MqBU832myNeqTZaJjs+iJ72WyJuQlnIkRvwo2Y/sVTzvaGb5nkCi/5mNcxfcEj
hQ+f5O9YGfdnLzkRu2BRN43cxV96lE04/uDd4SjlSQ7FcSb9H1Yv3wCovlK0B6k+
5NgLWK7H9ZUo7gLY/wIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDQVV5SkDUwS273nVMNCihKHiRiF4MqBU832myNeqTZaJjs+iJ7
2WyJuQlnIkRvwo2Y/sVTzvaGb5nkCi/5mNcxfcEjhQ+f5O9YGfdnLzkRu2BRN43c
xV96lE04/uDd4SjlSQ7FcSb9H1Yv3wCovlK0B6k+5NgLWK7H9ZUo7gLY/wIDAQAB
AoGAG7dv0A4tdVpjzf+ZP//c8ldmQcKdCachLe4aSQxLCD2ZMtXoZo+7l+sNLDJr
5m58xiEHAapkM+h/Ec6lKVDDOC3cnKAMT8PZBc5i3HNvmjgpyaCeZHasF5ddXwsW
GPOGXgF6MrH7EVJXfwyn/wj3DONyo9lqQg6ecINnACBKUkkCQQDyVH1y1Y8VdjLd
zo+JZVu3H53HdAdf34DYWsdXLtv5ZSL3iB4PJKvWh2zwy9bwHdmWbDL8+ThAi55V
1w5oew/7AkEA3BXuT0VB/FfjsFn36C6BfxH+U4groNoTw5yFbllOZvot1/b8DiGU
CigCBe3GTAvAgHYdqunZu8grIEVL1v6XzQJAQsOUbHb6HOebzBCE603JnwJO7gzB
m2BwlysrkJGQeX2rzJbr8TAhR9G36f+/EBipQhA9XAUtwlq1HOFLTu3Y0QJAeM3c
6kwkxSNlClbH+f0U/a/dvvIeqIMrmBKhNwn0PBgU89dRUVxjCxQc0C5My08kEh9D
d5428pkT+vmugEts/QJBAOTqk8M+wkezaz52+QIxcEldEiDk/ec2GX4mE33Q6a+V
Dilv+3Til5GB6nbRXf+pwJcw5DWFE9lD18v0FWmsEzw=
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_avc_adm@dlsu.edu.ph', 1011135, '1234', 'CSO', 'AVC - ADM', '6321515512', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC3D/ALZ28hZ6hBQJsE0JFmrIwY
PSITb2K6OhTB0BMJlETA0EDRlJHiYIxnM37f4PzF/txRnFEAdstyTitpzTDrQNxH
iYZyulryhi+Mi6uEAmod0M9fEYbSKA7lfoCR+qD3zlu5rfIfTyoOOONm+M02JOmf
jgW+f4Bydm0KABo69wIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXgIBAAKBgQC3D/ALZ28hZ6hBQJsE0JFmrIwYPSITb2K6OhTB0BMJlETA0EDR
lJHiYIxnM37f4PzF/txRnFEAdstyTitpzTDrQNxHiYZyulryhi+Mi6uEAmod0M9f
EYbSKA7lfoCR+qD3zlu5rfIfTyoOOONm+M02JOmfjgW+f4Bydm0KABo69wIDAQAB
AoGBAJN8urhlaEqwmgWgiISziUIAqIpqzoZ8Cj3hx5FzE7N3CoGSB3cTTQnnIZeQ
DJtRSDY5JMZ3u2c1TqpUQnPmho7VGEb5xZpDmJsFVHXB+8A8ghHdKKFiEvkLauGN
tFq/qlcfqkJZnpB5ZEmQNQj6hsM09+voxQQbHaVZSFkbpPRRAkEA7RfA+t0t1j+x
m5QcB0/cl4IHxOyh+YnA1NGc2uHw0A3mlaE7kqGaqwNaf5Gz7YIjlrP3bMzNtvAE
THIgxcxMmQJBAMWpJrgGX2QyYJ7R0tIl5Nhx4WgEbq6coe+wDNnLyQjYAfG8iKDY
MzA8qR93j0FiGAzPahiY9W/xDTw54Uz4bg8CQQDP9LTMlPGeaXGUH33SIAdBUMkV
veR4Zo4fXNey2NiK9JZaifghreNmumNHX3otCafDiIiuApkxKybqEnSSaZaJAkEA
g+7DyVF3momFtHyZG2vvtAlPSv6qYiJqdHIuIbHEHgMQSSpuh+3HPQtAV6CWHi47
n1FSn9h4+p8LFogLujSYQQJANX9bzf6g9Q7uE0gvXCxLsQ9r7CRUp/CqlLuZEaV2
Detc/IIv1R8oXhRhEVN+miuyRzRh4IFPMvFMAcnXzRfASg==
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('cso_a_adm@dlsu.edu.ph', 1011136, '1234', 'CSO', 'A - ADM', '6321515512', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCcUZceVzoQ14sv6oquaBGE2lvZ
xfVd2FfTFh4izfDBffzi81DikrcsWjzVa6WyvD47Gxnsx9X0CZoXoZyoejrdrdoV
lCSpj4qmuWNs/sXYBQN6h+5wEvVLzcwoIVYupeKUnpmp1O0q+glZ0ZLkT2JVu8p3
v9AYT5zjEv2/kSOiVwIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXQIBAAKBgQCcUZceVzoQ14sv6oquaBGE2lvZxfVd2FfTFh4izfDBffzi81Di
krcsWjzVa6WyvD47Gxnsx9X0CZoXoZyoejrdrdoVlCSpj4qmuWNs/sXYBQN6h+5w
EvVLzcwoIVYupeKUnpmp1O0q+glZ0ZLkT2JVu8p3v9AYT5zjEv2/kSOiVwIDAQAB
AoGBAIpNCZW3eNEz0pqHOUGLI4zWIJOxOCBaa4F/vRPv/sVCcX5d5b9ALT3ZbJ8q
SYS0VZ63oJ1ERMBPynyD6PWKhw7+RWQrFHjcLHywBPOFeP5QfBjjqaMeUCjEDtFP
Gq0LE+BV4NpY/j6FnJphk7NQwaFQ5qOk+uHHRtAPJ6WHHCSZAkEAzdhwUnMPY499
334merHW96uRHsbIkhJ09TrIK99fsIp4JaIXDJxdZQrKk9nLwo2GebJjB34gEj8U
yFfaECKGSwJBAMJn7q1saMS++UWd0t6jXOkKbgO5iwI6sLdgiJUYlv5q5CQ6PFua
0Lekt4qN1Bnbtca//j10b1ckvUWF/pZMvKUCQD3mpIBm0W3jLLsUuIWVDUwVb+KN
bKtgmYNVVfS7i48PVOocQEoui3djM2Aa0seCv7nBBz6tkv9psNo+cPkBKNkCQQC8
qoTVxWn/1p6v0zS8YKpgd4DBGKYxaafqr0Kd/5k6G56BEgtVk2+Pacm+K1p2JeXJ
lrY0CfWsCrms6Rdj4eEJAkBYKrpRZUvpujanQsoMdgDb7SS3xaW0vzIclIqg9FFn
f0tk8MiOLy0hDX1xpmjutW2Ro4HZ1yjWZD5EOBGVJtVY
-----END RSA PRIVATE KEY-----', 1);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('facult_adviser1@dlsu.edu.ph', 2011111, '1234', 'Renato Jose', 'Molano', '6321515512', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCyws+X1ZRyQBJ5vh25G2ost83G
DrqAeWfyUx05Uoc9e9gYBOeO6gsADS3eBhNgmxyWTKLmrb6JefDgPWm/G8n4RzbN
C9SnMnHgKqOUVYejStbTYrjhFCpFODd4U0dwlTiqRl2wtXagO6eX2TPSx0DT2kFu
Wx+m9ERVhAXPzXKZrQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICWwIBAAKBgQCyws+X1ZRyQBJ5vh25G2ost83GDrqAeWfyUx05Uoc9e9gYBOeO
6gsADS3eBhNgmxyWTKLmrb6JefDgPWm/G8n4RzbNC9SnMnHgKqOUVYejStbTYrjh
FCpFODd4U0dwlTiqRl2wtXagO6eX2TPSx0DT2kFuWx+m9ERVhAXPzXKZrQIDAQAB
AoGAWVitUYJas8/6bAbt7DsbkkY7/yYVaWlE3wVTsfbhyYVAuKCa6/9miBwONM5s
mPhuDWE4enuUpDnifvGzDOXix/NXtbTRn6yp/zkS+jDov07fFIdDZ5heB1CGbz/l
e/rG/T3634yeOnQpCTioCjp5EXMKpKdbR5AbHdkIP6pXZQECQQDWpWpMztIDc4Ih
S9wEIiJ0b0XVNpPutam8Z1SK+KEUUx1wXZSuK2skVzeNM2Lf32ufpzRaNx7gSQx2
raptBVdxAkEA1TN/2LGUTFXGdP1pUje0G/lMarcsYtcdWuGN3ZdWjQjAGN4lyTnV
UY7bZCgt3CnDKuiR9SeQJfeczOXpRZyf/QJAEMg2G3NAMEzjq77GoPwaPYhFqXnu
7wb9EmHx1jvCPFiTQKnQah2y7tBy43NVE7PgMkdcbIFKxLZxZwYFASkdwQJAeXm/
ZVtA8QGKcwwUX2knsSypUsCNhL+mlSqg51ocUX1j3odspivSlIa+EGIoRyJwdllP
GIzzP/7Gk6SH9kbYjQJAUfvdqQXeZNi9yUSpz+lVxcjJYrhqJ220bwn3n1TEtrrZ
fPMR4Ls4cC0Kd1HZ2d3FpC6rSDUCnnJkuS9m+rA0SQ==
-----END RSA PRIVATE KEY-----', 2);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('facult_adviser2@dlsu.edu.ph', 2011112, '1234', 'Edward', 'Tighe', '6321515512', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCB6bnoSAXYGu5+/Sfd+qtMgKDN
bmt2Yusudo62x4tkPPdfWMHhDmJbagK5mMbjo0BegN/+ASrgDBZQWdNVlOYsCTXv
5dvu8v/ZNvE62J1Qzi62cu4qjNz3Iit4HGSQijWh4tX93avSwBiVOKrEIvPIgMM8
LNkU/Rti624DHqMlxwIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICWwIBAAKBgQCB6bnoSAXYGu5+/Sfd+qtMgKDNbmt2Yusudo62x4tkPPdfWMHh
DmJbagK5mMbjo0BegN/+ASrgDBZQWdNVlOYsCTXv5dvu8v/ZNvE62J1Qzi62cu4q
jNz3Iit4HGSQijWh4tX93avSwBiVOKrEIvPIgMM8LNkU/Rti624DHqMlxwIDAQAB
AoGAbBwes2hMRLyUwGTXqmiR6MYaCxranthOsonC1eRU4YPCsDvii/E2dLBRuDWl
PYZ7aKmCvZQnI++rGg7GSa/xonrEQgsg4cY+odlOPbmpDca2ztLglNefaYQ2/C0P
Y6coV7/5w7XsIfcVhpE9x1fZ313xCpI/cN0PlHAV9un2cWECQQDcYXoiCfiuzonC
UH+ssa7MeIY1iNpLGB/yKsTumtFCUClMrOgEhImV643BZTh6yrwSbz6F/SDoTi6q
fF/eXd0PAkEAlukI27LiNVuVeKBvbheqO0tr5HA217/lrMQnuuQYh45bIpQNmQQG
csGrkrOd0wUf4jhs5v9jQqjdn43DlWAbyQJAb8ahA5K7Jy5qgLwDhbu5RMv8hjqb
PWtHCLTYnYy4hkHSMKmiJGh0wC1xAJ4uP1mEenUh6SOyBSFiWeYrWcWR0QJAIQU0
jv4BSTOU7SQNvcUn1nmWThHPrj2q/7acCuTGCUM45cQHhae/0XRXGm565iWE6Hb4
PUM8cOWKONNILHMvIQJAcw7yJAltG83X4LHhpti+xNvPvIOPdQTMOclzs7e7IPkm
ki2mak5s9yvwAVeIjjxln96iCNyfV/axEPrrZUd2nA==
-----END RSA PRIVATE KEY-----', 2);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('slife@dlsu.edu.ph', 3011111, '1234', 'John', 'Lingatong', '6321515512', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCcEc2MftJ4+6v7RMlBUOm16V+W
JDVWYPg+4V1uhrNQRhpR0tbxeYhX8onxtDlY3USFCNxx8KUJERIUz5UUkbIwVMH+
5a6L0Baj7Bxj77qyK8/sAM43NvYx2tHp2S6ukBRalQjQcaSaRBXlWBBAmThggHHH
+srh+1Vq+ifzSoXLmwIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQCcEc2MftJ4+6v7RMlBUOm16V+WJDVWYPg+4V1uhrNQRhpR0tbx
eYhX8onxtDlY3USFCNxx8KUJERIUz5UUkbIwVMH+5a6L0Baj7Bxj77qyK8/sAM43
NvYx2tHp2S6ukBRalQjQcaSaRBXlWBBAmThggHHH+srh+1Vq+ifzSoXLmwIDAQAB
AoGBAJdGmlpoQ1KJf3YagokRCLgO8Vvy1NBZRcaNY6bSYdSZXsGZAEcnagT1Tsg9
zKhaMSRSJns6qn1TUpdhbjt1zaSMT7sYWi+hjMi+QG9hvKdqAtrBwNKvO9WP/QSF
lTo4/1NpumEE6hx/5CmdXEE0HYoNSLZvjEtA4TVmdbqFY+GBAkEA5GvfeniBnUAR
RdhEx3d+Al8fZSq8VhWUW760n2bK8pAXsXAbkQGUru8BODWqg93oUBNJzvqTstoL
RZ8EYLq88QJBAK7pp4TJx1m3ueviFw5sFEQYAf6dzdTG/1xoKF4fxorLkvPKLv0P
Rv00AbLDVL984HDm6qgvDBcSldpvr4BLgUsCQBQGBMwmni4bvKfjwnu91NT+Y7Ep
ouLk92FngUvr5eSHjxwl2LTIb7E6EGBODAmNPV0vo6u6OZJXHN/Yhbi5BfECQBjY
TZg6BRwEUd9knPvKdFJ7yoS9K4iGv60DioBcKRp78iK43FXLvrymj3sx7a7JcSP4
WOqMzD3WwPxnEtm5X+MCQHo3kgMtH6ChR7vLV4LQTwwf+way+YH7d5j6UvZaa7ZB
dMSXDysYqzDUu8CJwiQkK6cFM8GjypKQINfo0OIzaGo=
-----END RSA PRIVATE KEY-----', 3);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('dean_studentaffairs@dlsu.edu.ph', 3011112, '1234', 'Nelca', 'Balisado-Villarin', '6321515512', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDVRQwWfmVLHfOOH5YeFwVfGKBs
3xG0YG3ybsxNLV7RD1CwJUYzv9laMdXSpk6A0DV756qrX+3BPWnDy1HI4w1tfyBa
NktuUby6Q/f/3QTVdH4kjiIwYVNUn7KzvXyyE9u+5OaqJFAHctvlBgd0/gMqOFNF
B+7Mb7k7R7UIsHG6wQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXgIBAAKBgQDVRQwWfmVLHfOOH5YeFwVfGKBs3xG0YG3ybsxNLV7RD1CwJUYz
v9laMdXSpk6A0DV756qrX+3BPWnDy1HI4w1tfyBaNktuUby6Q/f/3QTVdH4kjiIw
YVNUn7KzvXyyE9u+5OaqJFAHctvlBgd0/gMqOFNFB+7Mb7k7R7UIsHG6wQIDAQAB
AoGBANGlAT/vWdVgiPWxuRi1GpOjmrfLBBVjIVFKd0x6iBVMT84Hph3ivl96U62x
y8O2aIz3a37xWr81ho1whWHLSHsKNJ2W+WQhZslVgRtDccMpxlt8TAJ9OW5wLzOD
S8olb+H1w7eWYGSRwM4McTSJ3qNcK4XL0yQIHhg6lvf7oMABAkEA6oFQlGc0ikS3
9fGFGUwd6h//LklZtXzMstAcXMecCqsq7hFeNmETYrCwKbKp5HMcH2cqn1e6rxJs
T2NUX+evAQJBAOjRcPmZkhmqdOXyi1MrWlSVzBDpJ9NvxX/5cgrjrSb3AD3wxQVN
k4E4Vyk1yEtKEpu56Tln/jl+DnKdM/wBy8ECQQChXr8+gA6Nn2Af5EU89T4YoFAP
X/ZVhz2tRrxdtBZS2Rq/nEACl6apYQC4kPOL+xI9IdcYs1wJoVna/3VOUbYBAkEA
4d6XqT/JEydhA9l8O7L6jsdJVDqvDZ0JUa/SaSgbS4ska/NTYWKysRHU1cE80XZK
eVQzJSNz65kVMTK8RUgEwQJAExbSR7jDWM8maHfKj4ac1BNDFWiuWdtClZzTT1NU
I/oKw8JLTN8ar+eMMN+Ho6AuPk5NGo1TCRHc19ShObpKQA==
-----END RSA PRIVATE KEY-----', 4);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('vice_president@dlsu.edu.ph', 3011114, '1234', 'Michael', 'Broughton', '6321515512', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCb/4C/HnxA5LJnhEF2mVDIJwty
dvQs9E8xo5CTI3ZRQn13l8M50nRSyDhnj0W9IxVn4VAAinzeFFwG5iTccvCkJY6P
SDUzf06zNjEiX2wD7lo/qg9wrQZ7EbNfujJJT9ja8i3NLF2/eSPu+KETuXRD6R64
qh+BoPrbOGiDLdHcGQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICWwIBAAKBgQCb/4C/HnxA5LJnhEF2mVDIJwtydvQs9E8xo5CTI3ZRQn13l8M5
0nRSyDhnj0W9IxVn4VAAinzeFFwG5iTccvCkJY6PSDUzf06zNjEiX2wD7lo/qg9w
rQZ7EbNfujJJT9ja8i3NLF2/eSPu+KETuXRD6R64qh+BoPrbOGiDLdHcGQIDAQAB
AoGAcKjrcBsyHSOM/Fl1dZNv1bzs9XOXEEg4UV8Q8FJyBmmAdzgxE7c7rvVOVuwP
r3KA6Q69WkapuzD07T6UbGjOBH0rC8m/D2Uv3mY3T4oCATXggkEjO5R1taxqwnxA
deLSLUmd9SfER+wjz9yVui61qTVc04DzQlrgRIfDvsNKrkkCQQDMX7fx26tL5xHA
DVQPErhSOgZcdutzYD1cTO83IUTKrb3JAqJgWF4HXL9B2VivknBKwGxuZUlk2yg4
OlsFY+ATAkEAw2d0pLrc+jzIwDL8AuhaNBrQddGRony43fQG6lDiZ7ju0a3wDvxD
Viw+t0ewSJJDXtB7/pe51GlZXYkFuwMQowJAK4ow2/vakH8XzvyH7fYlAo+OD2De
ZGQabnGNfQc/apZ9GjfPdAsfbR4bOOIe/LiL58D62MIHUs9F0ETOY2WVtQJATc3w
zPK2sFDpolXqsIGyARM4M+F5Opisx3u2ETCZpbEmLokyj9T0PuipJDNARvUuLB+Z
b5scXC6CbdL0XC1xPwJATnkbd9B6j97tYvSMx+q2P5qjGzODynrPLgYCnslRpx7c
bvzBfUthH4/lLfHz+T/0YUpsAbZv1QDt7SivM+Xkng==
-----END RSA PRIVATE KEY-----', 5);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('president@dlsu.edu.ph', 3011115, '1234', 'Raymundo', 'Suplido', '6321515512', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCkKPYp18u+O2e3bvrvXLBSs+6z
QKcouWUyuvIEzWDawz2zYSkrEhoilcCedOU8BkdATjehebGGCDDB1s/VDNT3Zmj8
RMuXO+ltBxsxrABZEVhv+bTguMysDDQBPz3LrlesNpLFaXocSEeaqpxmDhZS1w4f
7kyMwenO80F+UxAahQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQCkKPYp18u+O2e3bvrvXLBSs+6zQKcouWUyuvIEzWDawz2zYSkr
EhoilcCedOU8BkdATjehebGGCDDB1s/VDNT3Zmj8RMuXO+ltBxsxrABZEVhv+bTg
uMysDDQBPz3LrlesNpLFaXocSEeaqpxmDhZS1w4f7kyMwenO80F+UxAahQIDAQAB
AoGAMHdbfi0VHTwCuhiNA6B0+mXfQpMDBzX9V8Xz8FEGmG/uRoiYE/xLNQzLirzu
dRNRc/3j1MvOCsleQ8x9HeSk91BefJ1VUM93+fQLI+9Zfm/XSPZeUendfBmbX4kB
xbc5htJvk4Oq+diU2IIxJIM2MDpwERtirD5bp7cqqtv0XuECQQDisjjHBlhw+rcE
snc5H3iuv580k2UZk9HKi+OGmMoGDhz9gNQymvYgsaZl3lTvgAsRUab0NuoVjFY0
j+23vu39AkEAuWFOmc6jHEOeqDOD0BiRMfpawdUmyNcoaKQlIBqvAWflkRM9UFjx
lPRXKs0/EJsu4JPLWFDwrkxS4ZCHDyYBKQJAKEKMkNQQqufrzvq+77cmIKrJZHX0
04kMDhOv8bx6zH5/KYpSpTYeFgpWyeqlXO95h7bflqmWAwOsX6NcDXDsJQJBAJXX
Vn4yLVuSOLMCeMACq5H3J9bXILNkXlA+pZeOmfiL715Va9D/I75fxfldz2Tv2nNC
YzHusqxgGvoiJVkUQgkCQGXabuOyLicPFhwAVhlUkXHUgGd7KNsSFASAvjeBbsJp
4F8HMpP+ChUqgW10mdON7mhsXoziRTmAnlLkYKOYlEw=
-----END RSA PRIVATE KEY-----', 6);

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type, status)
        VALUES('juliano_laguio@yahoo.com.ph', 11445955, '1234', 'Juliano', 'Laguio', '9266386421', '-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCkKPYp18u+O2e3bvrvXLBSs+6z
QKcouWUyuvIEzWDawz2zYSkrEhoilcCedOU8BkdATjehebGGCDDB1s/VDNT3Zmj8
RMuXO+ltBxsxrABZEVhv+bTguMysDDQBPz3LrlesNpLFaXocSEeaqpxmDhZS1w4f
7kyMwenO80F+UxAahQIDAQAB
-----END PUBLIC KEY-----', '-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQCkKPYp18u+O2e3bvrvXLBSs+6zQKcouWUyuvIEzWDawz2zYSkr
EhoilcCedOU8BkdATjehebGGCDDB1s/VDNT3Zmj8RMuXO+ltBxsxrABZEVhv+bTg
uMysDDQBPz3LrlesNpLFaXocSEeaqpxmDhZS1w4f7kyMwenO80F+UxAahQIDAQAB
AoGAMHdbfi0VHTwCuhiNA6B0+mXfQpMDBzX9V8Xz8FEGmG/uRoiYE/xLNQzLirzu
dRNRc/3j1MvOCsleQ8x9HeSk91BefJ1VUM93+fQLI+9Zfm/XSPZeUendfBmbX4kB
xbc5htJvk4Oq+diU2IIxJIM2MDpwERtirD5bp7cqqtv0XuECQQDisjjHBlhw+rcE
snc5H3iuv580k2UZk9HKi+OGmMoGDhz9gNQymvYgsaZl3lTvgAsRUab0NuoVjFY0
j+23vu39AkEAuWFOmc6jHEOeqDOD0BiRMfpawdUmyNcoaKQlIBqvAWflkRM9UFjx
lPRXKs0/EJsu4JPLWFDwrkxS4ZCHDyYBKQJAKEKMkNQQqufrzvq+77cmIKrJZHX0
04kMDhOv8bx6zH5/KYpSpTYeFgpWyeqlXO95h7bflqmWAwOsX6NcDXDsJQJBAJXX
Vn4yLVuSOLMCeMACq5H3J9bXILNkXlA+pZeOmfiL715Va9D/I75fxfldz2Tv2nNC
YzHusqxgGvoiJVkUQgkCQGXabuOyLicPFhwAVhlUkXHUgGd7KNsSFASAvjeBbsJp
4F8HMpP+ChUqgW10mdON7mhsXoziRTmAnlLkYKOYlEw=
-----END RSA PRIVATE KEY-----', 0, 1);


-- ORG 2 ACCOUNTS
INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('org2_president@dlsu.edu.ph', 2111111, '1234', 'Organization2', 'President', '6312312412', '-----BEGIN PUBLIC KEY-----
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

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('org2_vp_internal@dlsu.edu.ph', 2111112, '1234', 'Organization2', 'VP - Internal', '6312312412', '-----BEGIN PUBLIC KEY-----
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



INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('org2_vp_documentation@dlsu.edu.ph', 2111113, '1234', 'Organization2', 'VP - Documentation', '612424515','-----BEGIN PUBLIC KEY-----
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

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('org2_avp_documentation@dlsu.edu.ph', 2111114, '1234', 'Organization2', 'AVP - Documentation', '612424515','-----BEGIN PUBLIC KEY-----
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

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('org2_vp_finance@dlsu.edu.ph', 2111115, '1234', 'Organization2', 'VP - Finance','612424515', '-----BEGIN PUBLIC KEY-----
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

INSERT INTO Account(email, idNumber, password, firstname, lastname, contactNumber, publicKey, privateKey, type)
        VALUES('org2_avp_finance@dlsu.edu.ph', 2111116, '1234', 'Organization2', 'AVP - Finance', '612424515', '-----BEGIN PUBLIC KEY-----
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


INSERT INTO OrganizationOfficer (idNumber, role, yearID, dateAssigned)
                        /* ORG 1*/
                  VALUES (1111111, 10023, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1111112, 10026, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1111113, 10027, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1111114, 10028, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1111115, 10029, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1111116, 10030, system_get_current_year_id(), CURRENT_TIMESTAMP),

                         /* ORG 2*/
                         (2111111, 380356, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (2111112, 380359, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (2111113, 380360, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (2111114, 380361, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (2111115, 380362, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (2111116, 380363, system_get_current_year_id(), CURRENT_TIMESTAMP),

                         (1011117, 0, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1011118, 2, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1011119, 11, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1011120, 12, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1011121, 13, system_get_current_year_id(), CURRENT_TIMESTAMP),

                         (1011122, 14, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1011123, 15, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1011124, 16, system_get_current_year_id(), CURRENT_TIMESTAMP),

                         (1011125, 17, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1011126, 18, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1011127, 19, system_get_current_year_id(), CURRENT_TIMESTAMP),

                         (1011128, 10, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1011129, 21, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1011130, 22, system_get_current_year_id(), CURRENT_TIMESTAMP),

                         (1011131, 8, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1011132, 9, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1011133, 10, system_get_current_year_id(), CURRENT_TIMESTAMP),

                         (1011134, 5, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1011135, 6, system_get_current_year_id(), CURRENT_TIMESTAMP),
                         (1011136, 7, system_get_current_year_id(), CURRENT_TIMESTAMP);

INSERT INTO OrganizationFacultyAdviser(organization, faculty, yearID)
VALUES (1, 2011111, system_get_current_year_id()),
       (1, 2011112, system_get_current_year_id());

UPDATE StudentOrganization
    -- galing sa la salle
    -- 1k operational
   SET operationalFunds = floor((random()*(1500 - 920 + 1))) + 920,
    -- 300k
        depositoryFunds = floor((random()*(350000 - 300000 + 1))) + 300000,
        depositryFunds = depositoryFunds;

COMMIT;