Return-Path: <linux-api+bounces-6593-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7kTSE9o2KWrWSQMAu9opvQ
	(envelope-from <linux-api+bounces-6593-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 10 Jun 2026 12:05:14 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8215668193
	for <lists+linux-api@lfdr.de>; Wed, 10 Jun 2026 12:05:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gehZfH0X;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6593-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6593-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03B293004F75
	for <lists+linux-api@lfdr.de>; Wed, 10 Jun 2026 09:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F633D565C;
	Wed, 10 Jun 2026 09:55:45 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6029331ED7
	for <linux-api@vger.kernel.org>; Wed, 10 Jun 2026 09:55:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085345; cv=none; b=VFmecMeC/TVUZ9KWocl1dSRRsABxFViGwgLLDd+UdXotgr/UYrFN/lC/XVd8durtSWyjqwrxiVE4lK93lrxCPLqIwm97/4E2gEtpsqaNSHesEpJ1VXCFFofc+nNuseIgEKzjlJT73//5x3qqppBfkbgsDtOcugE1vOEcLx/7P/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085345; c=relaxed/simple;
	bh=RxYtaOzOjvXLhABsTLKT5rUdf2WjHUzZ4ozMxheKOIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRZcKwUaiAfOWvX430skrgH90SKd/MA07H42LUe7gN/8MEyxAw8bbLPVE/QBP4wePeUnoXCUryLM7a/EWJdlQ8N/WlFv3BLiGeAezGKxGC94t6noU0uEBsYQsKHJl/pPGrKY6r/Id+bi92fuDBTHA2ZsgxEaBSVSJXVhgPtrvpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gehZfH0X; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so58146135e9.1
        for <linux-api@vger.kernel.org>; Wed, 10 Jun 2026 02:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781085342; x=1781690142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXXf5kDNkZaZma579LeFr3+QRDi52FtRCi+F8Ah0BJ0=;
        b=gehZfH0XlCrjPYGryvmNLnz8gas78t1NCCGVCxYQuXc+ezJVxkJovg3gZ68eoCZhgT
         w7yc27Z5FV6OxwB0FcPBX2EqHE5OPYPbURPQ7PvMZtE9MCaPKi95MUdpet0KUehGntqc
         HKRVYuvq7W/adTDWj7WZk+9P4GJHI1tChfCf+Jq9+5a8m4OTJYSviMfYuqiW8Kxn9OQj
         zL7dYye1N7l2Jd7Gx5fa399/j/FnsYswvqucZIgsSiW/jaK10oDH+iMuO0D6AA3auCEt
         /IElReue6IxUwWl0P2t/ZHUQ0JIBvBsH4U6b1xso05OWP1ipmWJ6Je8m+oBQpDhf+jbR
         rK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781085342; x=1781690142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DXXf5kDNkZaZma579LeFr3+QRDi52FtRCi+F8Ah0BJ0=;
        b=V6QjvmObLLwEHwpZFPjqL36E7VX7OGzOk2B9pZ1l89MVTQGkjM4vIxtZWlmTKjgU/H
         jfFXjOupMlvCpl3qSS2AhNjluwHWWQcnrJR4NFXYblmy7ZbpVgbXPuUG20m0uyQgRYgx
         7xxupknZvnrnF24T4eej0CUdxVEd54qQQA17b/n0idRuzozAx4ikad/dH2LzaDWDiwg3
         8GCkmRHoqqwmKHea752ijZBd9zR6oocUxG++jNsBVAAd1QVEa3kDN3Wcy1nUZpQM0Lsl
         OvM38pHywSUWZvZlPI2/gYKeuvrTpwmmh0GW8coPxXyhOvw9PHIWqWtsOHV4GAOOAsBV
         xyiw==
X-Forwarded-Encrypted: i=1; AFNElJ/NGiB3Rr+Q/iuIEl+95BIPN5QgLUbGMaeBGPF67rKS/s56VWJa4yvbho/yzWjjeN1s9Q4+uCe4IH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1SHu8Qzu/oIXF7uQXkzwvdZEjFfUJEMlFJs0xT9bwLptZeHbD
	W9dZVgwi0v89Yy+CM1ZCoerloAB7mJx2uVBGSwIN/OOwFWh+K0Vp8ZiC
X-Gm-Gg: Acq92OFZpnkWnxnll/GRcWrIRLrbux4GN7eyCk4Wc7F30A35sRcyV54PcZDVAA3VkKA
	fJ2SgNvVAV0rqiytJ8kLff6AZ9xWVRoCkuYHgU94ikoO/hy1WbjSevlsko/2osPPNSvZbb4F7+w
	gMTiM80bZ23dIju1epMj7+znCIO8e4BSFReXCPRXSsRV2gLUOKTQxPo7Ppaml09nc/OW4oxECUj
	bEJhMPH8qyP+LxQ0gR1KVnBzQvSg9bM5Yuk9oaCCMYma+gVxtaTn1Vu8kVe+jihfGS8800AQzxn
	408XOGFfG3ms7K734+uwFrhPKIRX2QmFjDxuxZVvpUjMCxJsCCS0JgIUxyooy11gv0Zdu9LW/eS
	2hr/+DFELKycAheMVgVsdCKZdu8w8HF/fP6Lb0DvnLxA+iAnTJdZLDygbGgs0DvTuR67PKOrlcZ
	1cBmP7rCG83MF9PNX4wIQ3mvvrmmh2aFemcbDTklmft8YOeHyp09G7y/BHqyd44EsIoqwoAHvyX
	Zh64jklMw==
X-Received: by 2002:a05:600c:6096:b0:490:c1cb:48f4 with SMTP id 5b1f17b1804b1-490c2d038e8mr309043665e9.12.1781085342059;
        Wed, 10 Jun 2026 02:55:42 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm591850845e9.8.2026.06.10.02.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 02:55:41 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:55:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, luto@amacapital.net,
 safinaskar@gmail.com, akpm@linux-foundation.org, axboe@kernel.dk,
 brauner@kernel.org, david@kernel.org, dhowells@redhat.com,
 hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org,
 patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk,
 willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260610105540.5901a5be@pumpkin>
In-Reply-To: <aijxfxXrWLCVqV6-@gondor.apana.org.au>
References: <CAHk-=wh5bFj1a7eaGp9sixDg3UXu7xUGfU=YJo+ckpGxGAyhXQ@mail.gmail.com>
	<aijxfxXrWLCVqV6-@gondor.apana.org.au>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6593-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:torvalds@linux-foundation.org,m:luto@amacapital.net,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,amacapital.net,gmail.com,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,linux-foundation.org:email,vger.kernel.org:from_smtp,pumpkin:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8215668193

On Wed, 10 Jun 2026 13:09:19 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > Because I think splice() is a *cool* feature. It was always *clever*.
> > I just don't think it's worth the pain it has cause.
> > 
> > And it's been around for a long long time, and after more than two
> > decades it's still most definitely not _widely_ used.  
> 
> A couple of years ago I used tee(2) in dash(1) so that we could
> avoid reading the input line byte-by-byte which is what every other
> shell does in order to pass the rest of stdin to the executed
> command.

The shell just needs something like MSG_PEEK to do a non-consuming
read from a pipe.
(Without the strange behaviour of a second offset.)

That would be simple and could have been implemented 40 years ago.

-- David

> 
> https://git.kernel.org/pub/scm/utils/dash/dash.git/commit/?id=44b15ea09a9ee5872cf477e4ffc6b42ef37d1e46
> 
> It's definitely niche but made a huge performance difference to
> this rather common scenario:
> 
> echo 'command
> ...
> rest of stdin' | sh
> 
> I didn't even know tee(2) prior to this, even though it was added
> way back.
> 
> Thanks,


