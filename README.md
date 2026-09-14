# 📚 Library API

A robust **Ruby on Rails API** for managing a library system, supporting book creation with automated serial numbering, reader management, and book checkout/return workflows.

---

## ✨ Features

* **Book Management**: Create books with automatic serial number generation via *PostgreSQL sequences*.
* **Reader Management**: Track library readers and associate them via ID or card number.
* **Borrowing System**: Handle book checkouts (`POST`) and returns (`PATCH`) with state validation.
* **Service Objects**: Clean and maintainable business logic separation.

---

## 🛠️ Tech Stack

* **Ruby** (compatible with modern Rails versions)
* **Ruby on Rails** (API-only mode)
* **PostgreSQL** (Database with custom sequences)
* **RSpec** (Testing framework)
* **Docker & Docker Compose** (Containerization)

---

## 🚀 API Endpoints

> *💡 **Note:** The ID numbers used in the request payloads below are examples. Make sure to use existing `book_id` and `reader_id` values from your local database.*

### 1. Create a Book
* **Endpoint:** `POST /api/v1/books`
* **Payload:**
  ```json
  {
    "book": {
      "title": "Clean Architecture",
      "author": "Robert C. Martin",
      "serial_number": "CA9988"
    }
  }
### 2. Checkout a Book
* **Endpoint:** `POST /api/v1/borrowings/checkout`
* **Payload:**
  ```json
  {
    "book_id": 178,
    "reader_id": 97
  }
### 3. Return a Book
* **Endpoint:** `PATCH /api/v1/borrowings/return`
* **Payload:**
  ```json
  {
    "book_id": 178
  }
## ⚙️ Getting Started

### 🐳 Running with Docker (Recommended)

1. **Build and start the containers:**
   ```bash
   docker compose up --build
2. **Prepare the database and load initial seeds** *(in a separate terminal window)*:
   ```bash
   docker compose exec web bin/rails db:setup

> *(Alternately, you can run migrations with `docker compose exec web bin/rails db:prepare` and seeds with `docker compose exec web bin/rails db:seed`)*

The API will be available at **`http://localhost:3000`**.

---

### 💻 Running Locally (Without Docker)

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/mdobosz3/library-api.git](https://github.com/mdobosz3/library-api.git)
   cd library-api
2. **Install dependencies:**
   ```bash
   bundle install
3. **Setup the database and load seeds:**
   ```bash
   bin/rails db:setup
4. **Run the server:**
   ```bash
   bin/rails server
