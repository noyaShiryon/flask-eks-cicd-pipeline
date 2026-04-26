from flask import Flask, render_template_string

app = Flask(__name__)

# עיצוב CSS מובנה כדי לשמור על קובץ אחד פשוט
HTML_TEMPLATE = """
<!DOCTYPE html>
<html>
<head>
    <title>EKS Flask App</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f0f2f5; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .card { background: white; padding: 2rem; border-radius: 15px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); text-align: center; max-width: 400px; }
        .status-badge { background-color: #28a745; color: white; padding: 5px 15px; border-radius: 20px; font-size: 0.9rem; }
        h1 { color: #1a73e8; }
        p { color: #5f6368; }
        .footer { margin-top: 20px; font-size: 0.8rem; color: #9aa0a6; }
    </style>
</head>
<body>
    <div class="card">
        <span class="status-badge">Live on EKS</span>
        <h1>Flask App v2.0</h1>
        <p>Your CI/CD pipeline is working perfectly!</p>
        <div class="footer">Deployed via GitHub Actions & Terraform</div>
    </div>
</body>
</html>
"""

@app.route('/')
def home():
    return render_template_string(HTML_TEMPLATE)

@app.route('/health')
def health():
    return {"status": "healthy"}, 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)