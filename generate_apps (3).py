import os
import json
import requests
from datetime import datetime

GROQ_API_KEY = os.environ.get("GROQ_API_KEY")
OUTPUT_DIR = f"generated_apps/{datetime.now().strftime('%Y-%m-%d')}"
os.makedirs(OUTPUT_DIR, exist_ok=True)

def ask_groq(prompt):
    response = requests.post(
        "https://api.groq.com/openai/v1/chat/completions",
        headers={
            "Authorization": f"Bearer {GROQ_API_KEY}",
            "Content-Type": "application/json"
        },
        json={
            "model": "llama3-8b-8192",
            "messages": [{"role": "user", "content": prompt}],
            "max_tokens": 2000
        }
    )
    return response.json()["choices"][0]["message"]["content"]

def generate_app_idea():
    prompt = """Generate a simple Android utility app idea. Return ONLY a JSON object like this:
{
  "name": "App Name",
  "description": "Short description",
  "category": "Tools",
  "features": ["feature1", "feature2", "feature3"]
}
Ideas: calculator, unit converter, tip calculator, BMI calculator, currency converter, timer, stopwatch, note taker, password generator, age calculator."""
    
    text = ask_groq(prompt)
    start = text.find("{")
    end = text.rfind("}") + 1
    return json.loads(text[start:end])

def generate_flutter_code(app):
    prompt = f"""Write a complete Flutter main.dart file for this app:
Name: {app['name']}
Description: {app['description']}
Features: {', '.join(app['features'])}

Write clean, working Flutter code. Use Material Design. Return ONLY the dart code, no explanations."""
    
    return ask_groq(prompt)

def generate_play_store_listing(app):
    prompt = f"""Write a Google Play Store listing for this app:
Name: {app['name']}
Description: {app['description']}
Category: {app['category']}

Return ONLY a JSON object:
{{
  "title": "app title",
  "short_description": "max 80 chars",
  "full_description": "full description 4000 chars max",
  "keywords": ["keyword1", "keyword2", "keyword3"]
}}"""
    
    text = ask_groq(prompt)
    start = text.find("{")
    end = text.rfind("}") + 1
    return json.loads(text[start:end])

print("Starting app generation...")

for i in range(5):
    try:
        print(f"\nGenerating app {i+1}/5...")
        
        app = generate_app_idea()
        print(f"   Idea: {app['name']}")
        
        safe_name = app['name'].replace(" ", "_").lower()
        app_dir = f"{OUTPUT_DIR}/{safe_name}"
        os.makedirs(app_dir, exist_ok=True)
        
        with open(f"{app_dir}/app_info.json", "w") as f:
            json.dump(app, f, indent=2)
        
        flutter_code = generate_flutter_code(app)
        with open(f"{app_dir}/main.dart", "w") as f:
            f.write(flutter_code)
        print(f"   Flutter code generated")
        
        listing = generate_play_store_listing(app)
        with open(f"{app_dir}/play_store_listing.json", "w") as f:
            json.dump(listing, f, indent=2)
        print(f"   Play Store listing generated")
        
    except Exception as e:
        print(f"   Error generating app {i+1}: {e}")
        continue

print(f"\nDone! Apps saved to {OUTPUT_DIR}/")
