import os
import json
import datetime
from groq import Groq

client = Groq(api_key=os.environ.get("GROQ_API_KEY"))

def generate_app_ideas():
    response = client.chat.completions.create(
        model="llama3-8b-8192",
        messages=[{
            "role": "user",
            "content": """Generate 5 simple Android app ideas with Flutter code. 
            For each app provide:
            1. App name
            2. Short description (1 sentence)
            3. Basic Flutter main.dart code
            4. Google Play Store listing (title, short description, full description)
            
            Format as JSON array with fields: name, description, flutter_code, play_store_listing
            Only return valid JSON, no other text."""
        }],
        max_tokens=4000
    )
    return response.choices[0].message.content

def save_apps(apps_json):
    today = datetime.date.today().strftime("%Y-%m-%d")
    output_dir = f"generated_apps/{today}"
    os.makedirs(output_dir, exist_ok=True)
    
    try:
        apps = json.loads(apps_json)
    except json.JSONDecodeError:
        import re
        match = re.search(r'\[.*\]', apps_json, re.DOTALL)
        if match:
            apps = json.loads(match.group())
        else:
            print("Could not parse JSON response")
            print(apps_json)
            return

    for i, app in enumerate(apps):
        app_dir = f"{output_dir}/app_{i+1}_{app.get('name','unknown').replace(' ','_')}"
        os.makedirs(app_dir, exist_ok=True)
        
        with open(f"{app_dir}/main.dart", "w") as f:
            f.write(app.get("flutter_code", "// No code generated"))
        
        with open(f"{app_dir}/play_store.txt", "w") as f:
            listing = app.get("play_store_listing", {})
            f.write(f"Title: {listing.get('title', app.get('name',''))}\n\n")
            f.write(f"Short Description:\n{listing.get('short_description', '')}\n\n")
            f.write(f"Full Description:\n{listing.get('full_description', '')}\n")
        
        with open(f"{app_dir}/info.json", "w") as f:
            json.dump(app, f, indent=2, ensure_ascii=False)
        
        print(f"✅ App {i+1}: {app.get('name')} saved to {app_dir}")

if __name__ == "__main__":
    print("🚀 Generating app ideas with Groq AI...")
    result = generate_app_ideas()
    print("💾 Saving apps...")
    save_apps(result)
    print("✅ Done!")
