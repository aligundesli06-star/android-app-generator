import os
import requests
import json
from datetime import date

GROQ_API_KEY = os.environ.get("GROQ_API_KEY")

def ask_groq(prompt):
    headers = {
        "Authorization": f"Bearer {GROQ_API_KEY}",
        "Content-Type": "application/json"
    }
    data = {
        "model": "llama3-8b-8192",
        "messages": [{"role": "user", "content": prompt}],
        "max_tokens": 4000
    }
    response = requests.post("https://api.groq.com/openai/v1/chat/completions", headers=headers, json=data)
    return response.json()["choices"][0]["message"]["content"]

def generate_app_ideas():
    prompt = """Generate 5 unique Android utility app ideas. Each should be simple, useful and monetizable with ads.
    Return ONLY a JSON array like this:
    [
        {"name": "AppName", "description": "what it does", "category": "calculator/converter/health/finance"},
        ...
    ]
    Focus on: calculators, converters, finance tools, health tools. No existing popular apps."""
    
    result = ask_groq(prompt)
    result = result.replace("```json", "").replace("```", "").strip()
    return json.loads(result)

def generate_flutter_app(app_idea):
    prompt = f"""Create a complete Flutter app for: {app_idea['name']} - {app_idea['description']}
    
    Generate the main.dart file with:
    - Clean minimal UI
    - Dark mode support  
    - AdMob banner placeholder
    - Simple input/output fields
    - Complete working code
    
    Return ONLY the dart code, no explanations."""
    
    return ask_groq(prompt)

def generate_store_listing(app_idea):
    prompt = f"""Create Google Play Store listing for: {app_idea['name']} - {app_idea['description']}
    
    Return JSON with:
    {{
        "title": "app title max 30 chars",
        "short_description": "max 80 chars",
        "full_description": "max 4000 chars",
        "keywords": ["keyword1", "keyword2", ...]
    }}
    Return ONLY JSON."""
    
    result = ask_groq(prompt)
    result = result.replace("```json", "").replace("```", "").strip()
    return json.loads(result)

today = str(date.today())
output_dir = f"generated_apps/{today}"
os.makedirs(output_dir, exist_ok=True)

print("Uygulama fikirleri üretiliyor...")
ideas = generate_app_ideas()
print(f"{len(ideas)} fikir üretildi")

for i, idea in enumerate(ideas):
    print(f"\nUygulama {i+1}: {idea['name']}")
    
    app_dir = f"{output_dir}/{idea['name'].replace(' ', '_')}"
    os.makedirs(app_dir, exist_ok=True)
    
    # Flutter kodu üret
    print(f"  Flutter kodu üretiliyor...")
    flutter_code = generate_flutter_app(idea)
    with open(f"{app_dir}/main.dart", "w") as f:
        f.write(flutter_code)
    
    # Store listing üret
    print(f"  Store listing üretiliyor...")
    try:
        store_listing = generate_store_listing(idea)
        with open(f"{app_dir}/store_listing.json", "w") as f:
            json.dump(store_listing, f, indent=2, ensure_ascii=False)
    except:
        with open(f"{app_dir}/store_listing.json", "w") as f:
            json.dump({"title": idea['name'], "description": idea['description']}, f)
    
    # App info kaydet
    with open(f"{app_dir}/app_info.json", "w") as f:
        json.dump(idea, f, indent=2, ensure_ascii=False)
    
    print(f"  ✓ {idea['name']} tamamlandı")

print(f"\nTüm uygulamalar {output_dir} klasörüne kaydedildi!")
