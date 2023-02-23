# realtime_chat_app

A flutter project showcasing the power of websockets in a form of a chat application.

## Screenshots

<span>
  <img src="https://user-images.githubusercontent.com/68814603/220502854-56320274-4876-40f2-ac0f-d15439117873.jpg"  width="250" height="500">
  <img src="https://user-images.githubusercontent.com/68814603/220503190-c4a40477-7bad-471d-ab6d-f3ba1b321d61.jpg"  width="250" height="500">
  <img src="https://user-images.githubusercontent.com/68814603/220503325-819fd9a9-79aa-4fc9-8ac3-d0031d302916.jpg"  width="250" height="500">
  <img src="https://user-images.githubusercontent.com/68814603/220503445-5c0aa29b-c39e-4db5-b340-c8a6439b2410.jpg"  width="250" height="500">
</span>

## Instructions on how to test the app
- Clone the repository realtime-chat-app and realtime-chat-api
- Create a .env file on the flutter app root directory like the example below
<img src="https://user-images.githubusercontent.com/68814603/220503735-6ad92b66-c22f-4a19-9bdc-72795c6dc762.png"  width="250" height="500">
- On the .env file, create an API value and include the API path with the port from the realtime-chat-api (ex. API = localhost:3000)
- Run the app

### Notes
- localhost does not work for android emulators and a physical android phone so turn on the network sharing on your laptop/pc that runs the server (you can search on how to turn it on) then get the Wi-Fi Ipv4 address by going on the command prompt and type "ipconfig" and locate the Ipv4 address on the Wireless LAN adapter Wi-Fi of the command result.
- I am still working on improving some logic :smiley:
- Feel free to give suggestions on how can i improve the UI
