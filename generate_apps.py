import os
import json
import datetime
from groq import Groq
client = Groq(api_key=os.environ.get("GROQ_API_KEY"))
def generate_app_ideas():
    response = client.chat.completions.create(
        model="llama-3.3-70b-versatile",
        messages=[
            {
                "role": "user",
                "content": """Generate 5 simple Flutter Android app ideas with code. 
For each app return a JSON array with these fields:
- name: app name
- description: short description
- category: category (utility, finance, health, etc)
- main_dart: complete simple Flutter main.dart code
- playstore_title: Play Store title (max 30 chars)
- playstore_description: Play Store description (max 80 chars)
Return ONLY a valid JSON array, no extra text."""
            }
        ],
        max_tokens=4000
    )

    text = response.choices[0].message.content
    text = text.strip()
    if text.startswith(""):
        text = text.split("")[1]
        if text.startswith("json"):
            text = text[4:]
    text = text.strip()

    return json.loads(text)
def save_apps(apps):
    today = datetime.date.today().strftime("%Y-%m-%d")
    folder = f"generated_apps/{today}"
    os.makedirs(folder, exist_ok=True)

    for i, app in enumerate(apps):
        app_folder = f"{folder}/app_{i+1}_{app['name'].replace(' ', '_')}"
        os.makedirs(app_folder, exist_ok=True)

        with open(f"{app_folder}/main.dart", "w") as f:
            f.write(app["main_dart"])

        meta = {
            "name": app["name"],
            "description": app["description"],
            "category": app["category"],
            "playstore_title": app["playstore_title"],
            "playstore_description": app["playstore_description"]
        }
        with open(f"{app_folder}/metadata.json", "w") as f:
            json.dump(meta, f, indent=2, ensure_ascii=False)

        print(f"✅ Saved: {app['name']}")
def main():
    print("🚀 Generating Flutter app ideas with Groq AI...")
    apps = generate_app_ideas()
    print(f"✅ Generated {len(apps)} apps")
    save_apps(apps)
    print("🎉 Done!")
if __name__ == "__main__":
    main()

