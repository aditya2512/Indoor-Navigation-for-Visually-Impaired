#  Indoor Navigation for Visually Impaired

A real-time indoor navigation system leveraging **UWB (Ultra-Wideband)** technology and **audio-based feedback** to assist visually impaired individuals in safely navigating indoor environments such as malls, airports, and museums.

##  Project Overview

This project combines **precise indoor positioning**, **obstacle detection**, and **context-aware audio guidance** to create a low-latency navigation assistant tailored to the needs of visually impaired users.

It enables:
- Accurate real-time tracking using UWB anchors and tags
- Context-aware audio guidance when the user approaches specific locations
- Enhanced spatial awareness through custom proximity alerts and direction cues

---

##  Key Features

-  **UWB-Based Positioning**: Uses UWB sensors to determine user location with sub-meter accuracy.
-  **Audio Assistance**: Location-triggered audio feedback provides direction, alerts, and contextual information.
-  **Proximity Detection**: Dynamically identifies nearby points of interest and obstacles to deliver timely instructions.
-  **Modular Design**: Clean separation between positioning, decision logic, and audio output modules.

---

## 🧠 System Architecture

+---------------+ +-------------------+ +----------------+
| UWB Anchor | <----> | UWB Tag (on user) | ---> | Processing Unit |
+---------------+ +-------------------+ +----------------+
|
v
+----------------------+
| Audio Feedback System |
+----------------------+

---

## Technologies Used

- **Python** – For core logic and data processing
- **UWB Sensors** – For precise indoor location tracking
- **Text-to-Speech (TTS)** – For dynamic voice guidance
- **Matplotlib / OpenCV** – For visualization and layout mapping (optional)

---

## Repository Structure

Indoor-Navigation-for-Visually-Impaired/
├── main.py # Main script for running the navigation assistant
├── uwb_localization.py # UWB positioning and data handling logic
├── audio_feedback.py # Text-to-speech and contextual audio generation
├── config/ # Configuration files for layout and sensor setup
├── utils/ # Helper functions for distance calculation, etc.
├── requirements.txt # Python dependencies
└── README.md # Project documentation


## 🔧 Setup Instructions

1. **Clone the Repository**

- git clone https://github.com/aditya2512/Indoor-Navigation-for-Visually-Impaired.git
- cd Indoor-Navigation-for-Visually-Impaired
- Install Dependencies

- pip install -r requirements.txt
- Connect UWB Hardware

- Ensure your UWB anchors and tags are properly connected and configured.

- Update the config/ files with correct device IDs and layout mapping.

- Run the Application

- python main.py

## Sample Output
- “Obstacle detected ahead. Turn slightly right.”
- Real-time coordinates printed for debug
- Optional: Live indoor map with user location plot

## Limitations
- Assumes static layout and calibrated UWB devices

- Limited testing across varied building types

- Currently optimized for demo environments; may need tuning for production-scale deployments

## Future Enhancements
- Integrate computer vision for additional obstacle detection

- Add Bluetooth fallback for areas without UWB coverage

- Improve personalization using AI-based path prediction

- Add support for multilingual voice output

## Contributing
- Interested in contributing? Please open an issue or submit a pull request. Feedback and improvements are always welcome!

