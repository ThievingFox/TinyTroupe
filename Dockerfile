FROM python:3.10.16-slim

# 1) Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# 2) Set working directory
WORKDIR /app

# 3) Copy everything from your local 'tinytroupe' project into /app
COPY . /app

# 4) Install the entire project in editable mode
#    This picks up the pyproject.toml/setup.py in /app
RUN pip install --no-cache-dir -e .
RUN pip install FastAPI
RUN pip install uvicorn

# 5) Expose port (if running a FastAPI)
EXPOSE 8000

# 6) Default command: run story_api
CMD ["uvicorn", "tinytroupe.story_api:app", "--host", "0.0.0.0", "--port", "8000"]
