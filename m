Return-Path: <linux-api+bounces-6521-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dNMbNTGgIGrH5wAAu9opvQ
	(envelope-from <linux-api+bounces-6521-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 23:44:17 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4C363B712
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 23:44:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=EUYOB1Fp;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6521-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6521-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54A473013B74
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 21:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2934A13B5;
	Wed,  3 Jun 2026 21:44:15 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA048C8C5
	for <linux-api@vger.kernel.org>; Wed,  3 Jun 2026 21:44:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780523055; cv=none; b=NHUOprt8HFrooE6bCrrbnJJfhCQHrk727AteZzP3lJI3bkn+inXcf5h+6qKD7l5M0puRlHcqUQ03NJO5Ve2/6BOez9Ru9kCEhz/oN7/CjX03f8mI+QtiIhF52BFe0+ilhQaIkhyVGi2Ar52EjzOYKiSYqU+XyTWSJpTBknIVEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780523055; c=relaxed/simple;
	bh=KZSmPn6xQM1bVRhAbp7rTJ/2+QAJ2min3ynRo3L1ax4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l03gljBjmCopig3Gjg51h+TJlorebMi/Onm1BmD47PFFWe2vwifr2/XdRbmrOOpVLarN9eE36goAavmXrkJIOkY+eegoo3KyWnSBwg2IbhhcAlqcL8m3Q+AOTALJ8NLwUJGHYJOeLltTYDGBuVOvoTwPMvpWNpXACxP+UszSyQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EUYOB1Fp; arc=none smtp.client-ip=209.85.215.175
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c85a297d2d2so25707a12.0
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780523053; x=1781127853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O8X5hcAFVZJZKmCogabE4dJnuZ1g/E7cQIrqG9l17rg=;
        b=EUYOB1FpuXQSvgwg8K1L01k+deQaJktiW3+IfencF8r9PeNdeChm+4c1y3e/BcYWuP
         +UzG6rulR20Jus1J0SIvlYnwffsE2s+OUIrz6oK3fTcAkzyWdKpfIX7dtPupAJFL7oBk
         B1ZxQe9FkC5t/QsDCOBBnvveVpP3PtQmgH0t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780523053; x=1781127853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8X5hcAFVZJZKmCogabE4dJnuZ1g/E7cQIrqG9l17rg=;
        b=fLcBBoeptk+BjTHMHiYWIibqHPav104V/YOiEm4y+80vmT2PJ/qKrRAlYu5TfIUkLV
         fq7G2pUImilsTtmy9AUaSKmI0fWE6F7IUIiam2AH3NTo3wV5xdCNogRIDtXx/jEcFDTN
         AOuQxHcwYuI83lW2o0xUotwSYnW2fmuIqzKPtq18oEjANpM2H/OsO9T/zMC0P3rSy6LW
         Y1ja8kZtnOwrVx2bvpLUUX9WHQz7nRyoJJRenq0CN7QD+mtPsjAjxXXlI68Ag5GYI+BD
         6d4MdzCvkgQKwJ7/YUuTZUUPxFLLedklROV/KhYPyPAaCirVdZ6XXw9dA82sOzt3mxJl
         eG3A==
X-Forwarded-Encrypted: i=1; AFNElJ98A/zBcAAmY3FxZ461/u1P0qVK8y0Rd8/QrEVGtRhDhlPiIKw+oDVR8hFLo5iEQru7fcGglKtP+w0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjxC9p3WbwXbYTpvnKu5XdZxzrWQ65tHp3uxNei101Iwhs/z9r
	tyz/yF8FTNf3HG/PzEHq7nmFiArNVgCXHzP2kzCPSyOTuXZd74Rx60ebbGNmEowby7cL3Jz04sy
	IMwmKDVlwRw==
X-Gm-Gg: Acq92OGYKdsIrp9YgkCwmhqrbJjbls4OMW1QMkGTGyGhQf2SfJrvtxDMuSbuTHCABSL
	pKiQRSWI0X+fgbiEnB33WFZPwqLbmT0wxcINbBiKP+Tz0WO2kWZWvI+4KDUfclpJjCMftlxx+D+
	Aaa3SgYJWSmb/CNEQjc5TD3tY/X+j39K1KkbedEM0Cxmy8kUZ60cRbGr1rJmJdvs8ss0aD7smtC
	dZ2CeUcyl6GAsvw9xwt6jmixg6GNL/TZg5djbJFuuEqFFf029SkU0qDwNvTlfyaJWqxfPtibSNH
	n1s7MC+bK7I4A0Vc0L3EQ0zqlZCbTUCkH1X2d3ijvf80bMJfgTY2sptuJX0/DOxHZ1qYib1eLrA
	EgFXcoMtHyoWIN4knNw0oUDxNZtCrZyQUXcqxh/D3dehuTMrGEC2sRERX+kiUzjBNfJWNl526/V
	ZCnZno+t1NymUbn++EkHtFrtEwAtPh+O+y5YhYklIfN4tz8c/+1o+r2ih+ha7uwv+bMASQ4u593
	BvKX1bCvmciLWk=
X-Received: by 2002:a05:6a21:6e88:b0:3b2:924c:567d with SMTP id adf61e73a8af0-3b4979438b7mr5366046637.46.1780523053434;
        Wed, 03 Jun 2026 14:44:13 -0700 (PDT)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com. [209.85.214.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04a0e9sm2694742a12.13.2026.06.03.14.44.11
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 14:44:12 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2247e38eso273375ad.3
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 14:44:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9yrpdAubcKMe7urNc/Yyfz4oW7j7KOcZo0GVNx73R77Lb+F8UZlibmPFxomYq2lm0R51dLMgugwvM=@vger.kernel.org
X-Received: by 2002:a17:90a:d647:b0:368:af5c:5925 with SMTP id
 98e67ed59e1d1-36e31102a48mr5572800a91.23.1780522737998; Wed, 03 Jun 2026
 14:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
 <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
 <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
 <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com> <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
In-Reply-To: <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 14:38:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wha=LtAq8y-B4j9ps1g_qv3CK0LrHdHEVxP_52p-m=NZA@mail.gmail.com>
X-Gm-Features: AVHnY4IpVbwzilxzEo0kIzmtKsGcV63XCgmSpKmBQvjcdm3Lbflf84U-wY6VXLY
Message-ID: <CAHk-=wha=LtAq8y-B4j9ps1g_qv3CK0LrHdHEVxP_52p-m=NZA@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6521-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:luto@amacapital.net,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,linux-foundation.org:dkim,linux-foundation.org:from_mime,linux-foundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A4C363B712

On Wed, 3 Jun 2026 at 14:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It was just the filesystem side that basically now instead of exposing
> the page cache directly (with filemap_splice_read) now only exposed a
> *copy* of the page cache (with copy_splice_read).

... and let me note that UNTESTED part again.

The patch looked "ObviouslyCorrect(tm)" to me, and I did actually
compile-test it too.

So it probably wasn't _complete_ crap.

But I never even booted it, and if I had, I wouldn't have had any
loads that uses splice (or sendfile) anyway.

So caveat emptor.

              Linus

