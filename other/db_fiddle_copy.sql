-- create and populate table patients

create table patients (
    id_patient      serial primary key,        -- identifier, auto increments
    first_name      varchar(128) not null,
    last_name       varchar(128) not null
);

insert into patients (first_name, last_name) values
    ('Gwen', 'Schmidt'),            -- 1
    ('Nixon','Peralta'),            -- 2
    ('Ethan', 'Cohen')              -- 3
;


-- create and populate lab_results

create table lab_results (

    id_lab_result       serial primary key,     -- identifier, autoincrements    
    id_patient          int not null,           -- fk relation
    result_date         date not null,          -- date of test result
    result_description  varchar(512),
    -- id_test_type        int not null,        -- fk to hypothecial test_type table

    constraint fk_patient
        foreign key (id_patient) references patients(id_patient)
);

insert into lab_results (id_patient, result_date, result_description) values
    (1,'2023-04-20','Hemoglobin: 14.2 g/dL - within normal range'),
    (1,'2025-07-14','Total cholesterol: 210 mg/dL - borderline high'),
    (1,'2026-01-05','TSH: 4.8 mIU/L - within normal range'),
    (2,'2020-09-15','TSH: 0.3 mIU/L - below normal range, hyperthyroidism possible'),
    (2,'2022-12-01','Total cholesterol: 185 mg/dL - within normal range'),
    (3,'2024-03-25','Fasting glucose: 118 mg/dL - slightly elevated')
;

-------------------------------------------


with ranked_lr as (
    select
        pa.first_name,
        pa.last_name,
        lr.id_lab_result,
        lr.result_date,
        lr.result_description,
        row_number() over (
            partition by lr.id_patient
            order by lr.result_date desc
        ) as rn
    from patients as pa
    inner join lab_results as lr     on lr.id_patient = pa.id_patient
)
select * from ranked_lr
where ranked_lr.rn = 1
;