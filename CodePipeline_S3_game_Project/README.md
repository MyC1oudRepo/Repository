# Continuous Deployment using AWS Code Pipeline and S3

We'll deploy a simple memory matching game. The user clicks two cards and trys to match them. If there's a match, the cards disappear from the board. If there's no match, the cards are flipped back to their blank side so the user can try again.

The code for the game is hosted in GitHub. We'll create an S3 bucket for static website hosting, then create a continuous deployment pipeline (using AWS Code Pipeline) to automatically deploy the code whenever changes are made. The game consists of HTML, CSS and JavaScript and the code will be deployed and hosted in S3.

The pipeline is created using AWS Code Pipeline. The pipeline pulls the code from GitHub, and deploys it to S3 whenever a change is detected in the code.

Create an S3 bucket. I will call it card-game.myclouddomain.net since I want to point muy personal domain to the S3 endpoint.

![image](https://github.com/MyC1oudRepo/Repository/assets/151183434/42c82761-5592-46a5-97cf-8da62280bc31)

