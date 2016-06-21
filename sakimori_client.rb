require 'aws-sdk-core'
require 'pp'


@client_keyword = ARGV[0]
@queue_url = ARGV[1]
@image_folder = ARGV[2]
@image_server_url = ARGV[3]
@image_url_queue = ARGV[4]

def capture_and_send()
  filename = Time.now.strftime('%Y%m%d%H%M%S') + '.jpg'
  filepath = @image_folder + filename

  system("imagesnap -q -w 1.5 #{filepath}")

  #TODO send image_file_path

  #TODO return imageURL
end

sqs = Aws::SQS::Client.new(region: 'us-east-1')

while true do
  msg = sqs.receive_message({
    queue_url: @queue_url,
    max_number_of_messages: 1
  })
  if msg.messages[0] &&  msg.messages[0].body.start_with?(@client_keyword)
    puts msg.messages[0].body

    image_url = capture_and_send()

    #TODO
    #SQS send_imageurl

    sqs.delete_message({
      queue_url: @queue_url,
      receipt_handle: msg.messages[0].receipt_handle
    })
  end
  sleep 3
end




