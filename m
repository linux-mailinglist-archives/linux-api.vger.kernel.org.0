Return-Path: <linux-api+bounces-6417-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNFDAuJFFmqUkAcAu9opvQ
	(envelope-from <linux-api+bounces-6417-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 03:16:18 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D975DE306
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 03:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F1F13037488
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 01:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E870313272;
	Wed, 27 May 2026 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4dszTYjT"
X-Original-To: linux-api@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD2626B764;
	Wed, 27 May 2026 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779844540; cv=none; b=dgmwLCocKU40zyzpPWKXR+1xcWtod4OdQl4dQz6+AjLxNKqtRHteNS33GM0BMgN/wS2bYG0QikEgtJiuTQG+2Q19Y3sXpcGug672OIGhtbQevfSTiQ/qkMdKkn+FkMm/KPpqDOYeeFIjqC02m6Q7XlgORG1UAnpil/ErEpNVfLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779844540; c=relaxed/simple;
	bh=b35A5qZxUq6MNNo8bBuj9sTBjvapqqit5PoBBag5ZOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqTQDvh0OOvar4nbtSxhpgAR0WO3IX+fDfOIP1ufVRyNiekmDhy3Mv24YoGi+pIRPpbsygeCfgR3Psu6mKE+vSORqgJdPZZ/AYeyVqLKRbPB1MU3ZG0gbuzI3dGzg3ysEtuZvgihKRhNLchZcMS0emAvcY++KNsEFmXpnFMMzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4dszTYjT; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gQBWX66T0z1XM6JN;
	Wed, 27 May 2026 01:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779844532; x=1782436533; bh=JQ76c0ZKyPhJJ/YX2rWxuedO
	/ZUKDUPRSCpouDt6Lvk=; b=4dszTYjTwYxVzsK3EmW9I1eIh8cJav0Zmg4Fqfhk
	n7ad5S6m0qtboA6aELUUHk0Bmf9+W+j9opNIKiyfk+bC8Qb3Lc/nlkD6vyRe7wbU
	fXwsGcFzjzm5rIS+FgdgCByEX5IkJjGK/eM5WbcxqUIPjply4pF982/b8uKeH2Sh
	NtvGWCfKMItmhtUqIWNcJA9I0Oqq8n24Tdfm5M21Bq8fdB0ib+LQ4dubSg1na0/N
	PjQDFLtOr//BL6iWNAADp4KO4TYgmtmUVYssbrqlz0ZhMD/NL85WOqkHPRnKa3i8
	1QaFn9ew0mcDMHLGW25DZQucxmLe2nKCKbCEQFJaJYlaTw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MBCftocQcW0H; Wed, 27 May 2026 01:15:32 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gQBWM5yz8z1XM5jn;
	Wed, 27 May 2026 01:15:27 +0000 (UTC)
Message-ID: <426a9687-c39e-4ac8-a406-d5e2198f01b0@acm.org>
Date: Tue, 26 May 2026 18:15:24 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
To: Theodore Tso <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig
 <hch@infradead.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Akilesh Kailash <akailash@google.com>,
 Christian Brauner <christian@brauner.io>
References: <ad30g9xMs9wNJhFb@infradead.org> <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org> <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan> <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan> <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan> <ahTzHyHBL8t0iNBR@google.com>
 <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-6417-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:mid,acm.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 65D975DE306
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 6:42 AM, Theodore Tso wrote:
>      2. Host Controller Hardware Limits (UFSHCI)
>      
> 	Transfer Queue Depth: A UFS controller supports a predefined
> 	    number of outstanding task request entries. This is often
> 	    hard-capped at 32 concurrent transfer requests (slots) by the
> 	    doorbell register array.

The above information comes from the UFSHCI 3 standard. Jaegeuk's test
setup has an UFSHCI 4.0 controller that supports one submission queue
per CPU and also one completion queue per CPU. This is an architecture
that is very similar but not identical to NVMe. Jaegeuk, please correct
me if I got anything wrong.

Bart.

