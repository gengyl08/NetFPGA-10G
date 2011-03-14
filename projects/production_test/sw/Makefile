SRC_DIR			= src
BUILD_DIR		= bin
SCRIPTS_DIR		= scripts
MINICOM_OUTPUT_DIR	= output/minicom
REPORTS_OUTPUT_DIR	= output/reports

all:
	g++ -Wall -I./include -g ${SRC_DIR}/dma_test.cxx -lpthread -o ${BUILD_DIR}/dma_test
	g++ -Wall -I./include -g ${SRC_DIR}/reg_report.cxx -lpthread -o ${BUILD_DIR}/reg_report

tar:
	make totally_clean
	tar czvf ../prod_test_sw_`date +%Y%m%d_%H%M`.tar.-gz ../prod_test_sw

clean:
	rm -rf ${BUILD_DIR}/*
	rm -rf ${MINICOM_OUTPUT_DIR}/*
	find . -name *~ | xargs rm -f

totally_clean:
	make clean
	rm -rf ${REPORTS_OUTPUT_DIR}/*
