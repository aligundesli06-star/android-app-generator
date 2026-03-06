import os
import json
import datetime
from groq import Groq

client = Groq(api_key=os.environ.get("GROQ_API_KEY"))

today = datetime.date.today().isoformat()
output_dir = f"generated_apps/{today}"
os.makedirs(output_dir, exist_ok=True)

app_ideas_prompt = """Generate 5 simple Android app ideas that are useful utilities. 
For each app provide:
1. App name
2. Short description (1-2 sentences)
3. Main features (3-5 bullet points)
4. Target audience

Format as JSON array with fields: name, description, features (array), target_audience"""

print("Generating app ideas with Groq...")
response = client.chat.completions.create(
    model="llama3-8b-8192",
    messages=[{"role": "user", "content": app_ideas_prompt}],
    max_tokens=2000
)

raw = response.choices[0].message.content
print("Raw response received")

# Parse JSON
try:
    start = raw.find('[')
    end = raw.rfind(']') + 1
    json_str = raw[start:end]
    apps = json.loads(json_str)
except Exception as e:
    print(f"JSON parse error: {e}")
    apps = [{"name": "Simple Calculator", "description": "Basic calculator app", "features": ["Addition", "Subtraction"], "target_audience": "Everyone"}]

# Save ideas
ideas_path = f"{output_dir}/app_ideas.json"
with open(ideas_path, "w") as f:
    json.dump(apps, f, indent=2)
print(f"Saved {len(apps)} app ideas to {ideas_path}")

# Generate Flutter code for each app
for i, app in enumerate(apps[:3]):
    app_name = app.get("name", f"App{i+1}").replace(" ", "")
    
    code_prompt = f"""Write a complete Flutter main.dart file for an app called "{app['name']}".
Description: {app['description']}
Features: {', '.join(app.get('features', []))}

Write only the Dart code, no explanation. Make it functional and clean."""

    print(f"Generating code for {app['name']}...")
    code_response = client.chat.completions.create(
        model="llama3-8b-8192",
        messages=[{"role": "user", "content": code_prompt}],
        max_tokens=2000
    )
    
    code = code_response.choices[0].message.content
    
    app_dir = f"{output_dir}/{app_name}"
    os.makedirs(app_dir, exist_ok=True)
    with open(f"{app_dir}/main.dart", "w") as f:
        f.write(code)
    
    listing = {
        "title": app['name'],
        "short_description": app['description'][:80],
        "full_description": app['description'],
        "category": "Tools"
    }
    with open(f"{app_dir}/play_store_listing.json", "w") as f:
        json.dump(listing, f, indent=2)
    
    print(f"Saved {app['name']}")

print("Done! All apps generated successfully.")
