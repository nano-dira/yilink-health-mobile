# YiLink Health Mobile

### Your Health Journey Starts Here.

YiLink Health Mobile is a digital healthcare and medical tourism companion designed to help patients discover trusted hospitals, explore treatment packages, request consultations, manage bookings, and navigate their healthcare journey in Malaysia.

The application brings the key parts of a patient's healthcare journey into one simple mobile experience — from discovering a hospital to managing consultation requests and accessing travel-related healthcare support.

---

## Why YiLink Health?

Healthcare and medical tourism can be difficult to navigate.

Patients may need to:

- Compare different hospitals and healthcare providers
- Understand available treatment packages
- Find suitable healthcare services
- Contact hospitals and coordinators
- Submit consultation requests
- Keep track of their healthcare journey

YiLink Health Mobile brings these experiences together in one patient-centered application.

### Our approach

**Discover → Understand → Consult → Book → Manage Journey**

---

# Product Overview

YiLink Health Mobile provides a streamlined experience for patients looking for healthcare services in Malaysia.

### Core experiences

| Module | Description |
|---|---|
| Home | Discover hospitals, healthcare services and featured content |
| Explore Hospitals | Search and explore available hospitals |
| Treatment Packages | Browse available healthcare and treatment packages |
| Consultation Booking | Submit consultation requests and preferred dates |
| My Bookings | View and manage consultation requests |
| Medical Journey | Access guidance throughout the healthcare journey |
| Profile | Manage account and personal information |
| WhatsApp | Alternative communication with healthcare coordinators |
| Google Sign-In | Secure account authentication |

---

# Key Features

## Home

The home screen provides a simple starting point for the patient's healthcare journey.

- Featured hospitals
- Popular healthcare services
- Treatment packages
- Healthcare journey shortcuts
- Hospital and treatment search
- Quick access to bookings

---

## Explore Hospitals

Patients can discover healthcare providers through a structured hospital browsing experience.

- Hospital discovery
- Location information
- Healthcare specialties
- Supported languages
- Hospital information
- Hospital details

---

## Treatment Packages

Patients can explore available treatment packages directly within the application.

Each package provides:

- Treatment name
- Starting price
- Package information
- Healthcare provider association

---

## Consultation Booking

Patients can submit a consultation request through the application.

The booking flow includes:

1. Select a hospital
2. Provide personal information
3. Select healthcare treatment/service
4. Select preferred date
5. Add additional notes
6. Accept the privacy policy
7. Submit consultation request

---

## Google Authentication

Patients can sign in using their Google account.

Authentication is powered by:

- Firebase Authentication
- Google Sign-In
- Firebase user profiles

Authenticated users can access their account and manage their consultation history.

---

## Alternative WhatsApp Communication

Not every patient wants to create an account before asking about healthcare services.

YiLink therefore provides an alternative communication path through WhatsApp.

Patients can:

> Continue via WhatsApp

and communicate directly with the healthcare coordinator without going through the full account-based booking flow.

This creates a more flexible experience for patients who need quick assistance.

---

## My Bookings

Authenticated users can access their consultation requests and booking history.

The module is designed to provide a centralized view of the patient's healthcare requests.

---

## Medical Journey

The Medical Journey module is designed around the broader medical tourism experience.

It provides a foundation for:

- Pre-operative guidance
- Post-operative guidance
- Travel assistance
- Healthcare journey information
- Patient support

---

# Future Vision

YiLink Health Mobile is designed to evolve beyond a traditional hospital discovery and booking application.

### AI Healthcare Concierge

The future roadmap includes an AI-powered healthcare concierge that can help patients:

- Understand healthcare services
- Find suitable hospitals
- Explore treatment options
- Answer common healthcare journey questions
- Provide appointment-related assistance
- Guide patients through their medical journey

### Future roadmap

**Phase 1 — Current**

- Hospital discovery
- Treatment packages
- Consultation requests
- Google authentication
- My Bookings
- WhatsApp communication

**Phase 2 — Planned**

- AI Healthcare Concierge
- Appointment availability
- Push notifications
- Digital medical journey
- Travel assistance

**Phase 3 — Future**

- Payment integration
- Pre-operative guidance
- Post-operative follow-up
- Personalized recommendations
- International patient support

---

# System Architecture

YiLink Health Mobile is built as a dedicated Flutter mobile application.

                    ┌───────────────────────┐
                    │   YiLink Health       │
                    │       Mobile          │
                    │     Flutter / Dart    │
                    └───────────┬───────────┘
                                │
              ┌─────────────────┼─────────────────┐
              │                 │                 │
              ▼                 ▼                 ▼
       ┌────────────┐    ┌────────────┐    ┌──────────────┐
       │  Firebase  │    │   Google   │    │  WhatsApp    │
       │    Auth    │    │   Sign-In  │    │ Communication│
       └────────────┘    └────────────┘    └──────────────┘
              │
              ▼
       ┌────────────┐
       │ Firestore  │
       │  Database  │
       └────────────┘
