FROM python:3
RUN python -m pip install --upgrade pip
RUN pip install robotframework
RUN apt-get update && apt-get install -y chromium-driver 
WORKDIR /test
COPY requirements.txt .
RUN pip install -r requirements.txt
# This expects the folder containing the tests to be mounted
ENTRYPOINT [ "robot", "--outputdir", "results", "." ]

# Run image as follows:
# docker run -it -v //e/Projects/robot-framework-uwv:/test robot-framework 