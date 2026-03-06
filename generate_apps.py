import os
import json
import requests
from datetime import datetime

GROQ_API_KEY = os.environ.get("GROQ_API_KEY")
OUTPUT_DIR = f"generated_apps/{datetime.now().strftime('%Y-%m-%d')}"

os.makedirs(OUTPUT_DIR, exist_ok=True)

def call_groq(prompt):
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

app_ideas_prompt = """Generate 5 simple Android app ideas suitable for Flutter. 
Each app should be a basic utility (calculator, converter, timer, etc).
Return ONLY a JSON array like this:
[
  {"name": "AppName", "description": "Short description", "category": "Utility"},
  ...
]
No extra text, just the JSON array."""

print("Generating app ideas...")
ideas_raw = call_groq(app_ideas_prompt)

# Clean up response
ideas_raw = ideas_raw.strip()
if ideas_raw.startswith("```"):
    ideas_raw = ideas_raw.split("```")[1]
    if ideas_raw.startswith("json"):
        ideas_raw = ideas_raw[4:]
ideas_raw = ideas_raw.strip()

app_ideas = json.loads(ideas_raw)
print(f"Got {len(app_ideas)} app ideas")

for i, app in enumerate(app_ideas):
    app_name = app["name"].replace(" ", "")
    app_dir = f"{OUTPUT_DIR}/{app_name}"
    os.makedirs(app_dir, exist_ok=True)

    print(f"Generating code for: {app['name']}")

    code_prompt = f"""Write a complete Flutter main.dart file for a simple app called "{app['name']}".
Description: {app["description"]}
Requirements:
- Single file, complete working Flutter app
- Simple clean UI with Material Design
- Basic functionality only
Return ONLY the Dart code, no explanation."""

    dart_code = call_groq(code_prompt)
    
    # Clean code block markers
    if "```dart" in dart_code:
        dart_code = dart_code.split("```dart")[1].split("```")[0]
    elif "```" in dart_code:
        dart_code = dart_code.split("```")[1].split("```")[0]

    with open(f"{app_dir}/main.dart", "w") as f:
        f.write(dart_code.strip())

    listing_prompt = f"""Write a Google Play Store listing for a Flutter app called "{app['name']}".
Description: {app["description"]}
Return a JSON object with: title, short_description, full_description, keywords (array)
ONLY JSON, no extra text."""

    listing_raw = call_groq(listing_prompt)
    listing_raw = listing_raw.strip()
    if listing_raw.startswith("```"):
        listing_raw = listing_raw.split("```")[1]
        if listing_raw.startswith("json"):
            listing_raw = listing_raw[4:]
    listing_raw = listing_raw.strip()

    try:
        listing = json.loads(listing_raw)
    except:
        listing = {"title": app["name"], "short_description": app["description"], "full_description": app["description"], "keywords": []}

    with open(f"{app_dir}/play_store_listing.json", "w") as f:
        json.dump(listing, f, indent=2, ensure_ascii=False)

    with open(f"{app_dir}/README.md", "w") as f:
        f.write(f"# {app['name']}\n\n")
        f.write(f"**Category:** {app['category']}\n\n")
        f.write(f"**Description:** {app['description']}\n\n")
        f.write(f"## Files\n- `main.dart` - Flutter source code\n- `play_store_listing.json` - Play Store metadata\n")

    print(f"✅ {app['name']} generated")

print(f"\n✅ All apps generated in {OUTPUT_DIR}/")
