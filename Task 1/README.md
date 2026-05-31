## Data Cleaning Steps Performed



I performed the following steps :



1. **Rename Column Headers:** Stripped leading/trailing whitespaces.

   * Converted all headers to lowercase.
   * Replaced spaces and special characters with underscores (`\_`) to make them clean and uniform (e.g., `Year Birth` -> `year\_birth`).
2. **Handle Missing Values:** Identified missing values in the income column using `.isnull()`.

   * Imputed these missing values using the column's median to prevent data loss.
3. **Remove Duplicates:** Dropped all identical overlapping rows using the `.drop\_duplicates()` function.
4. **Standardize Text Values:** Cleaned the marital status column by mapping unstructured and slang entries (like "Alone", "YOLO", and "Absurd") into the standard category `"Single"`.
5. **Fix Data Types:** Ensured income was cast strictly to an integer (`int`).

   * Parsed the customer enrollment date column into a proper Pandas datetime object.
6. **Convert Date Formats:** Reformatted the parsed datetime objects into a consistent `DD-MM-YYYY` string format.

