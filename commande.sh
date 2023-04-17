# 1. Preparing the environment
git clone https://github.com/lalasonsamuel/flask-sklearn-cd
cd flask-sklearn-cd/
python3 -m venv ~/.myvenv
source ~/.myvenv/bin/activate
make install
python -m flask run

# 2. Testing APP Locally in Azure CD_Pipeline
python app.py
cd flask-sklearn-cd/
chmod +x make_prediction.sh
./make_prediction.sh

# 3. Depoly App in Azure App Service
az webapp up --name flasksklearnbysami --resource-group Azuredevops --runtime "PYTHON:3.7"
chmod +x make_predict_azure_app.sh
./make_predict_azure_app.sh

# 4. Monitor the Logs
az webapp log tail --resource-group Azuredevops --name flasksklearnbysami

# 5. Load Test
pip install locust
locust
locust --headless --users 10 --spawn-rate 1 -H https://flaskdemobysami.azurewebsites.net/