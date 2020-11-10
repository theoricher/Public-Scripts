#! /bin/sh

#######################################
#  This script allows you to receive  #
#	centeron alerts on Telegram.      #
#                V1.0                 #
#         Author : RICHER Théo        #
#######################################


#############################
#          Config           #
#############################

# Telegram chat ID
chat_id=""
# Telegram bot token
token=""

#############################
#           Scripts         #
#############################

# Function to send Telegram Message
telegram_send() {
        curl -s -X POST https://api.telegram.org/bot$token/sendMessage -d text="$1" -d chat_id=$chat_id >> /dev/null
}

# Notify type "host" or "service"
notify_type=$1
# State UP or DOWN
state=$2
# Name of notify Exemple : $HOSTNAME$
name=$3
# Desc of service Exemple : $SERVICEDESC$
desc=$4
# More details Exemple : $SERVICEOUTPUT$
output=$5

# If notify is for a host
if [ "$notify_type" == "host" ];
then
	# If state UP
	if [ "$state" == "UP" ];
	then
		telegram_send "✅ The host $name ($desc) is in status $state "$'\n'" More details : $output"
	# If state DOWN
	elif [ "$state" == "DOWN" ];
	then
		telegram_send "🚨 The host $name ($desc) is in status $state "$'\n'" More details : $output"
	# If state is other
	else
		telegram_send "The host $name ($desc) is in status $state "$'\n'" More details : $output"
	fi
# If notify is for a service
elif [ "$notify_type" == "service" ];
then
	# If state OK
	if [ "$state" == "OK" ];
	then
		telegram_send "✅ The service $name ($desc) is in status $state "$'\n'" More details : $output"
	# If state WARNING
	elif [ "$state" == "WARNING" ];
	then
		telegram_send "⚠ The service $name ($desc) is in status $state "$'\n'" More details : $output"
	# If state UNKNOWN
	elif [ "$state" == "UNKNOWN" ];
	then
		telegram_send "❓ The service $name ($desc) is in status $state "$'\n'" More details : $output"
	# If state CRITICAL
	elif [ "$state" == "CRITICAL" ];
	then
		telegram_send "🚨 The service $name ($desc) is in status $state "$'\n'" More details : $output"
	# If state is other
	else
		telegram_send "The service $name ($desc) is in status $state "$'\n'" More details : $output"
	fi
fi