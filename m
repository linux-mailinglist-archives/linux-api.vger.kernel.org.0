Return-Path: <linux-api+bounces-15-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBC37E6CFB
	for <lists+linux-api@lfdr.de>; Thu,  9 Nov 2023 16:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2091C20777
	for <lists+linux-api@lfdr.de>; Thu,  9 Nov 2023 15:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E1713AEA;
	Thu,  9 Nov 2023 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-api@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EFF1DFF0;
	Thu,  9 Nov 2023 15:13:48 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17CF18B;
	Thu,  9 Nov 2023 07:13:47 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9B40967373; Thu,  9 Nov 2023 16:13:43 +0100 (CET)
Date: Thu, 9 Nov 2023 16:13:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 02/21] block: Limit atomic writes according to bio and
 queue limits
Message-ID: <20231109151343.GB32432@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-3-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Sep 29, 2023 at 10:27:07AM +0000, John Garry wrote:
> We rely the block layer always being able to send a bio of size
> atomic_write_unit_max without being required to split it due to request
> queue or other bio limits.
> 
> A bio may contain min(BIO_MAX_VECS, limits->max_segments) vectors,
> and each vector is at worst case the device logical block size from
> direct IO alignment requirement.

A bio can have more than BIO_MAX_VECS if you use bio_init.

> +static unsigned int blk_queue_max_guaranteed_bio_size_sectors(
> +					struct request_queue *q)
> +{
> +	struct queue_limits *limits = &q->limits;
> +	unsigned int max_segments = min_t(unsigned int, BIO_MAX_VECS,
> +					limits->max_segments);
> +	/*  Limit according to dev sector size as we only support direct-io */

Who is "we", and how tells the caller to only ever use direct I/O?
And how would a type of userspace I/O even matter for low-level
block code.  What if I wanted to use this for file system metadata?


