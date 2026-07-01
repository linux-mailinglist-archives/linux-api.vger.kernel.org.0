Return-Path: <linux-api+bounces-6749-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id agE+DDiRRGoixAoAu9opvQ
	(envelope-from <linux-api+bounces-6749-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 01 Jul 2026 06:02:00 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D806E99A9
	for <lists+linux-api@lfdr.de>; Wed, 01 Jul 2026 06:01:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=T+TN43gB;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6749-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6749-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B102F3023DBD
	for <lists+linux-api@lfdr.de>; Wed,  1 Jul 2026 04:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A82378D8B;
	Wed,  1 Jul 2026 04:01:24 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCD5377EC2
	for <linux-api@vger.kernel.org>; Wed,  1 Jul 2026 04:01:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878484; cv=pass; b=UH9CH11XHEyOT3GpifhbHni3yxMEvBTV8yipdcwrsf//c25qWZHCnBCalJ096fa03oxWNgbsilNonXbpS1MyrxVZrj7jeUIioUGAnmmPLzX56N4D0+MwYtvmqnrPLA1AIcW1K9gDRsX7aGSXwM44qEBWCD+LN3xTVOAdS81vujQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878484; c=relaxed/simple;
	bh=nbcaEzsRX9Wd5cutUSGHKNyzPWPZ9Pa/dME/ipm/wTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sF/vFt2iR/YYbhbQ1lgOfB5YBXLft0j1DPuFncP3HjvUNaqmrjp3NnqJmDutbGStIGlxXajjaS556wCvkUamOqDwnK494D/dOe44G6sBaJbgLa/miBh5cBQ2IJXyZ+8dG3RojFJ8UVdfusiM+LtwNIf3kI48Pc/Fn3B9eN2VeIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+TN43gB; arc=pass smtp.client-ip=209.85.218.50
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c128c8c7a76so40626466b.0
        for <linux-api@vger.kernel.org>; Tue, 30 Jun 2026 21:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782878478; cv=none;
        d=google.com; s=arc-20260327;
        b=MbutS9maWyR5OCWfyqUqD7fa8gI3Vzn5Rnk/gX08990S4TAOgYdkJLiFz/tp2D5JuO
         TAlogwWr9U4Ez3ipZ0TMbSUHLyuFB21C3HcKpkbc+dQ+iAwPHT2l5aPSj2c828rRY1aw
         NvEin5rLHWVuJurhl/a4cJObyKPpV1alWsK8+nsHTQKCFdduxOzYBldnWYNjH/f0H6yc
         IFxzfV4WpSbBTcdf35vewk95gdIcm3P2wpvtlGJLv8BUqclDiXRTKOtb0t6o28DI5mIk
         /nrc/F78TwKar03g0io3BJzvWNsz31SE2Q1egI7LFcfCfDa6BmY2T2ZaJ0MBEKvkXGds
         xaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nbcaEzsRX9Wd5cutUSGHKNyzPWPZ9Pa/dME/ipm/wTw=;
        fh=ESgbYPRQXLSPTcCik9T3nHNlHlvcP9n/GCe78w7YJGE=;
        b=KNOYb2Tq6NQtxgDjFIoN2BbX/k3UROA34nqCdOtC5W1YI8+9W6eX6Pc2jBTDmHiwFw
         2hJhfLRr9BhVzt34dAwv3cBrZYO2VQcp8qboU8Lpggj2BtWctwN0WhuJuqc9CIlWzTxF
         nfSeeaCdmNsCjx0+Uic4KEssW9WdzV2FfB1oLmwoz+0HQX7VsF/MCwCmIxYo84deVnZh
         T4XLRCYB0vNzkixen1mXvR8Byte5HfKS6HkbIc6lCD264nLvmY5lvT/BsLRgEY8LIClx
         KemOAzy1L6GyD6p6XNOVlO+ZCjQT/JdjYrHRARwltHUWSLFYk0lk4ki3KdlkMaWQyUm2
         M4oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782878478; x=1783483278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbcaEzsRX9Wd5cutUSGHKNyzPWPZ9Pa/dME/ipm/wTw=;
        b=T+TN43gBQVKrBdVmq3uBpm9OUZnWTc73cJaWcOQyH2zC5IFTKsqSbnW459D3TOkP1r
         T85xFxouLO0ID5qQP8ltAvZFmnSP6R1IFhEKTp8CRE4apE2+G58EGxok+Lpu/rvALvXB
         wzTm7KHngZ+6esh8D4Q778IWDHLYa25cITYjwEJ7J1pcHQPcE6tMNHobsAl9NWE9MyrX
         AInBI6vTtramaQ6gDyatXRPVXYy8CPL8qz9Sf2EmTca/0FX2qTBdP4UhiBrOWfdOdOpd
         nPnaLf7+jVMLQUt3ffEXVZCHhAgtbBGE8007E9mHQ8cwWQti6oLSBKd89yGZ8AO8kSxj
         lUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782878478; x=1783483278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nbcaEzsRX9Wd5cutUSGHKNyzPWPZ9Pa/dME/ipm/wTw=;
        b=nQB7oOHn42jaQ32gvsIvXhMAbOSIBn2+Ear8Doss8ajGRn7kDjP5STnIAr1/eU/vJ4
         Pd54Vstd74ZGreQuMmFcorFlXaxeVSdyRBs5UbFhQMyMijKTDwfYiJ4V/pDsrx4nuGva
         sAoNgU1W+9lg2GMVBGgDaG1vbPqQttkNfFHYEKdL8PYUGjnRdC4coI2W3Vjltk+JHC+K
         o+3Sq9Ssnk7MPvGRI3hpL0r95t5Gtxi6bmbLYRP2SNyQaGlBrb0rZZaH6JaZ1IUfSY5E
         iEoy6hNFA7llMectsSoE34EuOm7z2tkrvqwNG/LVc7PJZ9conNpoCsSK9gJSDe/I+NZT
         Mr1w==
X-Forwarded-Encrypted: i=1; AHgh+RovbZi+AcL2KAS63sRGEk4PyTGJ3isozPzSQVTxY6Tl4RLbeN8wIIQFXzeZtklvFveu0uVSQrLZgww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS4rg/2ehXUaafQOekHtR7pSKTarOKV0jOYD/LTHfgwa3Dqhz8
	FzrXt826WesoUQbS/PpVvQk+uScYB4w+4Ar6/sHb1b5GJmchzQxoi1+w+Tt5DSoBoXL7qFbrZkS
	MIHHDab8BLad7MwpB/SfsHcRohFOt0IU=
X-Gm-Gg: AfdE7ck6ukgUAqcnp6HZWITNa++HZuimykLvze00QsjRKCsgWnH4FDuwaCY10XxqTD3
	j7PWAP+q8askU05T+UtWnztZEWIXUiYkBSaf6RBcKyzVPqsoKDNn6f2vMOjrOjw1jtMTV6bwnH4
	4KtCgS8EKSVKA/PCf7ZAlVCbcGTb1rK0CdATPgBZdJUm13zBKFqvLF2mrpPPN6Ptr3CFNNJNd2O
	HdrqWX4xJ9OEpQU3C36UH+rPo2sogXP2dwW/YrzBN6520XIyArQo1JiFvx2JYxzz+EsVzATTVqf
	TQQ4zdo=
X-Received: by 2002:a17:907:9694:b0:c0d:7c31:26a9 with SMTP id
 a640c23a62f3a-c12a79b53f2mr2792166b.2.1782878477949; Tue, 30 Jun 2026
 21:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <89ea76b3-e956-4232-8180-ee3929adf905@kernel.org>
 <20260625101132.3859505-1-safinaskar@gmail.com> <63f7860c-4f5c-4682-8914-27978b9fbfe1@kernel.org>
 <20260629-bauland-knabbern-abgeladen-c0acbfa62cc2@brauner>
In-Reply-To: <20260629-bauland-knabbern-abgeladen-c0acbfa62cc2@brauner>
From: Askar Safin <safinaskar@gmail.com>
Date: Wed, 1 Jul 2026 07:00:41 +0300
X-Gm-Features: AVVi8CdRVGURQNkveI8Kk-KHYrlO3h9NseHLMt2SfGvb89Oznrvksp3ZeC4J-SY
Message-ID: <CAPnZJGAJROqfCWSeeBu31HsE6nmgxVqHTNeC554S5y1Y-VN19w@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] vmsplice: fix some problems in my previous
 vmsplice patchset
To: Christian Brauner <brauner@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org, avagin@gmail.com, 
	axboe@kernel.dk, collin.funk1@gmail.com, david.laight.linux@gmail.com, 
	dhowells@redhat.com, fuse-devel@lists.linux.dev, hch@infradead.org, 
	jack@suse.cz, joannelkoong@gmail.com, kernel@infinite-source.de, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@amacapital.net, 
	metze@samba.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, torvalds@linux-foundation.org, 
	val@packett.cool, viro@zeniv.linux.org.uk, w@1wt.eu, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:david@kernel.org,m:akpm@linux-foundation.org,m:avagin@gmail.com,m:axboe@kernel.dk,m:collin.funk1@gmail.com,m:david.laight.linux@gmail.com,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:joannelkoong@gmail.com,m:kernel@infinite-source.de,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:luto@amacapital.net,m:metze@samba.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:torvalds@linux-foundation.org,m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:w@1wt.eu,m:willy@infradead.org,m:collinfunk1@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6749-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,gmail.com,kernel.dk,redhat.com,lists.linux.dev,infradead.org,suse.cz,infinite-source.de,vger.kernel.org,kvack.org,amacapital.net,samba.org,szeredi.hu,suse.de,packett.cool,zeniv.linux.org.uk,1wt.eu];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2D806E99A9

On Mon, Jun 29, 2026 at 11:56=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> The amount of regression reports that we got in short succession doesn't
> make it likely that we can merge a plain degradation.

Let me repeat: this v2 patchset fixes all regressions found so far,
except for major CRIU performance regression

--=20
Askar Safin

