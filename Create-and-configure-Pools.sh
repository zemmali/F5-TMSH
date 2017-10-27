#!/bin/bash

echo "############################# Create and configure Pools ############################################"
echo "#####################################################################################################"
echo "Delete pool"
tmsh delete ltm pool P1-HTTP

echo "Create Poll with 2 membres and load-balancing method defaut"
tmsh create ltm pool P1-HTTP monitor "gateway_icmp" members add { N1-HTTP:80  N2-HTTP:80 }

echo "Delete pool member"
tmsh modify ltm pool P1-HTTP members del { N1-HTTP:80 }

echo "Add pool member"
tmsh modify ltm pool P1-HTTP members add { N1-HTTP:80 } 

echo "Modification du monitor et methàde de load-balancing ajout de node" 
tmsh create ltm pool P2-HTTP monitor "gateway_icmp" members add { N1-HTTP:80 {priority-group 2} } load-balancing-mode least-connections-member observed-member min-active-members 1

#------------------			load-balancing-mode	---------------------------------------
#	dynamic-ratio-member | observed-node	|	dynamic-ratio-node	|	predictive-member	|	fastest-app-response	|	predictive-node
#	fastest-node		 |	ratio-member	|	least-connections-member	|	ratio-node	|	least-connections-node	|	round-robin
#	least-sessions	|	weighted-least-connections-member	|	observed-member	|	weighted-least-connections-node
