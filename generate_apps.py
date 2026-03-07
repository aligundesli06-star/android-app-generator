import os
import json
from datetime import datetime
from groq import Groq

client = Groq(api_key=os.environ.get("GROQ_API_KEY"))

def generate_app_ideas():
    response = client.chat.completions.create(
        model="llama-3.3-70b-versatile",
        messages=[
            {
                "role": "user",
                "content": """Generate 5 simple Android app ideas that can be built with Flutter.
For each app provide:
1. App name
2. Short description (1-2 sentences)
3. Main features (3-5 bullet points)
4. Target audience

Format as JSON array with keys: name, description, features, target_audience.
Only return valid JSON, no extra text."""
            }
        ],
        max_tokens=2000
    )
    code = response.choices[0].message.content.strip()
if code.startswith("```"):
    code = code.split("```")[1]
    if code.startswith("dart"):
        code = code[4:]
    code = code.strip()
if code.endswith("```"):
    code = code[:-3].strip()
return code

def generate_flutter_code(app_name, description):
    response = client.chat.completions.create(
        model="llama-3.3-70b-versatile",
        messages=[
            {
                "role": "user",
                "content": f"""Write a beautiful, modern Flutter app for: {app_name}
Description: {description}
Requirements:
- Material 3 design with a beautiful color scheme
- Custom AppBar with gradient or solid accent color
- Cards with rounded corners and shadows
- Proper padding and spacing throughout
- At least one FloatingActionButton with icon
- Empty state message when no data
- Smooth and polished UI that looks professional
- Use Colors from Material design palette (not just blue)
- Add icons from Icons class to make it visual
- Complete working functionality
Only return the Dart code, no explanation, no markdown."""
            }
        ],
        max_tokens=2000
    )
    return response.choices[0].message.content

def generate_play_store_listing(app_name, description):
    response = client.chat.completions.create(
        model="llama-3.3-70b-versatile",
        messages=[
            {
                "role": "user",
                "content": f"""Write a Google Play Store listing for:
App: {app_name}
Description: {description}

Include:
- Short description (80 chars max)
- Full description (4000 chars max)
- 5 keywords

Format as JSON with keys: short_description, full_description, keywords.
Only return valid JSON."""
            }
        ],
        max_tokens=1000
    )
    return response.choices[0].message.content

def main():
    today = datetime.now().strftime("%Y-%m-%d")
    output_dir = f"generated_apps/{today}"
    os.makedirs(output_dir, exist_ok=True)

    print("Generating app ideas...")
    ideas_raw = generate_app_ideas()
    
    ideas_raw = ideas_raw.strip()
    if ideas_raw.startswith("```"):
        ideas_raw = ideas_raw.split("```")[1]
        if ideas_raw.startswith("json"):
            ideas_raw = ideas_raw[4:]
    ideas_raw = ideas_raw.strip()

    ideas = json.loads(ideas_raw)
    print(f"Generated {len(ideas)} app ideas")

    for i, app in enumerate(ideas):
        app_name = app["name"]
        description = app["description"]
        print(f"Processing app {i+1}: {app_name}")

        app_dir = f"{output_dir}/app_{i+1}_{app_name.replace(' ', '_')}"
        os.makedirs(app_dir, exist_ok=True)

        with open(f"{app_dir}/app_info.json", "w") as f:
            json.dump(app, f, indent=2)

        flutter_code = generate_flutter_code(app_name, description)
        with open(f"{app_dir}/main.dart", "w") as f:
            f.write(flutter_code)

        listing_raw = generate_play_store_listing(app_name, description)
        listing_raw = listing_raw.strip()
        if listing_raw.startswith("```"):
            listing_raw = listing_raw.split("```")[1]
            if listing_raw.startswith("json"):
                listing_raw = listing_raw[4:]
        listing_raw = listing_raw.strip()
        
        try:
            listing = json.loads(listing_raw)
            with open(f"{app_dir}/play_store_listing.json", "w") as f:
                json.dump(listing, f, indent=2)
        except:
            with open(f"{app_dir}/play_store_listing.txt", "w") as f:
                f.write(listing_raw)

        print(f"  Saved to {app_dir}")

    print(f"\nDone! All apps saved to {output_dir}")

if __name__ == "__main__":
    main()
