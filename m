Return-Path: <linux-api+bounces-6677-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id baeeKzoOPWrKwQgAu9opvQ
	(envelope-from <linux-api+bounces-6677-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 13:17:14 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F7A6C5089
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 13:17:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6677-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6677-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 331833051A79
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 11:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C24636D51F;
	Thu, 25 Jun 2026 11:17:01 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C3A3D7D87;
	Thu, 25 Jun 2026 11:16:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386220; cv=none; b=mQ5UNTcBRsv71teMyEiPs9Imy6yT8MyyFRXBqedg8pkrYX/AcYUHSJVbiRy7/q/J7kATCzr4/qb9R2Xd2zfhyQhq1KlTj754zYVX4CGarmiEhDFS4UK6E/isSOgspp7fqnpMdjuJSxYUah9akB3rNtexsUojw7+1xdJUi1T4RCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386220; c=relaxed/simple;
	bh=VakRpFkP0PJup2XvzcZ8023FTsjQhHoGF3vq6iI8rCA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MK1yEIBOl8w3VUD+ots4o1V4btO+EZY+ipS9MtPwJZJ0pT/6w5BJu9Ci9QVRwn7+GE14UFQGk1/XZnZtcKdensGomWnrvIVuKgE7YC/k4VrgcsbOBbtQs4o+ATftgqPoWXw1SEVfq+ondnxIIlbP2X65oa+EqZXAPFHlaBknCvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gmGSh4q0nzKHMX7;
	Thu, 25 Jun 2026 19:15:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D73B440561;
	Thu, 25 Jun 2026 19:16:49 +0800 (CST)
Received: from [10.174.178.253] (unknown [10.174.178.253])
	by APP1 (Coremail) with SMTP id cCh0CgAnKT4fDj1q+9s4DA--.32975S3;
	Thu, 25 Jun 2026 19:16:49 +0800 (CST)
Message-ID: <0b7f1a4f-da1c-4297-8099-98d738070ab7@huaweicloud.com>
Date: Thu, 25 Jun 2026 19:16:47 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] xfs: add support for FALLOC_FL_WRITE_ZEROES
From: Zhang Yi <yi.zhang@huaweicloud.com>
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
 <557b2e5c-7c65-48de-87a9-6fba21eca99f@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <557b2e5c-7c65-48de-87a9-6fba21eca99f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnKT4fDj1q+9s4DA--.32975S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFy5Aw17Kr1fZFW7Ar18Xwb_yoW5GrW5pr
	ZxWFnayFZFgryUWr1Ivw1DXwn293ykJF17u398W348ZrZ0yF17G3ZF9rW0grWDur1kAF10
	qF45Ka4xWFy7ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6677-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_RECIPIENTS(0.00)[m:pankaj.raghav@linux.dev,m:hch@infradead.org,m:p.raghav@samsung.com,m:linux-xfs@vger.kernel.org,m:bfoster@redhat.com,m:lukas@herbolt.com,m:djwong@kernel.org,m:dgc@kernel.org,m:gost.dev@samsung.com,m:andres@anarazel.de,m:kundan.kumar@samsung.com,m:cem@kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yi.zhang@huaweicloud.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi.zhang@huaweicloud.com,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23F7A6C5089

On 6/18/2026 11:22 AM, Zhang Yi wrote:
> On 6/17/2026 5:44 PM, Pankaj Raghav (Samsung) wrote:
>> On Tue, Jun 16, 2026 at 06:31:40AM -0700, Christoph Hellwig wrote:
>>> [API questions for Zhang and -fsdevel/ -api below)
>>>
>>>> +	unsigned int		blksize = i_blocksize(inode);
>>>> +	loff_t			offset_aligned = round_down(offset, blksize);
>>>
>>> I think this actually needs to found up instead of rounding down.
>>>
>>>> +	/*
>>>> +	 * Zero the tail of the old EOF block and any space up to the new
>>>> +	 * offset.
>>>> +	 * In the usual truncate path, xfs_falloc_setsize takes care of
>>>> +	 * zeroing those blocks.
>>>> +	 */
>>>> +	if (offset_aligned > old_size) {
>>>> +		trace_xfs_zero_eof(ip, old_size, offset_aligned - old_size);
>>>> +		error = xfs_zero_range(ip, old_size, offset_aligned - old_size,
>>>> +				NULL, &did_zero);
>>>> +		if (error)
>>>> +			return error;
>>>> +	}
>>>
>>> ... then this will properly zero from the old i_size to the first block
>>> boundary after the old size.
>>
>> Hmm, right now we do this:
>>
>> |----------|----------|----------|
>>     ^      ^     ^    ^
>>     |      |     |    |
>>  old_size  |   offset |
>>            |          |
>> 	off_rd       off_ru
>>
>> At the moment, we zero out old_size to off_rd and pass offset to
>> xfs_alloc_file_space. xfs_alloc_file_space rounds down the offset to off_rd.
>>
>> What you are proposing is to zero out old_size to off_ru, and pass
>> off_ru to xfs_alloc_file_space. I don't exactly understand the
>> difference.
> 
> IMO, FALLOC_FL_WRITE_ZEROES should handle the unaligned cases, if the
> 'offset' and 'end' are not block-size aligned, then:
> 
> 1) if the two blocks straddling the boundaries have not yet been allocated,
>    or allocated as unwritten, we should round outward the allocation range
>    and zero out all allocated blocks, including those two boundary blocks.
> 2) if the blocks at the boundaries are already in the written state — which
>    can occur when we call FALLOC_FL_WRITE_ZEROES within the file size. We
>    should be careful here: we should only zero the ranges [offset, offset_ru)
>    and [end_rd, end) for the boundary blocks, leaving the already-written
>    portions of the boundary blocks intact.
> 
I've thought about this more and feel that we need to add one more
scenario here:

3) If the blocks at the boundaries are in dirty unwritten or in delay
   allocated state, it should be handled the same way as scenario 2.
   Additionally, before returning, we need to flush these two boundary
   blocks that have been partially zeroed, to ensure that after
   FALLOC_FL_WRITE_ZEROES, all ranges are in the written state.

What do you think?

Best Regards,
Yi.
















