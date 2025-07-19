import streamlit as st
import easyocr
from PIL import Image
from transformers import pipeline
import torch
import tempfile

st.set_page_config(page_title="Threat Categorization from Screenshots", layout="centered")
st.title("Threat Categorization from Screenshots")

st.write("""
Upload a screenshot of an email or text message. The app will extract the text and categorize the threat as harassment, blackmail, death threat, or other.
""")

uploaded_file = st.file_uploader("Upload an image (screenshot)", type=["png", "jpg", "jpeg"])

if uploaded_file:
    image = Image.open(uploaded_file)
    st.image(image, caption="Uploaded Screenshot", use_column_width=True)
    
    # OCR
    st.write("Extracting text from image...")
    reader = easyocr.Reader(['en'], gpu=torch.cuda.is_available())
    with tempfile.NamedTemporaryFile(delete=False, suffix='.png') as tmp_file:
        image.save(tmp_file.name)
        result = reader.readtext(tmp_file.name, detail=0)
    extracted_text = " ".join(result)
    st.subheader("Extracted Text:")
    st.write(extracted_text if extracted_text else "No text found.")

    if extracted_text:
        # Zero-shot classification
        st.write("\nClassifying threat type...")
        classifier = pipeline(
            "zero-shot-classification",
            model="facebook/bart-large-mnli",
            device=0 if torch.cuda.is_available() else -1
        )
        candidate_labels = ["harassment", "blackmail", "death threat", "other"]
        output = classifier(extracted_text, candidate_labels)
        st.subheader("Prediction:")
        for label, score in zip(output['labels'], output['scores']):
            st.write(f"**{label.title()}**: {score*100:.2f}%")
        st.success(f"**Most likely category:** {output['labels'][0].title()}")
    else:
        st.warning("No text could be extracted from the image.") 