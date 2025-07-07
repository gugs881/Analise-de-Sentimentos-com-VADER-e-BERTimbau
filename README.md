# 🧠 Sentiment Analysis with VADER and BERTimbau

This R Markdown notebook demonstrates how to perform **sentiment analysis** using two approaches: **VADER** (rule-based) and **BERTimbau** (deep learning-based).

---

## 🔧 Environment Setup

- Uses the `reticulate` package to integrate **Python** into R.
- Downloads the **VADER lexicon** and imports Python libraries `nltk` and `transformers`.

---

## 🗂️ Text Data

A small dataset with 6 text samples is created:
- 3 in **Portuguese** and 3 in **English**
- Each labeled as **positive**, **negative**, or **neutral**

---

## 🔍 VADER Analysis

- Initializes the `SentimentIntensityAnalyzer` from NLTK
- Computes a **compound sentiment score** for each text using VADER
- Works well for **English**, but does not understand context deeply

---

## 🤖 BERTimbau Analysis

- Loads the `neuralmind/bert-base-portuguese-cased` model using `transformers`
- Applies it **only to Portuguese texts**
- Provides contextual sentiment scores with better understanding of sentence meaning

---

## 📊 Comparison

Both models’ scores are displayed side-by-side for each text. Key observations:
- **VADER** is fast and rule-based but limited in nuance
- **BERTimbau** is slower but understands **context** and **semantics**

---

## 🧾 Summary

This notebook illustrates how to integrate rule-based and transformer-based sentiment models in R using Python. It compares their performance and highlights the strengths of using deep learning (BERT) in complex language tasks.
