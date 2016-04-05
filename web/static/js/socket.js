// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

// Now that you are connected, you can join channels with a topic:
let roomId = $("#room-id").text()
let channel = socket.channel("rooms:" + roomId, {})
let teamAScore = $("#team-a-score")
let teamBScore = $("#team-b-score")

channel.on("team_a_score", payload => {
  console.log("a")
  console.log(payload)
  teamAScore.text(`${payload.body}`)
  teamAScore.change()
})
channel.on("team_b_score", payload => {
  console.log("b")
  console.log(payload)
  teamBScore.text(`${payload.body}`)
  teamBScore.change()
})
console.log("room id: ", roomId)
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
