Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6303F0AC5
	for <lists+linux-api@lfdr.de>; Wed, 18 Aug 2021 20:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhHRSIX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Aug 2021 14:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhHRSIV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Aug 2021 14:08:21 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933E9C0613CF
        for <linux-api@vger.kernel.org>; Wed, 18 Aug 2021 11:07:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso9463132pjb.2
        for <linux-api@vger.kernel.org>; Wed, 18 Aug 2021 11:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bgi+u30ADL5qAUBsITAW8rYqpY0ExP8Ilge2KjgCxl0=;
        b=aY7Gv/1P1ww0PFzv/SpBbUA8lvn4NGQ3y1ukivnK1MpNm9PZrjzO60JRCzjs1MhQQa
         2aaT7vXl0rObrHk6OGFGlS2a9cfxsSGVpjRuCfRF1iNEe2UobdCUjC5iXKnqQRxLfH1X
         nPm9+PPzBSBGZ9nFyg24Ty3sZG/DL4POwHy1FmJcbt/tg0JgIA2f5GCGrPfZwqJPjYEA
         8fz60rZfghhmkzBjuFm/PGhNmfAJn/V6xaDwjzvQWrR6GMJsab6P5RzdFoFPC+6lx/At
         htrclTm2OX1qSW4M23hQBADV9xkvYijNg/MaJSCQN9vQ/USQ7hRaQdQo4eg3dGVMNJwB
         MxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bgi+u30ADL5qAUBsITAW8rYqpY0ExP8Ilge2KjgCxl0=;
        b=hLECaO+xPjG9JBA3kkaNSPGqt8UkwJi6lhFjn5l5N/A1t0zV7UFI51TEnXfv0lFz/y
         vygHvC5Sj/yTszAdnSfdnMmaDf9QJEewIJg0Kz3SSH+lW+kp0sFhfCGxSfMZiGfN73CX
         I3RyIzlPOviow0y8She7R5GjYLCI1+Qz4p20gQyaTV2IZi87c2BwvFiRyk58d7Ep1jxA
         aHrYgb3Lmdtj6ySpzjOe3xa/nPkHWwUn3uS3YwYRjjaq+9uRofd0gmwaSgArnoetVHFa
         zY0C8g6RkgEibw0+qJudBtKirnhSRKQkkkHJ1Vp5BbgMTB8BJTiV88CbIeWst8rTglGp
         vdwQ==
X-Gm-Message-State: AOAM5332/eFRMfjPkZ9g95NyUGvZb0NMhOB2DZMbr5eHMcunI2gOJuZs
        6QmQQnC/1Cu8HOopFxqd3BJqow==
X-Google-Smtp-Source: ABdhPJz9AmKluTiUkqlSXVIa9lO7Hw37mDklIBre4pAgvVEe2KXQAYoxw1MAS0lJPPnyEadfvbgriQ==
X-Received: by 2002:a17:90a:de16:: with SMTP id m22mr10550255pjv.38.1629310065758;
        Wed, 18 Aug 2021 11:07:45 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:1e84])
        by smtp.gmail.com with ESMTPSA id b12sm472931pff.63.2021.08.18.11.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 11:07:45 -0700 (PDT)
Date:   Wed, 18 Aug 2021 11:07:43 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v10 06/10] btrfs-progs: receive: encoded_write fallback
 to explicit decode and write
Message-ID: <YR1Mb0i6Fk1LggJb@relinquished.localdomain>
References: <cover.1629234193.git.osandov@fb.com>
 <27ad30578c6e4347ff4161183c55ba6dee2e9227.1629234282.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27ad30578c6e4347ff4161183c55ba6dee2e9227.1629234282.git.osandov@fb.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Aug 17, 2021 at 02:06:52PM -0700, Omar Sandoval wrote:
> From: Boris Burkov <boris@bur.io>
> 
> An encoded_write can fail if the file system it is being applied to does
> not support encoded writes or if it can't find enough contiguous space
> to accommodate the encoded extent. In those cases, we can likely still
> process an encoded_write by explicitly decoding the data and doing a
> normal write.
> 
> Add the necessary fallback path for decoding data compressed with zlib,
> lzo, or zstd. zlib and zstd have reusable decoding context data
> structures which we cache in the receive context so that we don't have
> to recreate them on every encoded_write.
> 
> Finally, add a command line flag for force-decompress which causes
> receive to always use the fallback path rather than first attempting the
> encoded write.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  Documentation/btrfs-receive.asciidoc |   4 +
>  cmds/receive.c                       | 266 ++++++++++++++++++++++++++-
>  2 files changed, 261 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/btrfs-receive.asciidoc b/Documentation/btrfs-receive.asciidoc
> index e4c4d2c0..354a71dc 100644
> --- a/Documentation/btrfs-receive.asciidoc
> +++ b/Documentation/btrfs-receive.asciidoc
> @@ -60,6 +60,10 @@ By default the mountpoint is searched in '/proc/self/mounts'.
>  If '/proc' is not accessible, eg. in a chroot environment, use this option to
>  tell us where this filesystem is mounted.
>  
> +--force-decompress::
> +if the stream contains compressed data (see '--compressed-data' in
> +`btrfs-send`(8)), always decompress it instead of writing it with encoded I/O.
> +
>  --dump::
>  dump the stream metadata, one line per operation
>  +
> diff --git a/cmds/receive.c b/cmds/receive.c
> index b43c298f..7506f992 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -40,6 +40,10 @@
>  #include <sys/xattr.h>
>  #include <uuid/uuid.h>
>  
> +#include <lzo/lzo1x.h>
> +#include <zlib.h>
> +#include <zstd.h>
> +
>  #include "kernel-shared/ctree.h"
>  #include "ioctl.h"
>  #include "cmds/commands.h"
> @@ -79,6 +83,12 @@ struct btrfs_receive
>  	struct subvol_uuid_search sus;
>  
>  	int honor_end_cmd;
> +
> +	int force_decompress;
> +
> +	/* Reuse stream objects for encoded_write decompression fallback */
> +	ZSTD_DStream *zstd_dstream;
> +	z_stream *zlib_stream;
>  };
>  
>  static int finish_subvol(struct btrfs_receive *rctx)
> @@ -989,9 +999,222 @@ static int process_update_extent(const char *path, u64 offset, u64 len,
>  	return 0;
>  }
>  
> +static int decompress_zlib(struct btrfs_receive *rctx, const char *encoded_data,
> +			   u64 encoded_len, char *unencoded_data,
> +			   u64 unencoded_len)
> +{
> +	bool init = false;
> +	int ret;
> +
> +	if (!rctx->zlib_stream) {
> +		init = true;
> +		rctx->zlib_stream = malloc(sizeof(z_stream));
> +		if (!rctx->zlib_stream) {
> +			error("failed to allocate zlib stream %m");
> +			return -ENOMEM;
> +		}
> +	}
> +	rctx->zlib_stream->next_in = (void *)encoded_data;
> +	rctx->zlib_stream->avail_in = encoded_len;
> +	rctx->zlib_stream->next_out = (void *)unencoded_data;
> +	rctx->zlib_stream->avail_out = unencoded_len;
> +
> +	if (init) {
> +		rctx->zlib_stream->zalloc = Z_NULL;
> +		rctx->zlib_stream->zfree = Z_NULL;
> +		rctx->zlib_stream->opaque = Z_NULL;
> +		ret = inflateInit(rctx->zlib_stream);
> +	} else {
> +		ret = inflateReset(rctx->zlib_stream);
> +	}
> +	if (ret != Z_OK) {
> +		error("zlib inflate init failed: %d", ret);
> +		return -EIO;
> +	}
> +
> +	while (rctx->zlib_stream->avail_in > 0 &&
> +	       rctx->zlib_stream->avail_out > 0) {
> +		ret = inflate(rctx->zlib_stream, Z_FINISH);
> +		if (ret == Z_STREAM_END) {
> +			break;
> +		} else if (ret != Z_OK) {
> +			error("zlib inflate failed: %d", ret);
> +			return -EIO;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int decompress_zstd(struct btrfs_receive *rctx, const char *encoded_buf,
> +			   u64 encoded_len, char *unencoded_buf,
> +			   u64 unencoded_len)
> +{
> +	ZSTD_inBuffer in_buf = {
> +		.src = encoded_buf,
> +		.size = encoded_len
> +	};
> +	ZSTD_outBuffer out_buf = {
> +		.dst = unencoded_buf,
> +		.size = unencoded_len
> +	};
> +	size_t ret;
> +
> +	if (!rctx->zstd_dstream) {
> +		rctx->zstd_dstream = ZSTD_createDStream();
> +		if (!rctx->zstd_dstream) {
> +			error("failed to create zstd dstream");
> +			return -ENOMEM;
> +		}
> +	}
> +	ret = ZSTD_initDStream(rctx->zstd_dstream);
> +	if (ZSTD_isError(ret)) {
> +		error("failed to init zstd stream: %s", ZSTD_getErrorName(ret));
> +		return -EIO;
> +	}
> +	while (in_buf.pos < in_buf.size && out_buf.pos < out_buf.size) {
> +		ret = ZSTD_decompressStream(rctx->zstd_dstream, &out_buf, &in_buf);
> +		if (ret == 0) {
> +			break;
> +		} else if (ZSTD_isError(ret)) {
> +			error("failed to decompress zstd stream: %s",
> +			      ZSTD_getErrorName(ret));
> +			return -EIO;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int decompress_lzo(const char *encoded_data, u64 encoded_len,
> +			  char *unencoded_data, u64 unencoded_len,
> +			  unsigned int page_size)
> +{
> +	uint32_t total_len;
> +	size_t in_pos, out_pos;
> +
> +	if (encoded_len < 4) {
> +		error("lzo header is truncated");
> +		return -EIO;
> +	}
> +	memcpy(&total_len, encoded_data, 4);
> +	total_len = le32toh(total_len);
> +	if (total_len > encoded_len) {
> +		error("lzo header is invalid");
> +		return -EIO;
> +	}
> +
> +	in_pos = 4;
> +	out_pos = 0;
> +	while (in_pos < total_len && out_pos < unencoded_len) {
> +		size_t page_remaining;
> +		uint32_t src_len;
> +		lzo_uint dst_len;
> +		int ret;
> +
> +		page_remaining = -in_pos % page_size;
> +		if (page_remaining < 4) {
> +			if (total_len - in_pos <= page_remaining)
> +				break;
> +			in_pos += page_remaining;
> +		}
> +
> +		if (total_len - in_pos < 4) {
> +			error("lzo segment header is truncated");
> +			return -EIO;
> +		}
> +
> +		memcpy(&src_len, encoded_data + in_pos, 4);
> +		src_len = le32toh(src_len);
> +		in_pos += 4;
> +		if (src_len > total_len - in_pos) {
> +			error("lzo segment header is invalid");
> +			return -EIO;
> +		}
> +
> +		dst_len = page_size;
> +		ret = lzo1x_decompress_safe((void *)(encoded_data + in_pos),
> +					    src_len,
> +					    (void *)(unencoded_data + out_pos),
> +					    &dst_len, NULL);
> +		if (ret != LZO_E_OK) {
> +			error("lzo1x_decompress_safe failed: %d", ret);
> +			return -EIO;
> +		}
> +
> +		in_pos += src_len;
> +		out_pos += dst_len;
> +	}
> +	return 0;
> +}
> +
> +static int decompress_and_write(struct btrfs_receive *rctx,
> +				const char *encoded_data, u64 offset,
> +				u64 encoded_len, u64 unencoded_file_len,
> +				u64 unencoded_len, u64 unencoded_offset,
> +				u32 compression)
> +{
> +	int ret = 0;
> +	size_t pos;
> +	ssize_t w;
> +	char *unencoded_data;
> +	int page_shift;
> +
> +	unencoded_data = calloc(unencoded_len, 1);
> +	if (!unencoded_data) {
> +		error("allocating space for unencoded data failed: %m");
> +		return -errno;
> +	}
> +
> +	switch (compression) {
> +	case BTRFS_ENCODED_IO_COMPRESSION_ZLIB:
> +		ret = decompress_zlib(rctx, encoded_data, encoded_len,
> +				      unencoded_data, unencoded_len);
> +		if (ret)
> +			goto out;
> +		break;
> +	case BTRFS_ENCODED_IO_COMPRESSION_ZSTD:
> +		ret = decompress_zstd(rctx, encoded_data, encoded_len,
> +				      unencoded_data, unencoded_len);
> +		if (ret)
> +			goto out;
> +		break;
> +	case BTRFS_ENCODED_IO_COMPRESSION_LZO_4K:
> +	case BTRFS_ENCODED_IO_COMPRESSION_LZO_8K:
> +	case BTRFS_ENCODED_IO_COMPRESSION_LZO_16K:
> +	case BTRFS_ENCODED_IO_COMPRESSION_LZO_32K:
> +	case BTRFS_ENCODED_IO_COMPRESSION_LZO_64K:
> +		page_shift = compression - BTRFS_ENCODED_IO_COMPRESSION_LZO_4K + 12;
> +		ret = decompress_lzo(encoded_data, encoded_len, unencoded_data,
> +				     unencoded_len, 1U << page_shift);
> +		if (ret)
> +			goto out;
> +		break;
> +	default:
> +		error("unknown compression: %d", compression);
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	pos = unencoded_offset;
> +	while (pos < unencoded_file_len) {
> +		w = pwrite(rctx->write_fd, unencoded_data + pos,
> +			   unencoded_file_len - pos, offset);
> +		if (w < 0) {
> +			ret = -errno;
> +			error("writing unencoded data failed: %m");
> +			goto out;
> +		}
> +		pos += w;
> +		offset += w;
> +	}
> +out:
> +	free(unencoded_data);
> +	return ret;
> +}
> +
>  static int process_encoded_write(const char *path, const void *data, u64 offset,
> -	u64 len, u64 unencoded_file_len, u64 unencoded_len,
> -	u64 unencoded_offset, u32 compression, u32 encryption, void *user)
> +				 u64 len, u64 unencoded_file_len,
> +				 u64 unencoded_len, u64 unencoded_offset,
> +				 u32 compression, u32 encryption, void *user)
>  {
>  	int ret;
>  	struct btrfs_receive *rctx = user;
> @@ -1007,6 +1230,7 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
>  		.compression = compression,
>  		.encryption = encryption,
>  	};
> +	bool encoded_write = !rctx->force_decompress;
>  
>  	if (encryption) {
>  		error("encoded_write: encryption not supported");
> @@ -1023,13 +1247,21 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = ioctl(rctx->write_fd, BTRFS_IOC_ENCODED_WRITE, &encoded);
> -	if (ret < 0) {
> -		ret = -errno;
> -		error("encoded_write: writing to %s failed: %m", path);
> -		return ret;
> +	if (encoded_write) {
> +		ret = ioctl(rctx->write_fd, BTRFS_IOC_ENCODED_WRITE, &encoded);
> +		if (ret >= 0)
> +			return 0;
> +		/* Fall back for these errors, fail hard for anything else. */
> +		if (errno != ENOSPC && errno != EOPNOTSUPP && errno != EINVAL) {

Just caught something that I missed in the conversion, this needs to be
ENOTTY instead of EOPNOTSUPP.
