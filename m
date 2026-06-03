Return-Path: <linux-api+bounces-6501-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +OWgH8x+H2rDmQAAu9opvQ
	(envelope-from <linux-api+bounces-6501-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 03:09:32 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A91F633517
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 03:09:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MUJ0fG0c;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6501-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6501-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D41843026E4F
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 01:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3542D7DD4;
	Wed,  3 Jun 2026 01:08:52 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E68A2EAD15
	for <linux-api@vger.kernel.org>; Wed,  3 Jun 2026 01:08:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448932; cv=none; b=GgLyXLJoDnKYgE5iNAs9aLL7ySEuqQyYC3lnBbAyfVgdiKFTu3qEEf7kd5g5MfEPogbiOsm3HWtVVq7+Imd0QS1/5reEacjokXqJ6qSlt5ZnySrLVf2LE88Fyskik2MgLHlZ/3UPmTk5KglMfrJuQeTO8O2QbnWi6cmfYuXTpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448932; c=relaxed/simple;
	bh=2ZV+1Hj/UhdYw1uvUPcYqYevnxoEYOizS2cgooIrU6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUBvPq+qiLzYSvePf0AwiwMQLcCpoyWuMqUXehwA//CHnozB4/1KJyvUSGNNVwmVCUw9sBm5y/KCliaJwQRtL2XwKhf5PtlSYIN0hvShHRZ5uaSip/2fLJlk+3QntfuJfn+f2984bMH7dD1uWD3MqIpCsb3pLuBOiV7wyUeSJyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUJ0fG0c; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so109926745e9.2
        for <linux-api@vger.kernel.org>; Tue, 02 Jun 2026 18:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780448930; x=1781053730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3GAR7SC93N2eePKpNe9tCYUdzk5c1g7WEzw2IFy6ZM=;
        b=MUJ0fG0cIpJXmkAFcfYXyp+Ziu0eTA2MWQKXOJCX9h4zM6quBFYIGbyFGKTKcYDnUP
         QCr+wZoQugq6gZqHvmB06ZVuyPnzsP+9RN/MkIZdhn6sgxeFendYavb4LX94sVQknFes
         u34G2sWsdklgOrU01MKqa26rFpWStx3YomD+VmUFaipI31mBQETea10anU3ZByFumeG8
         1Sz599EnabnRLD8aCPMaViugxHQ9CtMt2hpwdrlY23Rhnfa0dM9pgwNQw76F1S1ifBSz
         0MuU4qj8NGZTi5IG6fILtSkgR1IA4sV5TgiE1cozubQ48uUDm1VgtXRT9hiwZV1aLvSN
         vJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448930; x=1781053730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d3GAR7SC93N2eePKpNe9tCYUdzk5c1g7WEzw2IFy6ZM=;
        b=buyRlktnwhewJ3KWXLu/9HO1gEdNhMEUWPRTfPMPWa+J+LSrz+M67xse0I8nCnVDi+
         nIqzOg3R9agA5LHW6gBv3p3ZRdnI6Nj3SzKdyN5ngGsBi0KPfalyh0r1PJ+UaWQDHYvK
         W0+uvSQKpNyObstBh42uRYQVTCCH74STClNwLxyQkVAhXCs0SvqVEQdkKjgUa7qZjItx
         sCbNBNz31YlHxTZs/KjxjF/QwdJU0DvFsogVqnURtt1TxGV+pirixDIFANELdfsStKyB
         c3UMf89guMRiTYOJ/aDxZWzcDDh1HMMBNzOqi/Y2JmVRnuNOgp4TTVEdtaFHtgvv+z1l
         0XCw==
X-Forwarded-Encrypted: i=1; AFNElJ+6/jeZ+RSst0wmOGT3kSc09n4fGCzsJHih5CTYb4h1+2Ap0/VC0xY88vbO6+T9bREB3KGN1EZ1yaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgqQow897OJQUIJvV9O2Iq3nJfU06Y8RMXMHbKSqSZa/fR9EaP
	fa/AWK8DT9ox5V6JSzfxBDjQ7GXymSq/UfPu9rJld/AEV0nBEl2hvA6P
X-Gm-Gg: Acq92OGjkN0O50ND2cWdGwLLSq25cCID0zDdLsEHPq4NPQ/i//svWQfyULplJOIzXqW
	/De9z04jGD8rNJjqOj1TvjG+cLuZKScCc2wpYCF3eDkFQtnxZ3UAGnoRbLX8DJ7EmqtB6yXwH5O
	dA5ZdktxkL+0dDGRl8JblptWb6+SK6ckwrMy1GGR+VV0V2MpazLoZnV6Y31IYJsJGz+EELC1HdT
	7fchCu4yrNTMDTG4zFaL2YVoqfzgs32NW/iQmc2GSZN0q96w0t6eadqfnP73ULk6is3DdPqua8s
	InwRx7MbLfhzTH3ULs6SX8aBHZDWztKqR5xcsTZlfUvADMiZyDqgGbDdifslO/6Ydvfxk++Aq3P
	0ebi6ehVFpZuSKKI9qENYF8JVWfXp8ZQzQvYGc8zKmIF+J3LoUrglTRyXheo+a0uUvRNIv0barr
	h4DC3T5xTOq3GSbMW3xGBJABZjjyPeIw==
X-Received: by 2002:a05:600c:3e19:b0:490:b58a:dcc1 with SMTP id 5b1f17b1804b1-490b60fcd56mr18908035e9.29.1780448929768;
        Tue, 02 Jun 2026 18:08:49 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490b725fb1bsm11254325e9.8.2026.06.02.18.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 18:08:49 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	safinaskar@gmail.com,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Wed,  3 Jun 2026 04:08:44 +0300
Message-ID: <20260603010844.257094-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
References: <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,gmail.com,zeniv.linux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6501-lists,linux-api=lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:safinaskar@gmail.com,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A91F633517

Linus Torvalds <torvalds@linux-foundation.org>:
> That absolutely would be my suggested next step.
> 
> Something like the attached - get rid of filemap_splice_read()
> entirely, and just replace it with copy_splice_read().

Okay, I will post something like this soon.

But I'm slow person, and also I will test things in Qemu, so this will
take some days.

-- 
Askar Safin

