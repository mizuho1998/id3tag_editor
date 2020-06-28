DIR=""
FILE_TYPE=""
ARTIST=""
ALBUM=""
GENRE=""
YEAR=""
TRACK=10


build:
	docker build -t id3tag .

run:
	docker run -it --rm -v $(PWD):/work id3tag /bin/ash

check:
	mid3v2 "${DIR}/"*

set-all: set-artist set-album set-song set-genre set-year set-track

set-artist:
	ls ${DIR} | while read file; do mid3v2 -a ${ARTIST} ${DIR}/"$$file"; done

set-album:
	ls ${DIR} | while read file; do mid3v2 -A ${ALBUM} ${DIR}/"$$file"; done

set-song:
	ls ${DIR} | while read file; \
	do \
		file_name=`echo $$file | sed -e "s/[0-9]*-[0-9]*-//" | sed -e "s/\.flac//" `;\
		mid3v2 -t "$$file_name" ${DIR}/"$$file"; \
	done

set-genre:
	ls ${DIR} | while read file; do mid3v2 -g ${GENRE} ${DIR}/"$$file"; done

set-year:
	ls ${DIR} | while read file; do mid3v2 -y ${YEAR} ${DIR}/"$$file"; done

set-track:
	for i in `seq -w ${TRACK}`; do mid3v2 -T $$i/10 ${DIR}/*$$i*.${FILE_TYPE}; done
