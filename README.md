# AYRAQ App – Women's Digital Safety Solution

**AYRAQ** is an AI-powered mobile application designed to protect women from digital threats like online harassment, blackmail, and death threats. It detects harmful messages in real-time, lets users capture evidence via a floating button, and sends immediate alerts with screenshots to trusted contacts, along with legal guidance.

## 🚀 Features

- 🔍 **Real-Time Threat Detection** using AI (trained on NLP models like BERT)
- 📷 **One-Tap Screenshot Capture** using a floating button
- 📩 **Automatic Email Alert System** to send proof to emergency contacts
- 🛡️ **Built-in Legal Advice** section for next steps
- 🔘 Works over any app without interrupting usability (floating overlay)

---

## 📁 Project Structure

```bash
AYRAQ/
│
├── ayraq_app/              # Flutter frontend
│   ├── lib/
│   ├── assets/
│   └── pubspec.yaml
│
├── Janeesha_Model/         # AI/NLP model folder
│   ├── model_training.ipynb
│   ├── model.py
│   └── data/
│
├── .gitignore
├── README.md
└── requirements.txt        # Python dependencies for AI module
