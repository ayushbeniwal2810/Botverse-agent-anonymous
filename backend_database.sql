-- Enable UUID generation extension if not already enabled
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Table to store the different grievance categories
CREATE TABLE Categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Table to store the anonymous grievances submitted by users
CREATE TABLE Grievances (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    category_id INTEGER NOT NULL,
    details TEXT NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'Submitted',
    -- Storing the email encrypted adds a strong layer of security.
    -- The application layer is responsible for encryption/decryption.
    notification_email TEXT, -- Storing as TEXT to accommodate encrypted string
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    
    -- This sets up the relationship between the two tables
    CONSTRAINT fk_category
        FOREIGN KEY(category_id) 
        REFERENCES Categories(id)
        ON DELETE SET NULL -- If a category is deleted, don't delete the grievance
);

-- Create an index for faster lookups by status or category
CREATE INDEX idx_grievances_status ON Grievances(status);
CREATE INDEX idx_grievances_category_id ON Grievances(category_id);

---
-- Example Data: Populating the Categories table
---
INSERT INTO Categories (name, description) VALUES
('Academics', 'Issues related to curriculum, grading, and academic policies.'),
('Infrastructure', 'Concerns about classrooms, labs, Wi-Fi, and other physical facilities.'),
('Hostel & Mess', 'Feedback regarding accommodation, food quality, and hostel services.'),
('Faculty & Courses', 'Specific feedback about teaching methods, course material, or faculty conduct.'),
('Library', 'Issues related to book availability, library hours, or resources.'),
('Transport', 'Concerns regarding bus services, scheduling, or transport facilities.'),
('Other', 'For grievances that do not fit into the other categories.');

