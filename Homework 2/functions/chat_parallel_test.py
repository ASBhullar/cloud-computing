import concurrent.futures
import requests
import time

# Your chatbot's endpoint
CHATBOT_URL = "http://192.168.64.2:8080/function/chatbot"

def send_request(data):
    """Function to send a single request to the chatbot."""
    try:
        response = requests.post(CHATBOT_URL, data=data)
        return response.status_code
    except Exception as e:
        return str(e)

def fire_requests(requests_per_second, duration_in_seconds=10):
    """Fire requests in parallel aiming for a target rate of requests per second."""
    with concurrent.futures.ThreadPoolExecutor() as executor:
        futures = []
        start_time = time.time()

        while time.time() - start_time < duration_in_seconds:
            for _ in range(requests_per_second):
                # Adjust the request content as needed
                future = executor.submit(send_request, "What is your name?")
                futures.append(future)
            time.sleep(1)  # Wait for a second before firing the next batch of requests

        results = [future.result() for future in futures]

    success_responses = [result for result in results if result == 200]
    print(f"Total requests: {len(results)}")
    print(f"Successful responses: {len(success_responses)}")
    print(f"Success rate: {len(success_responses) / len(results) * 100:.2f}%")

requests_per_second = 20
fire_requests(requests_per_second)
