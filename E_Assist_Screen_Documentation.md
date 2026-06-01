# E-Assist Application: Complete Screen Documentation

This document outlines every screen within the E-Assist application. It provides a visual placeholder for screenshots, alongside a detailed description of what each screen does and the rationale behind its design and functionality.

---

## 1. Onboarding & Authentication Flow

### Platform Selection Screen (`platform_selection_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `platform_selection_screen.png`)*

**What it does:** This is the landing screen when the app is first opened. It introduces the "E-Assist" brand and allows users to proceed to role selection.
**Rationale:** To provide a welcoming, brand-consistent entry point that clearly sets expectations about the app's purpose (saving lives in emergencies).

### Role Selection Screen (`role_selection_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `role_selection_screen.png`)*

**What it does:** Asks the user to identify their primary role (Donor, Requester, Hospital Staff, Dispatcher/Ambulance, Administrator).
**Rationale:** The system handles deeply distinct use cases depending on the actor (as per the system architecture). By segmenting users immediately, the app can tailor the entire registration flow and subsequent dashboards to their specific needs.

### Account Selection Screen (`account_selection_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `account_selection_screen.png`)*

**What it does:** Allows users to choose whether they want to log in to an existing account or register a new one.
**Rationale:** A standard authentication routing mechanism to ensure users don't accidentally try to register an existing email or login to an unregistered one.

### Registration Screen (`registration_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `registration_screen.png`)*

**What it does:** Collects user details (Name, Email, Phone, Password, Blood Type, City) and creates a secure Firebase Authentication profile.
**Rationale:** Essential for building the user database. Capturing blood type and city at registration allows the matching algorithm to instantly work for new donors when emergencies occur nearby.

### Login Screen (`login_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `login_screen.png`)*

**What it does:** A unified login portal where users can enter either their Email Address or Phone Number along with their password to authenticate. It automatically routes the user to their designated dashboard.
**Rationale:** Reduces login friction by allowing multiple identification methods (Email/Phone) in a single field, and smartly auto-routing based on backend data rather than forcing manual role selection again.

### Forgot Password Screen (`forgot_password_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `forgot_password_screen.png`)*

**What it does:** Allows users to input their email to receive a secure password reset link.
**Rationale:** Crucial for user retention and account recovery. Ensures users who forget their credentials are not locked out of the system.

---

## 2. Donor Role Dashboards

### Donor Home Screen (`donor_home_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `donor_home_screen.png`)*

**What it does:** The central hub for donors. It displays their live availability toggle, quick stats (lives saved, response rate), progress toward their next donation milestone, and a live feed of active, nearby emergency requests.
**Rationale:** Designed to maximize engagement. By showing gamified elements (milestones) alongside urgent, actionable data (nearby emergencies), it encourages rapid response to SOS calls.

### Donor Map Screen (`donor_map_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `donor_map_screen.png`)*

**What it does:** Displays a geographic map plotting active emergency requests relative to the donor's current GPS location.
**Rationale:** Spatial awareness is critical in emergencies. Donors can visually assess which emergencies are closest to them and make split-second decisions on where they can help fastest.

### Donor Notifications Screen (`donor_notifications_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `donor_notifications_screen.png`)*

**What it does:** A feed of alerts specifically matching the donor's blood type or geographic proximity.
**Rationale:** Ensures donors never miss an urgent request. It acts as the historical log of push notifications sent by the system matching algorithm.

### Emergency Details Screen (`emergency_details_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `emergency_details_screen.png`)*

**What it does:** Shows expanded information about a specific SOS request (exact distance, required blood type, urgency, and description) and provides a button to "Accept" the request and navigate to the location.
**Rationale:** Donors need full context before committing to an emergency. This screen provides the critical details necessary for a safe and effective response.

### Donation History Screen (`donation_history_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `donation_history_screen.png`)*

**What it does:** Lists all past emergencies the donor has successfully responded to.
**Rationale:** Provides a sense of accomplishment and maintains a verifiable record of the donor's philanthropic activity.

---

## 3. Requester Role Dashboards

### Requester Home Screen (`requester_home_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `requester_home_screen.png`)*

**What it does:** The main interface for users who need help. Features a prominent "Trigger SOS" button, access to the AI Assistant, and tracks ongoing emergency requests.
**Rationale:** In a crisis, the UI must be immediately obvious. The massive SOS button ensures that panic does not hinder a user's ability to broadcast for help.

### Emergency Form / SOS Screen (`emergency_form_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `emergency_form_screen.png`)*

**What it does:** A rapid-entry form where the requester specifies the type of emergency (Blood, Accident, General), urgency, and any required blood type before broadcasting.
**Rationale:** While speed is key, accuracy is also vital. Gathering these specific details allows the algorithm to only notify the correct, eligible donors (e.g., matching blood types).

### AI Assistant Screen (`ai_assistant_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `ai_assistant_screen.png`)*

**What it does:** A chat interface powered by AI that can analyze symptoms, generate first-aid guidance, and recommend nearby hospitals.
**Rationale:** Fulfills the AI Assistant use case from the system architecture. It bridges the gap between an emergency occurring and an ambulance arriving by providing life-saving immediate advice.

### Requester History Screen (`requester_history_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `requester_history_screen.png`)*

**What it does:** Displays past SOS requests made by the user and their resolutions.
**Rationale:** Allows users to review past medical emergencies, which can be useful for hospital records or personal tracking.

---

## 4. Secondary Actors (Administrative & Dispatch)

### Hospital Main Screen (`hospital_main_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `hospital_main_screen.png`)*

**What it does:** The dashboard for Hospital Staff to view incoming SOS cases, update case statuses, and create direct donation requests.
**Rationale:** Integrates medical facilities directly into the ecosystem, allowing them to manage incoming patients and request blood supplies proactively.

### Dispatcher Main Screen (`dispatcher_main_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `dispatcher_main_screen.png`)*

**What it does:** The dashboard for ambulance dispatchers to assign units to active SOS cases and track their real-time locations.
**Rationale:** Fulfills the Dispatcher use cases. Ensures that professional medical transport is coordinated seamlessly alongside civilian volunteer donors.

### Admin Main Screen (`admin_main_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `admin_main_screen.png`)*

**What it does:** A system administration panel to manage registered hospitals and control role permissions.
**Rationale:** Provides governance over the platform, ensuring only verified hospitals and dispatchers have access to those privileged roles.

---

## 5. Global Settings & Preferences

### App Settings Screen (`app_settings_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `app_settings_screen.png`)*

**What it does:** The central settings hub providing navigation to profile editing, language, location settings, and app information.
**Rationale:** Consolidates all configuration options into one standard, easy-to-navigate list.

### Edit Profile Screen (`edit_profile_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `edit_profile_screen.png`)*

**What it does:** Allows the user to update their personal information, blood type, and contact details.
**Rationale:** Maintains accurate data in the system, which is critical since medical profiles (like blood type) dictate who receives emergency alerts.

### Language Settings Screen (`language_settings_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `language_settings_screen.png`)*

**What it does:** Allows users to toggle the app's interface between English, Arabic, French, and German.
**Rationale:** Ensures the application is accessible to a diverse, global user base and functions flawlessly in Right-to-Left (RTL) layouts for Arabic.

### Location Settings Screen (`location_settings_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `location_settings_screen.png`)*

**What it does:** Manages GPS permissions and defines the radius for receiving emergency alerts.
**Rationale:** Gives users privacy control over their background location tracking while allowing them to customize how far they are willing to travel for an emergency.

### About App Screen (`about_app_screen.dart`)
**Screenshot:**
> *(Insert Image Here: `about_app_screen.png`)*

**What it does:** Displays the project proposal details, team members, supervisor information, motivation, and research problem.
**Rationale:** Serves as the digital manifestation of the project poster/proposal, formally documenting the academic context and vision of E-Assist within the app itself.
