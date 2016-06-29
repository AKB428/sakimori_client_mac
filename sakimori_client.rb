require 'aws-sdk-core'
require 'pp'

config = open('./config/conf.json') do |io|
  JSON.load(io)
end

@client_keyword = config['client_keyword']
@queue_url = config['queue_url']
@image_folder = config['image_folder']
@image_server_url = config['image_server_url']
@image_url_queue = config['image_url_queue']

def capture_and_send()
  filename = Time.now.strftime('%Y%m%d%H%M%S') + '.jpg'
  filepath = @image_folder + filename

  system("imagesnap -q -w 1.5 #{filepath}")

  #send image_file
  cmd = "curl --upload-file #{filepath} #{@image_server_url}"

  puts cmd
  `#{cmd}`
end

sqs = Aws::SQS::Client.new(region: 'us-east-1')

while true do
  begin
    msg = sqs.receive_message({
                                  queue_url: @queue_url,
                                  max_number_of_messages: 1
                              })
    if msg.messages[0] &&  msg.messages[0].body.start_with?(@client_keyword)
      puts msg.messages[0].body

      image_url = capture_and_send()

      #SQS image_url
      sqs.send_message(
          { queue_url: @image_url_queue, message_body: image_url
          })

      sqs.delete_message({
                             queue_url: @queue_url,
                             receipt_handle: msg.messages[0].receipt_handle
                         })
    end
  rescue Exception => ex
    p ex
    sleep 30;
    sqs = Aws::SQS::Client.new(region: 'us-east-1')
  ensure
    sleep 3
  end
end




