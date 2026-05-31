import pandas as pd
import numpy as np
from google.colab import files

print("--- Generating & Cleaning Medical Appointment Data ---")
np.random.seed(43)
n = 1000

# Generating Data
patient_names = ["Rajesh", "Sunita", "Deepak", "Anita", "Suresh", "Meena", "Ramesh", "Geeta", "Vijay", "Priyanka", "Sanjay", "Kiran", "Ashok", "Nisha", "Manoj"]
neighbourhoods = ["Koramangala", "Indiranagar", "Jayanagar", "Whitefield", "HSR Layout", "Malleswaram", "Marathahalli", "BTM Layout", "JP Nagar", "Hebbal", "Yelahanka", "Electronic City"]

df = pd.DataFrame({
    'PatientId': np.random.randint(1e10, 9e10, n),
    'Patient_Name': np.random.choice(patient_names, n),
    'AppointmentID': np.arange(5000000, 5000000+n),
    'Gender': np.random.choice(['Male', 'Female', 'Others'], n, p=[0.48, 0.48, 0.04]),
    'Scheduled Day': pd.date_range(start='2023-01-01', periods=n, freq='8h').strftime('%Y-%m-%dT%H:%M:%SZ'),
    'Appointment Day': pd.date_range(start='2023-01-05', periods=n, freq='8h').strftime('%Y-%m-%dT%H:%M:%SZ'),
    'Age': np.random.randint(1, 90, n).astype(float),
    'Neighbourhood': np.random.choice(neighbourhoods, n),
    'Hipertension': np.random.choice([0, 1], n, p=[0.8, 0.2]),
    'No-show': np.random.choice(['Yes', 'No'], n, p=[0.2, 0.8])
})

# Inject dirty data
df.loc[20:60, 'Gender'] = np.random.choice(['M', 'F', 'Man', 'Woman'], 41)
df.loc[100:120, 'Age'] = np.nan
df_dirty = pd.concat([df, df.iloc[:30]], ignore_index=True) 

# ==========================================
# INTERNSHIP TASK: DATA CLEANING OPERATIONS
# ==========================================
df_clean = df_dirty.copy()

# Step 5: Rename column headers to be clean and uniform (lowercase, no spaces)
df_clean.columns = df_clean.columns.str.strip().str.lower().str.replace(' ', '_').str.replace('-', '_')

# Step 1: Identify and handle missing values using .isnull()
if df_clean['age'].isnull().sum() > 0:
    age_mean = df_clean['age'].mean()
    df_clean['age'] = df_clean['age'].fillna(age_mean)

# Step 2: Remove duplicate rows using .drop_duplicates()
df_clean = df_clean.drop_duplicates()

# Step 3: Standardize text values (Gender mapping to strict list)
gender_map = {'M': 'Male', 'Man': 'Male', 'F': 'Female', 'Woman': 'Female'}
df_clean['gender'] = df_clean['gender'].replace(gender_map)

# Step 6: Check and fix data types (date as datetime, age as int)
df_clean['scheduled_day'] = pd.to_datetime(df_clean['scheduled_day'])
df_clean['appointment_day'] = pd.to_datetime(df_clean['appointment_day'])
df_clean['age'] = df_clean['age'].astype(int)

# Step 4: Convert date formats to a consistent type (dd-mm-yyyy)
df_clean['scheduled_day'] = df_clean['scheduled_day'].dt.strftime('%d-%m-%Y')
df_clean['appointment_day'] = df_clean['appointment_day'].dt.strftime('%d-%m-%Y')

# Display and Download
print(f"Final Shape: {df_clean.shape[0]} rows, {df_clean.shape[1]} columns")
filename = 'Medical_Appointments_Cleaned.csv'
df_clean.to_csv(filename, index=False)
files.download(filename)