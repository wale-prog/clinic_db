CREATE TABLE patients (
    id int GENERATED BY DEFAULT AS IDENTITY,
    name varchar(100),
    date_of_birth date,
    PRIMARY KEY (id)
);
CREATE INDEX idx_patients ON  patients (name, date_of_birth);


CREATE TABLE medical_histories(
    id int GENERATED BY DEFAULT AS IDENTITY,
    admitted_at timestamp,
    patients_id INT,
    status varchar(100),
    PRIMARY KEY (id)
);
CREATE INDEX idx_medical_histories ON medical_histories(patients_id);


CREATE TABLE medical_histories_has_treatments (
    medical_history_id INT REFERENCES medical_histories(id),
    treatment_id INT REFERENCES treatments(id),
);
CREATE INDEX idx_treatment_join_table ON medical_histories_has_treatments(medical_history_id, reatment_id);

CREATE TABLE invoices(
    id int GENERATED BY DEFAULT AS IDENTITY,
    total_amount decimal,
    generated_at timestamp,
    payed_at timestamp,
    medical_history_id INT REFERENCES medical_histories(id),
    PRIMARY KEY (id)
);
CREATE INDEX idx_invoices ON invoices(medical_history_id);

CREATE TABLE treatments (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    type VARCHAR (100),
    name VARCHAR(100),
    PRIMARY KEY (id),
    CONSTRAINT treatments_medical_history FOREIGN KEY(id) REFERENCES medical_histories(id)
);
CREATE INDEX idx_treatments ON treatments(treatments_medical_history);

CREATE TABLE invoice_items (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    unit_price DEC(5, 2),
    quantity INT,
    total_price DEC (5,2),
    invoice_id INT,
    treatment_id INT,
    PRIMARY KEY (id),
    CONSTRAINT invoice_items_treatment FOREIGN KEY (treatment_id) REFERENCES treatments(id),
    CONSTRAINT invoice_items_invoices FOREIGN KEY (invoice_id) REFERENCES invoices (id)
);
CREATE INDEX idx_invoice_items ON invoice_items(invoice_items_treatment, invoice_items_invoices);



