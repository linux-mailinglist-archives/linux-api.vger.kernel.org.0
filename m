Return-Path: <linux-api+bounces-6582-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J5e1JgH8JmrMpAIAu9opvQ
	(envelope-from <linux-api+bounces-6582-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 08 Jun 2026 19:29:37 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1327C6593EC
	for <lists+linux-api@lfdr.de>; Mon, 08 Jun 2026 19:29:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=UvkMWN8K;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6582-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6582-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23C89326E4A2
	for <lists+linux-api@lfdr.de>; Mon,  8 Jun 2026 17:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A753DA5BF;
	Mon,  8 Jun 2026 17:19:50 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352473D7D6C;
	Mon,  8 Jun 2026 17:19:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939189; cv=none; b=L9anciK/1SThfBFgIaCrw/2L7svUDZ01S9V35t0bT8aKmcvIYv9cDzDcYkowa+amz9fKFJMKwc7ORjNBExutZp8B2PudI/XG2TgNjF4soWWMu8rLL8ermnHmGQd/WAGkW0FXM+UBM0QYhptRZsJeGBspMb6hTkM7o10ZZmxBeGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939189; c=relaxed/simple;
	bh=9Qlf++86pYiT70fbPC622/UMipUmxzwFQY0KTr4SwmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGAYs+6A0sHKsuB/KNZ7VJiBPKJ0e/iK1FGJhwZgoBL/0Cfa16e2KiqWW0s28bZowvM40B4IBop4sIdIVqjW6I5rboR2/5ZbzulhNzBaoN49FSbX0XC3TvCzLpEinyYr60ijQtgOZtZGXogY+hbyATu7wBwLnFCpyQf404NAUps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UvkMWN8K; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65898RFG2767293;
	Mon, 8 Jun 2026 17:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DBoyFy+ciaxzSZRoZcPAmZj6N0IP7+
	wC188AvkIvM0c=; b=UvkMWN8KLfEzxmLpZ1sY2LmMpEnsERZql/SZu79GcacmVG
	nJ8RDAA/EWJu0QTBT9I8rhEVGVjsvw491qHDLjkWbtTj+G1ErEbNucmYNgefck3n
	sXb71UYeyoOJ3iHb9uGTlQa1c7zijbhSwJ3CbUZLqUDhfodU85OeYwZ9H99mdnC3
	r3SaOq0YfnLKUBrzEI/NDGMC4tmmsMbWreWWLpwy6XtaZOHoNm/OFg4ZwV0/I59G
	4KkrTmCjUm399k2RFD4LQ1FZWu4IhVjrWGpXHlQ1bMOozcExaJDEQwFU+NbG0yrW
	VBNpihqdOr0erSNa3EBLl3w2maw+J6eaZD+zOt1Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23rg7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 17:19:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658H4d0F008374;
	Mon, 8 Jun 2026 17:19:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvpxgua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 17:19:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658HJIV950528622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 17:19:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A157720040;
	Mon,  8 Jun 2026 17:19:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52D852004B;
	Mon,  8 Jun 2026 17:19:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 17:19:18 +0000 (GMT)
Date: Mon, 8 Jun 2026 19:19:17 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>,
        Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260608171917.3195488Afc-agordeev@linux.ibm.com>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260531010107.1953702-3-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531010107.1953702-3-safinaskar@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a26f99a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8
 a=hJLVOhpQ1X8ZOlOX64cA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 3tuSXdak2Lf5xEGsGyO-r87wQWc8i8Fn
X-Proofpoint-GUID: j7w4f90-NzR3nJF25rOJJ_HWDzfwaa30
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2MiBTYWx0ZWRfXwxgojXL3enTK
 T61FdACtj+lsvXJkGTaZ1LMntG/SQAyNxsqx7qEQDYTGBkhW1iVkn9xU8IIeIAi6Kga5+V+7UtL
 iYIpMyO4DXfaAYbvQTNintFAu1aBmf88vRo5JGUI7xPtSdf7U27HnjHgKO1xllzes1rUkqEpRCY
 0RK4JOOXoKptl9erTAE1uuredrMJXx2/J3b8CwV3QH88pSOZjm1JTRh7dN4oJ5fYs3VruCq4RYL
 2GY1JMaYgK0/dUlN9NXbxIFqt4YJsSuPxljFE7Bpm3cRD/BP6J0hZfbb/hvkJTaEqdRiJhiqUNt
 cKbtnKDwPQnTxeaZT9RKCKFsZf8G3p1shpV729SHu0m/RmJ3eMXqf/h22pjUEdP+tdOuVgJjWP6
 hcZnF3TOL6+y6UNOYsSgIsXQ8pphcaCfchOhsJ0XFT6pCWKtZ5yLbG8ytOVO04FBxbyXDcZm48B
 UQ2ogQT/HXxlK2bArQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080162
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6582-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:torvalds@linux-foundation.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:patches@lists.linux.dev,m:linux-s390@vger.kernel.org,m:linux-next@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[agordeev@linux.ibm.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agordeev@linux.ibm.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1327C6593EC

On Sun, May 31, 2026 at 01:01:06AM +0000, Askar Safin wrote:
> vmsplice behavior on writable pipe became equivalent to pwritev2.
> vmsplice behavior on readable pipe already was nearly
> equivalent to preadv2, but I made this explicit. I. e. I made it
> obvious from code that vmsplice now is equivalent to preadv2/pwritev2.
> 
> Also I moved vmsplice to fs/read_write.c, because now it arguably
> belongs there.
> 
> Note that SPLICE_F_NONBLOCK behavior slightly changed: previously
> vmsplice ignored whether the pipe was opened with O_NONBLOCK, and mode
> of operation depended on whether SPLICE_F_NONBLOCK was passed only.
> Now the operation will be non-blocking if O_NONBLOCK was passed when
> opening *or* SPLICE_F_NONBLOCK was passed to vmsplice. Previous
> behavior was arguably buggy, and new behavior is arguably better.
> 
> Now SPLICE_F_GIFT is always ignored by all 3 syscalls: splice, tee
> and vmsplice.
> 
> Signed-off-by: Askar Safin <safinaskar@gmail.com>
> ---
>  fs/read_write.c          |  23 +++++
>  fs/splice.c              | 192 +--------------------------------------
>  include/linux/skbuff.h   |   4 +-
>  include/linux/splice.h   |   2 +-
>  include/linux/syscalls.h |   4 +-
>  5 files changed, 29 insertions(+), 196 deletions(-)

Hi All,

This patch as commit e2c0b2368081b ("vmsplice: make vmsplice a trivial
wrapper for preadv2/pwritev2") in linux-next on s390 causes the selftest
tools/testing/selftests/mm/cow.c to hang:

# [RUN] vmsplice() + unmap in child ... with PTE-mapped THP (128 kB)

Recently there has been changes in THP area, so the problem is not
necessary linked to this patch per se.

Please, let me know if you need any additional information.

Thanks!

