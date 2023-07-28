# Start from a base Ubuntu image
FROM ubuntu:latest

# Install necessary tools
RUN apt-get update && apt-get install -y \
    wget \
    gcc \
    make \
    python3 \
    python3-pip \
    git

# Clone the repository (replace with the actual repository if it's not the one below)
RUN git clone https://github.com/karpathy/llama2.git

# Navigate to the cloned directory
WORKDIR /llama2

# Install Python dependencies
COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Download the model
RUN wget https://huggingface.co/karpathy/tinyllamas/resolve/main/stories15M.bin

# Compile the C code
RUN make run

# Run the model
CMD ["./run", "stories15M.bin"]
