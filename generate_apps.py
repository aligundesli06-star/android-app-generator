import os
import json
import datetime
from groq import Groq

client = Groq(api_key=os.environ.get("GROQ_API_KEY"))

def generate_app_ideas():
    prompt = """Generate 5 simple Flutter app ideas for Google Play Store. 
For each app provide:
- App name
- Short description (1 sentence)
- Key features (3 bullet points)
- Target audience

Format as JSON array like this:
[
  {
    "name": "App Name",
    "description": "Short description",
    "features": ["feature1", "feature2", "feature3"],
    "audience": "Target audience"
  }
]

Only return the JSON array, nothing else."""

    response = client.chat.completions.create(
        model="llama3-8b-8192",
        messages=[{"role": "user", "content": prompt}],
        max_tokens=2000,
        temperature=0.8
    )
    
    text = response.choices[0].message.content.strip()
    
    if "```json" in text:
        text = text.split("```json")[1].split("```")[0].strip()
    elif "```" in text:
        text = text.split("```")[1].split("```")[0].strip()
    
    apps = json.loads(text)
    return apps

def save_results(apps):
    today = datetime.date.today().strftime("%Y-%m-%d")
    folder = f"generated_apps/{today}"
    os.makedirs(folder, exist_ok=True)
    
    output_path = f"{folder}/app_ideas.json"
    with open(output_path, "w", encoding="utf-8") as f:
        json.dump(apps, f, indent=2, ensure_ascii=False)
    
    md_path = f"{folder}/app_ideas.md"
    with open(md_path, "w", encoding="utf-8") as f:
        f.write(f"# Flutter App Ideas - {today}\n\n")
        for i, app in enumerate(apps, 1):
            f.write(f"## {i}. {app['name']}\n")
            f.write(f"**Description:** {app['description']}\n\n")
            f.write(f"**Target Audience:** {app['audience']}\n\n")
            f.write("**Features:**\n")
            for feature in app['features']:
                f.write(f"- {feature}\n")
            f.write("\n---\n\n")
    
    print(f"✅ Saved {len(apps)} app ideas to {folder}/")
    return folder

def main():
    print("🚀 Generating Flutter app ideas with Groq AI...")
    
    try:
        apps = generate_app_ideas()
        print(f"✅ Generated {len(apps)} app ideas!")
        folder = save_results(apps)
