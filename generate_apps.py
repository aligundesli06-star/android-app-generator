import os
import json
from datetime import datetime
from groq import Groq

client = Groq(api_key=os.environ.get("GROQ_API_KEY"))

def clean_code(content):
    content = content.strip()
    if content.startswith("```"):
        lines = content.split("\n")
        lines = lines[1:]
        while lines and lines[-1].strip() == "```":
            lines = lines[:-1]
        content = "\n".join(lines)
    return content.strip()

def generate_app_ideas():
    response = client.chat.completions.create(
        model="llama-3.3-70b-versatile",
        messages=[{"role": "user", "content": """Generate 5 simple Android app ideas that can be built with Flutter.
For each app provide:
1. App name
2. Short description (1-2 sentences)
3. Main features (3-5 bullet points)
4. Target audience
Format as JSON array with keys: name, description, features, target_audience.
Only return valid JSON, no extra text."""}],
        max_tokens=2000
    )
    return clean_code(response.choices[0].message.content)

def generate_flutter_code(app_name, description):
    response = client.chat.completions.create(
        model="llama-3.3-70b-versatile",
        messages=[{"role": "user", "content": f"""Write a beautiful, modern Flutter app for: {app_name}
Description: {description}
Requirements:
- Material 3 design (useMaterial3: true)
- Beautiful color scheme with ColorScheme.fromSeed()
- Custom AppBar with accent color
- Cards with rounded corners (BorderRadius.circular(16)) and shadows
- Proper padding (16px) and spacing throughout
- FloatingActionButton with icon
- Empty state message when no data
- Use Icons from Material icons
- Professional UI that looks like a real app
- Complete working functionality
Only return the Dart code, no markdown, no explanation."""}],
        max_tokens=2000
    )
    return clean_code(response.choices[0].message.content)

def generate_play_store_listing(app_name, description):
    response = client.chat.completions.create(
        model="llama-3.3-70b-versatile",
        messages=[{"role": "user", "content": f"""Write a Google Play Store listing for:
App: {app_name}
Description: {description}
Include:
- Short description (80 chars max)
- Full description (4000 chars max)
- 5 keywords
Format as JSON with keys: short_description, full_description, keywords.
Only return valid JSON."""}],
        max_tokens=1000
    )
    return clean_code(response.choices[0].message.content)

def main():
    today = datetime.now().strftime("%Y-%m-%d")
    output_dir = f"generated_apps/{today}"
    os.makedirs(output_dir, exist_ok=True)

    print("Generating app ideas...")
    ideas_raw = generate_app_ideas()
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
