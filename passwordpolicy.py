import platform
import subprocess
import re
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas

# Define the path to the PDF file
pdf_path = './flaws.pdf'

# Check password length on Windows
if platform.system() == "Windows":
    cmd = ["net", "accounts"]
    result = subprocess.run(cmd, capture_output=True, text=True)
    row = result.stdout
    
    # Extract the minimum password length
    pattern = r"Minimum password length:\s+(\d+)"
    val = re.search(pattern, row)
    pass_length = int(val.group(1)) if val else None

    # If password length is less than 8, create a warning PDF
    if pass_length!=None and pass_length < 8:
        # Create a PDF file with ReportLab
        c = canvas.Canvas(pdf_path, pagesize=letter)
        c.setFont("Helvetica", 12)
        
        # Start a text object for better formatting
        text_object = c.beginText(72, 720)  # Starting position (left margin, height from bottom)
        text_object.setFont("Helvetica", 12)
        text_object.setLeading(14)  # Line spacing

        # Add content with line breaks and wrapping
        text_content = (
            "The password length is less than 8. Please ensure it is at least 8, "
            "as recommended by the CIS Benchmark.\n\n"
            "Reference:\n"
            "https://www.cisecurity.org/insights/white-papers/cis-primer-securing-login-credentials"
        )

        # Split text into lines and add to text object for proper wrapping
        for line in text_content.splitlines():
            text_object.textLine(line)

        # Draw the text object on the PDF
        c.drawText(text_object)
        c.save()
        print("PDF created with security warning.")
    else:
        print("Password length meets the requirements or not found.")
