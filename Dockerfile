FROM python:3.12-alpine

# Set working directory
WORKDIR /app

# Copy requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 3002

#expose the port its running on 
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "3002", "--reload"]
