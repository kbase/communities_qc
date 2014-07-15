TARGET ?= /kb/deployment
DEPLOY_RUNTIME ?= /kb/runtime
SERVICE_NAME = communities_qc
DEPLOY_DIR = $(TARGET)/services/$(SERVICE_NAME)
TOP_DIR = ../..

# You can change these if you are putting your tests somewhere
# else or if you are not using the standard .t suffix
CLIENT_TESTS = $(wildcard test/client-tests/*.t)
SERVER_TESTS = $(wildcard test/server-tests/*.t)
SCRIPT_TESTS = $(wildcard test/script-tests/*.t)

include $(TOP_DIR)/tools/Makefile.common

default:
	@echo "nothing to do for default make"


deploy: deploy-client deploy-service


deploy-service:
	-rm -r DRISEE
	git submodule init
	git submodule update
	./install-drisee.sh
	mkdir -p $(DEPLOY_DIR)
	mkdir -p $(DEPLOY_DIR)/doc
	./install-service.sh $(DEPLOY_DIR)
	cp service/start_service $(DEPLOY_DIR)/start_service
	cp service/stop_service $(DEPLOY_DIR)/stop_service
	chmod +x $(DEPLOY_DIR)/start_service
	chmod +x $(DEPLOY_DIR)/stop_service
	cp -R lib $(DEPLOY_DIR)/.
	cp DRISEE/README.md $(DEPLOY_DIR)/doc/DRISEE.README
	cp DRISEE/adapterDB.fna $(DEPLOY_DIR)/lib/

deploy-client: deploy-docs deploy-scripts
	cp client/* $(TARGET)/lib
	# hack to get DRISEE dependencies in kbase PATH
	ln -fs $(TARGET)/plbin/run_find_steiner.pl $(TARGET)/bin/run_find_steiner.pl
	ln -fs $(TARGET)/pybin/seq_length_stats.py $(TARGET)/bin/seq_length_stats.py
	ln -fs $(TARGET)/pybin/qiime-uclust.py $(TARGET)/bin/qiime-uclust.py

deploy-docs:
	mkdir -p $(DEPLOY_DIR)
	mkdir -p $(DEPLOY_DIR)/webroot
	cp docs/*.html $(DEPLOY_DIR)/webroot/.

test: test-service test-client test-scripts
	@echo "running server tests"

test-client:
	@echo "no client included in make target yet"

test-scripts:
	@echo "no script tests defined"

test-service:
	# run each test
	for t in $(SERVER_TESTS) ; do \
		if [ -f $$t ] ; then \
			$(DEPLOY_RUNTIME)/bin/perl $$t ; \
			if [ $$? -ne 0 ] ; then \
				exit 1 ; \
			fi \
		fi \
	done

include $(TOP_DIR)/tools/Makefile.common.rules


