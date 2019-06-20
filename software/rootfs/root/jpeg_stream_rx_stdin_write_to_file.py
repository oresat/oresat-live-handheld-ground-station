#!/usr/bin/python
import io
import socket
import struct
import sys
import hashlib
import binascii

sync_byte = '\xAA'
header_size = 28 # bytes
min_sync_len = 10

def find_header(fd):
    done = False

    while not done:
        image_len, image_len_check, hash, seq_num = header_after_sync(fd)

        if image_len != image_len_check:
            sys.stderr.write("image length check failed %d != %d\n" % (image_len, image_len_check))
        else:
            done=True

    return image_len, hash, seq_num


def header_after_sync(fd):

    #header: 16 sync bytes followed by file size repeated twice then md5 hash then sequence number

    sync_found = False
    sync_done = False
    sync_byte_count = 0
    sys.stderr.write("Waiting for start-of-frame sync bytes")
    # this will handle case where we start reading midway through data
    while not sync_done:
        byte = fd.read(1)
        if byte == sync_byte:
            sys.stderr.write(".")
            sync_byte_count = sync_byte_count + 1

        # we are done with sync, so this byte must be start of header
        elif sync_found:
            header_bytes = byte
            sync_done = True

        if sync_byte_count > min_sync_len:
            sync_found = True

    sys.stderr.write("\n")
     
    while len(header_bytes) < header_size:
        header_bytes = header_bytes + fd.read(1)

    return struct.unpack('<LL16sL', header_bytes)




image_num = 0
while True:
    image_num = image_num + 1
    sys.stdout.write("Image %d" % image_num) 
    # scan for sync bytes and valid size header
    image_len, rx_hash, seq_num = find_header(sys.stdin)
    sys.stdout.write(" size: %d tx seq: %s tx md5: %s" % (image_len, seq_num, binascii.hexlify(rx_hash)))


    buf = sys.stdin.read(image_len)
    hash = hashlib.md5(buf).digest()
    sys.stdout.write(" rx md5: %s" % binascii.hexlify(hash))
    if hash == rx_hash:
        sys.stdout.write(" OK\n")
    else:
        sys.stdout.write(" BAD\n")
        continue

    #sys.stdout.write(" read %d" % len(buf))

    # write received image to /tmp/latest.jpg
    image_file = io.FileIO(file = '/tmp/latest.jpg', mode = 'w')
    written = image_file.write(buf)
    image_file.close()
    #sys.stdout.write(' saved: %d\n' % written)
