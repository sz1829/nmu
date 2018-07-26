




INSERT INTO GroupTourGuideDetails
(
    gd_id, 
    group_tour_id, 
    guide_id, 
    write_off
) VALUES 
(
    1,
    1,
    1,
    100
),
(
    2,
    1,
    1,
    100
),
(
    3,
    2,
    1,
    100
),
(
    4,
    2,
    1,
    100
),
(
    5,
    3,
    1,
    100
),
(
    6,
    3,
    1,
    100
);

INSERT INTO GroupTourReceived
(
    gtr_id,
    group_tour_id,
    received
) VALUES 
(
    1,
    1,
    200
),
(
    2,
    1,
    200
),
(
    3,
    2,
    200
),
(
    4,
    2,
    200
),
(
    5,
    2,
    200
),
(
    6,
    3,
    200
);