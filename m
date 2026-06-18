Return-Path: <linux-api+bounces-6626-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3A+2D6ZkM2p/AAYAu9opvQ
	(envelope-from <linux-api+bounces-6626-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 05:23:18 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9116969D505
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 05:23:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6626-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6626-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55C29303C3CB
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 03:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D527C2F8EA3;
	Thu, 18 Jun 2026 03:22:58 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E255317176;
	Thu, 18 Jun 2026 03:22:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752978; cv=none; b=WFKl/CBIn8+CFK7x7TswzZEo7oqkyR+Q16V4PHHO62FBuHn0IdjpoW97Ak2sc40HOIGyiviqLc5Y02OaawwXwNsscz1OXI5+GWXlA7k1WJSK7tJAswR5zCYzgTnpFCkHGjeMUqLaCNNem+lF6Y/vgxuJBNjIs+D7an3p7KRPzgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752978; c=relaxed/simple;
	bh=9rSr0BuC3/p7eOU64GOlz03qURNFdo6OAayxM2Vyl5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JimwQ1XOu+GvRKdvq7eR6NFQoBQoqM12STkkk3UvtOgkE2vvtXQn/smNekspocP7DNo44nGU0m9Knwbgtm6SKq7P1fodswTcXZ6pxej0K6FgisnqL+IyHO3KguynLVqgROQtbpsKxOtyq4JUyjPLVL6VBeSOG0FiCrNDMAEiuVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ggmHX5588zYQtw0;
	Thu, 18 Jun 2026 11:22:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 477E44084A;
	Thu, 18 Jun 2026 11:22:48 +0800 (CST)
Received: from [10.174.178.253] (unknown [10.174.178.253])
	by APP1 (Coremail) with SMTP id cCh0CgB3ej+GZDNqgtnGCA--.30334S3;
	Thu, 18 Jun 2026 11:22:48 +0800 (CST)
Message-ID: <557b2e5c-7c65-48de-87a9-6fba21eca99f@huaweicloud.com>
Date: Thu, 18 Jun 2026 11:22:45 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] xfs: add support for FALLOC_FL_WRITE_ZEROES
To: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>,
 Christoph Hellwig <hch@infradead.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, linux-xfs@vger.kernel.org,
 bfoster@redhat.com, lukas@herbolt.com, "Darrick J . Wong"
 <djwong@kernel.org>, dgc@kernel.org, gost.dev@samsung.com,
 andres@anarazel.de, kundan.kumar@samsung.com, cem@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
References: <20260611114029.176200-4-p.raghav@samsung.com>
 <ajFQPANpajmFuKpi@infradead.org>
 <kn5dyqdxmsydibpfcurgpom5vwqtwinrz27oenh4pekks6ybdj@wyi4zkh7mogy>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <kn5dyqdxmsydibpfcurgpom5vwqtwinrz27oenh4pekks6ybdj@wyi4zkh7mogy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgB3ej+GZDNqgtnGCA--.30334S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDGw13Jr15Xry5WF4rKrg_yoWrWrW7pr
	ZxKFnxKFWDtryjqr10vw1kXw1093s7GF17CrW5G348Z398AFyxK3sFgrW0grZrGr4kZ3WF
	qFs0gFy8WFy5Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:mid,huaweicloud.com:from_mime];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6626-lists,linux-api=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_RECIPIENTS(0.00)[m:pankaj.raghav@linux.dev,m:hch@infradead.org,m:p.raghav@samsung.com,m:linux-xfs@vger.kernel.org,m:bfoster@redhat.com,m:lukas@herbolt.com,m:djwong@kernel.org,m:dgc@kernel.org,m:gost.dev@samsung.com,m:andres@anarazel.de,m:kundan.kumar@samsung.com,m:cem@kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yi.zhang@huaweicloud.com,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huaweicloud.com,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,huaweicloud.com:mid,huaweicloud.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9116969D505

On 6/17/2026 5:44 PM, Pankaj Raghav (Samsung) wrote:
> On Tue, Jun 16, 2026 at 06:31:40AM -0700, Christoph Hellwig wrote:
>> [API questions for Zhang and -fsdevel/ -api below)
>>
>>> +	unsigned int		blksize = i_blocksize(inode);
>>> +	loff_t			offset_aligned = round_down(offset, blksize);
>>
>> I think this actually needs to found up instead of rounding down.
>>
>>> +	/*
>>> +	 * Zero the tail of the old EOF block and any space up to the new
>>> +	 * offset.
>>> +	 * In the usual truncate path, xfs_falloc_setsize takes care of
>>> +	 * zeroing those blocks.
>>> +	 */
>>> +	if (offset_aligned > old_size) {
>>> +		trace_xfs_zero_eof(ip, old_size, offset_aligned - old_size);
>>> +		error = xfs_zero_range(ip, old_size, offset_aligned - old_size,
>>> +				NULL, &did_zero);
>>> +		if (error)
>>> +			return error;
>>> +	}
>>
>> ... then this will properly zero from the old i_size to the first block
>> boundary after the old size.
> 
> Hmm, right now we do this:
> 
> |----------|----------|----------|
>     ^      ^     ^    ^
>     |      |     |    |
>  old_size  |   offset |
>            |          |
> 	off_rd       off_ru
> 
> At the moment, we zero out old_size to off_rd and pass offset to
> xfs_alloc_file_space. xfs_alloc_file_space rounds down the offset to off_rd.
> 
> What you are proposing is to zero out old_size to off_ru, and pass
> off_ru to xfs_alloc_file_space. I don't exactly understand the
> difference.

IMO, FALLOC_FL_WRITE_ZEROES should handle the unaligned cases, if the
'offset' and 'end' are not block-size aligned, then:

1) if the two blocks straddling the boundaries have not yet been allocated,
   or allocated as unwritten, we should round outward the allocation range
   and zero out all allocated blocks, including those two boundary blocks.
2) if the blocks at the boundaries are already in the written state — which
   can occur when we call FALLOC_FL_WRITE_ZEROES within the file size. We
   should be careful here: we should only zero the ranges [offset, offset_ru)
   and [end_rd, end) for the boundary blocks, leaving the already-written
   portions of the boundary blocks intact.

Thoughs?

Regarding the second point, the current ext4 implementation has an issue —
it zeroes out the entire boundary blocks. I overlooked this previously, and
I appreciate you pointing it out.

> 
>>
>>> +	error = xfs_alloc_file_space(ip, offset, len,
>>> +			XFS_ALLOC_FILE_SPACE_WRITE_ZEROES);
>>
>> ... and here we need to pass offset_aligned instead of offset and
>> a new calculated len based on the last block boundary, and then
>> zero again after that.  That is assuming FALLOC_FL_WRITE_ZEROES
>> allows unaligned ranges for file systems.  The block code doesn't,
>> but I can't quite follow the ext4 code if it does or not, and there
>> is no mention of FALLOC_FL_WRITE_ZEROES even in the latest man-pages
>> tree.
> 
> 
> I can't find any references to FALLOC_FL_WRITE_ZEROES in the man pages
> master branch. Maybe we missed it. I can send a separate patch for that
> once we have some clarity on the API.

Yeah, I missed to update the man pages last year. Thanks.

Best Regards,
Yi.

>>
>> Maybe we also want xfstests that try unaligned FALLOC_FL_WRITE_ZEROES
>> and make sure no existing data before the range is lost and the
>> entire range is zeroed?
>>
> 
> I added FALLOC_FL_WRITE_ZEROES support to ltp (both fsx and fsstress).
> For example, generic/363 tests for unaligned writes and checks for any
> stale data. By default, I think we do unaligned reads, writes and
> truncate in fsx.
> 
>>
>>> +	if (error)
>>> +		return error;
>>> +
>>> +	/*
>>> +	 * xfs_falloc_setsize() would re-zero the written extents via
>>> +	 * iomap_zero_range(). Use xfs_setfilesize() instead.
>>> +	 * Update in-core i_size first as xfs_setfilesize() clamps the on-disk
>>> +	 * size to it.
>>> +	 */
>>> +	if (new_size > i_size_read(inode))
>>> +		i_size_write(inode, new_size);
>>
>> I think Sashiko is right that we need a pagecache_isize_extended and
>> filemap_write_and_wait_range calls here.
>>
> 
> Ok. Current fsx or fsstress did not expose this
> problem. I will look into this. Thanks Christoph.
> 
> --
> Pankaj
> 


