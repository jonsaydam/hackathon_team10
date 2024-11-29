CREATE TABLE payee (
  user_id SERIAL PRIMARY KEY,
  email VARCHAR(100) NOT NULL,
  name VARCHAR(100),
  phone_number VARCHAR(15)
);

CREATE TABLE transactions (
  transaction_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES payee(user_id),
  transaction_amount NUMERIC,
  merchant VARCHAR(100),
  country VARCHAR(50),
  status VARCHAR(20)
);

CREATE TABLE fraud_scores (
  score_id SERIAL PRIMARY KEY,
  transaction_id INT REFERENCES transactions(transaction_id),
  user_id INT REFERENCES payee(user_id),
  fraud_score NUMERIC,
  risk_level VARCHAR(20)
);