export PATH="/opt/homebrew/opt/cyrus-sasl/sbin:$PATH"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/Users/ezamanian/bin:$PATH"
export PATH="/opt/homebrew/opt/cyrus-sasl/sbin:$PATH"
export PATH="/opt/homebrew/Cellar/clang-format/16.0.0/bin/:$PATH"

# set ebay java as the default 
export JAVA_HOME=/Users/ezamanian/code/jdk/zulu-8.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"

# set maven path
export M2_HOME="/Users/ezamanian/code/apache-maven-3.3.9"
PATH="${M2_HOME}/bin:${PATH}"
# Setting Python Requests Extra CA Path
export REQUESTS_CA_BUNDLE="/Library/Application Support/Netskope/STAgent/download/nscacert_combined.pem"
# Setting NodeJS Extra CA Path
export NODE_EXTRA_CA_CERTS="/Library/Application Support/Netskope/STAgent/download/nscacert_combined.pem"
export PATH="/opt/homebrew/opt/conan@1/bin:$PATH"

alias dellremote='ssh ezamanian@10.254.42.34'
alias gaf='f(){ git add $1; git-clang-format $1; git add $1; }; f'

#-- Docker Commands --------------------------

docker_bash() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: docker_bash CONTAINER"
		echo 
        return 1
    fi

    local CONTAINER="$1"
	docker exec -it "$CONTAINER" /bin/bash
}
#---------------------------------------------


#-- TESS Commands ----------------------------
alias tl='f(){ tess login -c "$@"; export TESS_CONTEXT="$@"; unset -f f; }; f'
alias tc='f(){ export TESS_CONTEXT="$@"; tess kubectl config use-context "$@"; unset -f f; }; f'
alias tk='tess kubectl --context=$TESS_CONTEXT -n $TESS_NAMESPACE '
alias tenv='echo "Cluster:" $TESS_CONTEXT; echo "Namespace:" $TESS_NAMESPACE'
alias kn='f(){ tess kubectl config set-context --current --namespace="$@"; export TESS_NAMESPACE="$@"; unset -f f; }; f'
alias kbash='f(){ tess kubectl --context=$TESS_CONTEXT -n $TESS_NAMESPACE exec "$1" -c "$2" -it -- /bin/bash; unset -f f; }; f'
alias krestart='f(){ tess kubectl --context=$TESS_CONTEXT -n $TESS_NAMESPACE exec "$1" -c "$2" -it -- kill 1; unset -f f; }; f'
alias krun='f(){ tess kubectl --context=$TESS_CONTEXT -n $TESS_NAMESPACE exec -it "$1" -c "$2" "$3"; unset -f f; }; f'
alias kget='f(){ tess kubectl --context=$TESS_CONTEXT -n $TESS_NAMESPACE get "$@"; unset -f f; }; f'
alias kgetpod='f(){ tess kubectl --context=$TESS_CONTEXT -n $TESS_NAMESPACE get pod "$1"; unset -f f; }; f'
alias kdesc='f(){ tess kubectl --context=$TESS_CONTEXT -n $TESS_NAMESPACE describe "$@"; unset -f f; }; f'
alias kdescpod='f(){ tess kubectl --context=$TESS_CONTEXT -n $TESS_NAMESPACE describe pod "$1"; unset -f f; }; f'
alias kedit='f(){ tess kubectl --context=$TESS_CONTEXT -n $TESS_NAMESPACE edit; unset -f f; }; f'
alias kdelete='f(){ tess kubectl --context=$TESS_CONTEXT -n $TESS_NAMESPACE delete; unset -f f; }; f'
alias kapply='f(){ tess kubectl --context=$TESS_CONTEXT -n $TESS_NAMESPACE apply -f; unset -f f; }; f'
alias kl='f(){ tess kubectl --context=$TESS_CONTEXT -n $TESS_NAMESPACE logs pod/"$1" "$2"; unset -f f; }; f'
alias klog='f(){ tess kubectl --context=$TESS_CONTEXT -n $TESS_NAMESPACE logs pod/"$1" "$2"; unset -f f; }; f'
alias kcopy='f(){ tess kubectl cp $TESS_NAMESPACE/$1:$3 . -c $2; unset -f f; }; f'


tess_translate_environment() {
	if [[ $# -ne 1 ]]; then
		echo "Usage: tess_translate_environment ENVIRONMENT"
		echo "Available values for ENVIRONMENT:"
		echo "	qa"
		echo "	qadev"
		echo "	qadev-bk"
		echo "	staging"
		echo "	lnp"
		echo "	feature"
		echo "	internal"
		echo "	preprod"
		echo "	preprod2"
		echo "	preprod4"
		echo "	sandbox"
		echo "	prod"
		echo "	rnpci"
		echo "	experiment"
		return 1
	fi
	
	local ENV="$1"
	err=0
	
	case "$ENV" in
		"qa")
			link="go/monstorqa"
			name="qadev"
			dcp="QA"
			cpit="staging"
			coord_cos="Default"
			strg_img_tag="qa"
			tess_clusters=(130 140)
			tess_ns="coordinator-staging1"
			galera_img="staging"
			enable_tess_grp=1
			;;
		"qadev")
			link="go/monstorqadev"
			name="qadev"
			dcp="QA"
			cpit="qa"
			coord_cos="Default"
			strg_img_tag="qa"
			tess_clusters=(130 140)
			tess_ns="coordinator-staging2"
			galera_img="qa"
			enable_tess_grp=1
			;;
		"qadev-bk")
			link="go/monstordev"
			name="qadev"
			dcp="QA"
			cpit="qa"
			coord_cos="Default"
			strg_img_tag="qa"
			tess_clusters=(130 140)
			tess_ns="monstor-qadev"
			galera_img="qa"
			enable_tess_grp=0
			;;
		"staging")
			link="go/monstorstaging"
			name="staging"
			dcp="Staging"
			cpit="staging"
			coord_cos="Staging"
			strg_img_tag="staging"
			tess_clusters=(130 140)
			tess_ns="monstor"
			galera_img="staging"
			enable_tess_grp=1
			;;
		"lnp")
			link="go/monstorlnp"
			name="LnP"
			dcp="LnP"
			cpit="lnp"
			coord_cos="LnP"
			strg_img_tag="lnp"
			tess_clusters=(130 140)
			tess_ns="monstorlnp"
			galera_img="lnp"
			enable_tess_grp=0
			;;
		"feature")
			link="go/monstorfeature"
			name="feature"
			dcp="Feature"
			cpit="features"
			coord_cos="Default"
			strg_img_tag="feature"
			tess_clusters=(130 140)
			tess_ns="monstor-features"
			galera_img="features"
			enable_tess_grp=0
			;;
		"internal")
			link="go/monstor-internal"
			name="internal"
			dcp="PreProduction"
			cpit="internal"
			coord_cos="PreProduction"
			strg_img_tag="preprod"
			tess_clusters=(22 23 25 26 27 37 38 40 45)
			tess_ns="monstor-internal"
			galera_img="preprod"
			enable_tess_grp=0
			;;
		"preprod")
			link="go/monstor-preprod"
			name="preprod"
			dcp="PreProduction"
			cpit="internal"
			coord_cos="PreProduction"
			strg_img_tag="preprod"
			tess_clusters=(22 23 25 26 27 37 40 45)
			tess_ns="monstor-preprod"
			galera_img="preprod"
			enable_tess_grp=0
			;;
		"preprod2")
			link="go/monstorprod2"
			name="preprod2"
			dcp="PreProduction"
			cpit="monstor2"
			coord_cos="PreProduction"
			strg_img_tag="preprod"
			tess_clusters=(22 23 25 26 27 37 40 45)
			tess_ns="monstor2"
			galera_img="preprod"
			enable_tess_grp=0
			;;
		"preprod4")
			link="go/monstorprod4"
			name="preprod4"
			dcp="PreProduction"
			cpit="monstor4"
			coord_cos="PreProduction"
			strg_img_tag="preprod"
			tess_clusters=(22 23 25 26 27 37 40 45)
			tess_ns="monstor4"
			galera_img="preprod"
			enable_tess_grp=0
			;;
		"sandbox")
			link="go/monstor-sandbox"
			name="sandbox"
			dcp="sandbox"
			cpit="sandbox"
			coord_cos="Production"
			strg_img_tag="prod"
			tess_clusters=(22 23 25 26 27 37 40 45)
			tess_ns="monstor-sandbox"
			galera_img="sandbox"
			enable_tess_grp=1
			;;
		"prod")
			link="go/monstorprod"
			name="prod"
			dcp="Production"
			cpit="prod"
			coord_cos="Production"
			strg_img_tag="prod"
			tess_clusters=(22 23 26 27 37 38 40 45)
			tess_ns="monstor"
			galera_img="prod"
			enable_tess_grp=1
			;;
		"rnpci")
			link="go/monstor-rnpci"
			name="rnpci"
			dcp="Production"
			cpit="rnpci"
			coord_cos="Production"
			strg_img_tag="rnpci"
			tess_clusters=(41 42 43)
			tess_ns="monstor-rnpci"
			galera_img="rnpci"
			enable_tess_grp=0
			;;
		"experiment")
			link="go/monstor-exp"
			name="experiment"
			dcp="experiment"
			cpit="monstor-exp"
			coord_cos="Experiment"
			strg_img_tag="experiment"
			tess_clusters=(11 12)
			tess_ns="monstor-exp"
			galera_img=""
			enable_tess_grp=0
			;;
		*)
			err=1
			;;
	esac
		
	if [ "$err" -eq 1 ]; then
		echo "Error: The chosen environment does not exist"
		return 1
	fi
	
	
	echo "Link: ${link}"
	echo "Name: ${name}"
	echo "Deployer Coordinator Profile: ${dcp}"
	echo "Control Plane Image Tags: ${cpit}"
	echo "Coordinator COS: ${coord_cos}"
	echo "Storage Image Tags: ${strg_img_tag}"
	echo "Tess Clusters: ${tess_clusters}"
	echo "Tess Namespace: ${tess_ns}"
	echo "Galera Agent Image: ${galera_img}"
	echo "Enable Tess Group: ${enable_tess_grp}"
	return 0
}
#---------------------------------------------
