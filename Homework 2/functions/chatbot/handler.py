import datetime
import requests
import sys

def handle(req):
    """Process incoming requests based on the input text"""
    if "name" in req.lower() or "what is your name" in req.lower():
        responses = [
            "My name is Coen241.",
            "I'm called Coen241.",
            "You can call me COEN241."
        ]
        return "\n".join(responses)
    elif "current time" in req.lower() or "current date" in req.lower():
        now = datetime.datetime.now()
        responses = [
            now.strftime("The current time is %H:%M on %B %d, %Y."),
            now.strftime("It's now %H:%M on %d/%m/%Y."),
            now.strftime("Today is %B %d, %Y, and the time is %H:%M.")
        ]
        return "\n".join(responses)
    elif req.lower().startswith("generate a figlet for"):
        text = req[len("generate a figlet for"):].strip()
        # Call the figlet function
        figlet_url = 'http://192.168.64.2:8080/function/figlet'
        response = requests.post(figlet_url, data=text)
        if response.status_code == 200:
            return response.text
        else:
            return "There was an error generating the figlet: " + response.text
    else:
        return "I'm not sure how to process that request."

if __name__ == "__main__":
    req = sys.argv[1] if len(sys.argv) > 1 else ""
    print(handle(req))
