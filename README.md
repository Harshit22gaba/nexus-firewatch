# Nexus FireWatch 🔥 - A Predictive Wildfire Intelligence Platform

**Live Demo URL:** https://nexus-firewatch.vercel.app/

---

## 1. The Mission: From Static Data to Dynamic Intelligence

Wildfires represent a critical and escalating global challenge. Traditional risk assessment is often static, failing to capture the dynamic interplay of geography and time. **Nexus FireWatch** was architected to solve this problem by transforming historical data into a live, intelligent, and predictive tool for proactive risk assessment.

Our mission was to build a **complete, end-to-end intelligent application** that demonstrates the power of BigQuery's built-in AI to solve a significant, real-world operational problem. This project is a blueprint for how the **AI Architect pattern** can be used to create scalable, impactful solutions directly within the data warehouse.

---

## 2. The Solution: A Live Demo

Our platform allows users to get a **dynamic fire risk prediction** for any location on Earth, at any time of year.

### ✨ The "Magic" Moment: Showcasing Seasonal Intelligence

The core innovation of our model is its understanding of **temporal patterns**:

* **High Season:** A query for a known hotspot in British Columbia during **August** correctly yields a **High Risk 🔥**.
* **Low Season:** A query for the same location during **January** correctly yields a **Low Risk 🌲**.

This demonstrates intelligence beyond simple location-based analysis, providing **dynamic and actionable insights**.

---

## 3. The Architecture: A Serverless End-to-End Workflow

Nexus FireWatch is built as a **serverless application** on Google Cloud, showcasing a robust and scalable architecture that is ready for enterprise-level deployment.

### Core Components

* **Frontend:** Clean, responsive UI built with **HTML, Tailwind CSS, Leaflet.js**, deployed statically.
* **Backend API:** A serverless **Python function** on **Google Cloud Run** serving live predictions.
* **Data Warehouse & AI Core:** **Google BigQuery** as the single source of truth for data storage & ML.

### Workflow Diagram

```
[User on Web Browser] --> [Static Frontend (Vercel/Netlify)]
       |
       | (HTTPS API Request with lat, lon, month)
       v
[Cloud Run Function] <--> [BigQuery ML.PREDICT]
       |                      ^
       |                      | (Uses fire_model_production)
       |                      |
       +-------------------- [BigQuery Data Warehouse]
```

---

## 4. BigQuery AI Usage: The AI Architect's Toolbox

This project is a **canonical example of the AI Architect approach**, leveraging BigQuery's **native predictive modeling suite** to build the intelligence layer.

### a. Intelligent Feature Engineering

* Engineered features directly in **SQL**.
* Created **regional grid cells** instead of relying on raw latitude/longitude.
* Improved learning by teaching the model to recognize **geographic zones**.

### b. The Machine Learning Core

* Model: **BOOSTED\_TREE\_CLASSIFIER** built in BigQuery.
* **CREATE MODEL:** Trained using SQL queries on geospatial & temporal features.
* **ML.EVALUATE:** Validated with built-in tools, achieving high accuracy.
* **ML.PREDICT:** Served live inferences directly in the backend API, without external ML infra.

---

## 5. How to Replicate

The project is fully reproducible with a **Google Cloud account**.

### BigQuery Setup

1. Load fire data (e.g., **NASA FIRMS**) into a BigQuery table.
2. Run SQL scripts in `/sql` directory (`01_...`, `02_...`, `03_...`) to prepare data and train the model.

### Backend Deployment

* Deploy from `/backend` to **Cloud Run**.
* Ensure service account has:

  * `BigQuery User`
  * `Cloud Run Admin` roles.

### Frontend Deployment

* Update the `CLOUD_FUNCTION_URL` constant in **index.html** with your Cloud Run endpoint.
* Deploy index.html to **Vercel** or **Netlify**.

---