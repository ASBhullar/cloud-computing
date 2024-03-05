import requests
import time

# Your chatbot's endpoint
CHATBOT_URL = "http://192.168.64.2:8080/function/chatbot"

def measure_response_time(data, repeat=1):
    """Measure the response time for a single request or the average over multiple requests."""
    total_time = 0
    for _ in range(repeat):
        start_time = time.time()
        response = requests.post(CHATBOT_URL, data=data)
        end_time = time.time()
        total_time += (end_time - start_time)
        if repeat == 1:  # If only one request, return its time directly
            return end_time - start_time
    return total_time / repeat  # Return average time if multiple requests

def main():
    # Measure response times according to the given scenarios
    # a. For the first request that does not call figlet
    response_time_a = measure_response_time("What is your name?")
    print(f"a. Response time for the first request (no figlet): {response_time_a:.4f} seconds")

    # b. For the second request that does not call figlet
    response_time_b = measure_response_time("What is your name?")
    print(f"b. Response time for the second request (no figlet): {response_time_b:.4f} seconds")

    # c. Average over 10 requests that do not call figlet
    average_response_time_c = measure_response_time("What is your name?", repeat=10)
    print(f"c. Average response time over 10 requests (no figlet): {average_response_time_c:.4f} seconds")

    # d. For the first request that calls figlet
    response_time_d = measure_response_time("Generate a figlet for Hello")
    print(f"d. Response time for the first request (with figlet): {response_time_d:.4f} seconds")

    # e. For the second request that calls figlet
    response_time_e = measure_response_time("Generate a figlet for Hello")
    print(f"e. Response time for the second request (with figlet): {response_time_e:.4f} seconds")

    # f. For the second request that calls figlet following the first request that does not call figlet
    # Measure the first request (no figlet)
    measure_response_time("What is your name?")
    # Measure the second request (with figlet)
    response_time_f = measure_response_time("Generate a figlet for Hello")
    print(f"f. Response time for the second request (with figlet, after no figlet): {response_time_f:.4f} seconds")

    # g. Average over 10 requests that do call figlet
    average_response_time_g = measure_response_time("Generate a figlet for Hello", repeat=10)
    print(f"g. Average response time over 10 requests (with figlet): {average_response_time_g:.4f} seconds")

if __name__ == "__main__":
    main()
