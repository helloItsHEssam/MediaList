# Mock

## Description
This section contains all the requirements needed to **simulate** server communication, including the following:

- **"ApiMockResponse"**: This part is responsible for storing the necessary data to be returned from a virtual server to the application during testing.

- **"BadResponseMockURLProtocol"**: This class implements a URLProtocol and is responsible for sending data that the application did not request, causing an error during mapping.

- **"OfflineServerMockURLProtocol"**: This class implements a URLProtocol and simulates the unavailability of the server.

- **"ResponseMockURLProtocol"**: This class implements a URLProtocol and is responsible for sending the correct data, ensuring that requests are not sent to the server during testing.