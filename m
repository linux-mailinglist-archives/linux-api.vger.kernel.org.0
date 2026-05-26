Return-Path: <linux-api+bounces-6413-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG5MDujHFWqMbAcAu9opvQ
	(envelope-from <linux-api+bounces-6413-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 18:18:48 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B11195D9895
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 18:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A8C130036DF
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7042A3A2549;
	Tue, 26 May 2026 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AwiokLBm"
X-Original-To: linux-api@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8013AF643;
	Tue, 26 May 2026 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812103; cv=none; b=odPmSGHXgl+kEscvHlNU5Qzi8V/X6LSyKpC0rUAofa22HP7FiFzkysQl13e1KsgG+mPf3ZOpjywzQBC0ffiflfbLvfKRCoMkHtWoH0bZzvsYTt211vsZ2wauD0qLEwF/Pxcess9FuOPSh8tFtRPaThedAIzpQUq1wO44SzG4uZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812103; c=relaxed/simple;
	bh=WPbX4Pya39Go2QYFfMt8pFd9wdKpwRyohHZi0oibzRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VrvdHvoGHwAHbqqt8d964A5211YzGJxu6o9AuVhhPyBOPzx2ZqKwAwP79vr9VRDEuIQL9G9YHQFpjn/n9ykWc9Ut+Fk0580ky4OmadZzFCLuq1XWiAKlqteioYaumV60D1ulYqQnlyuL2OhjKI4knTerzSbu2Dz93kQ360mSuNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AwiokLBm; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gPyWn3BVxz1XM6JN;
	Tue, 26 May 2026 16:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779812096; x=1782404097; bh=Anhq5FjNw5ss6qMVPZ01kvuQ
	c5NdyWfGRn2xYsjiF0E=; b=AwiokLBmkPXRDvxv4gU5Q8BxVUMZRQTyw3y+Qzdh
	Z784kR81SRXa82sIkwXcsNyi3LSlK1dqku6rTPoMoPVmLytdqkrK3Yk8LKaof1z5
	IUvPNNPc/Q6S7kOjZkbSrACPm7bjIjgzu1IxxbKBQSlK4tuv38BU7fvs8dD3euDA
	Tw4fggBiI1+wbtfQf2lxAk1Mu/LOduAx3pQdID/Ykhu4h1DH/J12zN1DDyjiiSdq
	XX0cpwgKDWTwyPidFJSdYB7dm+oZ0m3I2dTqtBYofc2bGINuwLNf+Ojxd6k3KQ2K
	xZpeQClWswqs2VOXACuw4RtpJCE1iU/Qha8dSaZmA5A3hg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zKWCJmXtLFCk; Tue, 26 May 2026 16:14:56 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gPyWd3bBJz1XM5jn;
	Tue, 26 May 2026 16:14:53 +0000 (UTC)
Message-ID: <f4e521ac-2381-49ca-8dcc-3cb3cf3ffaea@acm.org>
Date: Tue, 26 May 2026 09:14:52 -0700
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-6413-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,acm.org:mid,acm.org:dkim]
X-Rspamd-Queue-Id: B11195D9895
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 6:42 AM, Theodore Tso wrote:
> It seems... surprising that the additional I/O operations are actually
> throttloing UFS device bandwidth by 2x (4GB/s vs 2GB/s).  Have you dug
> into why this is happening, and whether there is anything that can be
> optimized below the file system?
The layers below the filesystem (block, SCSI, UFS) is what I'm
responsible for in the Pixel team and I can assure you that these are
highly optimized.

Since the transfer size used in Jaegeuk's tests is much larger than 4
KiB, how many CPU cycles are used per IO by the layers below the
filesystem is not limiting the transfer bandwidth.

Bart.

